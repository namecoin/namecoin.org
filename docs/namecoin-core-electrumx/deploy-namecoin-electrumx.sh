#!/usr/bin/env bash
# deploy-namecoin-electrumx.sh
#
# Deploys a verified Namecoin Core 28.0 node + Namecoin ElectrumX (protocol-1.4.3-v1)
# accessible to Electrum-NMC clients over the internet on Debian.
#
# Usage:
#   sudo ./deploy-namecoin-electrumx.sh [--skip-core] [--skip-electrumx] [--testnet]
#
# Prerequisites:
#   - Debian 12 (bookworm) or later, freshly installed
#   - Root or sudo access
#   - At least 20GB free disk (SSD strongly recommended)
#   - At least 4GB RAM (8GB recommended)
#
# What this script does:
#   Phase 1: Downloads Namecoin Core 28.0 binary for your architecture
#   Phase 2: Verifies it against guix.sigs (GPG + SHA256 + reproducibility diff)
#   Phase 3: Installs and configures Namecoin Core as a systemd service
#   Phase 4: Clones, installs, and configures Namecoin ElectrumX (protocol-1.4.3-v1)
#   Phase 5: Generates a self-signed SSL cert and opens firewall ports
#   Phase 6: Optionally configures a Tor hidden service
#
# After running, Namecoin Core will begin syncing the blockchain. ElectrumX will
# start indexing once the daemon is caught up. Full sync takes hours to days
# depending on hardware.

set -euo pipefail
export LC_ALL=C

# ─────────────────────────────────────────────
#  Configuration — edit these before running
# ─────────────────────────────────────────────

NMC_VERSION="28.0"
NMC_DOWNLOAD_BASE="https://www.namecoin.org/files/namecoin-core/namecoin-core-${NMC_VERSION}"
GUIX_SIGS_REPO="https://github.com/namecoin/guix.sigs.git"
ELECTRUMX_REPO="https://github.com/namecoin/electrumx.git"
ELECTRUMX_BRANCH="protocol-1.4.3-v1"

# RPC credentials — CHANGE THESE
RPC_USER="nmcrpc"
RPC_PASS="$(head -c 32 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 32)"

# Network
NET="mainnet"
ELECTRUMX_TCP_PORT=50001
ELECTRUMX_SSL_PORT=50002

# Directories
NMC_DATADIR="/home/namecoin/.namecoin"
ELECTRUMX_DBDIR="/home/electrumx/db"

# Parse arguments
SKIP_CORE=0
SKIP_ELECTRUMX=0
SETUP_TOR=0
for arg in "$@"; do
    case "$arg" in
        --skip-core) SKIP_CORE=1 ;;
        --skip-electrumx) SKIP_ELECTRUMX=1 ;;
        --testnet) NET="testnet" ;;
        --tor) SETUP_TOR=1 ;;
        --help|-h)
            echo "Usage: sudo $0 [--skip-core] [--skip-electrumx] [--testnet] [--tor]"
            exit 0
            ;;
    esac
done

# ─────────────────────────────────────────────
#  Helper functions
# ─────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
fail()  { echo -e "${RED}[FAIL]${NC}  $*"; exit 1; }

check_root() {
    if [[ $EUID -ne 0 ]]; then
        fail "This script must be run as root (use sudo)"
    fi
}

detect_arch() {
    local machine
    machine="$(uname -m)"
    case "$machine" in
        x86_64)  ARCH="x86_64-linux-gnu" ;;
        aarch64) ARCH="aarch64-linux-gnu" ;;
        armv7l)  ARCH="arm-linux-gnueabihf" ;;
        riscv64) ARCH="riscv64-linux-gnu" ;;
        ppc64)   ARCH="powerpc64-linux-gnu" ;;
        *)       fail "Unsupported architecture: $machine" ;;
    esac
    NMC_TARBALL="namecoin-${NMC_VERSION}-${ARCH}.tar.gz"
    NMC_URL="${NMC_DOWNLOAD_BASE}/${NMC_TARBALL}"
    info "Detected architecture: $ARCH"
}

# ─────────────────────────────────────────────
#  Phase 0: Install system dependencies
# ─────────────────────────────────────────────

install_deps() {
    info "Installing system dependencies..."
    apt-get update -qq
    apt-get install -y -qq \
        gnupg curl wget git \
        python3 python3-pip python3-dev python3-venv \
        build-essential libleveldb-dev libssl-dev \
        openssl \
        > /dev/null 2>&1
    ok "System dependencies installed"
}

# ─────────────────────────────────────────────
#  Phase 1: Download Namecoin Core binary
# ─────────────────────────────────────────────

download_core() {
    local workdir="/tmp/namecoin-deploy"
    mkdir -p "$workdir"
    cd "$workdir"

    if [[ -f "$NMC_TARBALL" ]]; then
        info "Tarball already exists: $NMC_TARBALL"
    else
        info "Downloading Namecoin Core ${NMC_VERSION} for ${ARCH}..."
        wget -q --show-progress "$NMC_URL" -O "$NMC_TARBALL" \
            || fail "Download failed. Check your architecture and network."
        ok "Downloaded $NMC_TARBALL"
    fi
}

# ─────────────────────────────────────────────
#  Phase 2: Verify against guix.sigs
# ─────────────────────────────────────────────

verify_guix_sigs() {
    local workdir="/tmp/namecoin-deploy"
    cd "$workdir"

    info "Cloning guix.sigs repository..."
    if [[ -d guix.sigs ]]; then
        cd guix.sigs && git pull -q && cd ..
    else
        git clone -q "$GUIX_SIGS_REPO"
    fi

    local sigdir="guix.sigs/${NMC_VERSION}"
    if [[ ! -d "$sigdir" ]]; then
        fail "No guix.sigs found for version ${NMC_VERSION}"
    fi

    # Collect all signers
    local signers=()
    for d in "$sigdir"/*/; do
        [[ -d "$d" ]] && signers+=("$(basename "$d")")
    done

    if [[ ${#signers[@]} -eq 0 ]]; then
        fail "No attestations found in $sigdir"
    fi
    info "Found ${#signers[@]} attestation(s): ${signers[*]}"

    # ── Step 1: Reproducibility check ──
    # All signers' SHA256SUMS files must be byte-identical.
    # This proves the build is reproducible: independent builders got the same output.
    info "Checking reproducibility (all attestations must be identical)..."
    local reference="${sigdir}/${signers[0]}/noncodesigned.SHA256SUMS"
    local repro_ok=1
    for signer in "${signers[@]:1}"; do
        local current="${sigdir}/${signer}/noncodesigned.SHA256SUMS"
        if ! diff -q "$reference" "$current" > /dev/null 2>&1; then
            warn "MISMATCH: ${signers[0]} vs $signer — SHA256SUMS files differ!"
            repro_ok=0
        fi
    done
    if [[ $repro_ok -eq 1 ]]; then
        ok "Reproducibility check passed: all ${#signers[@]} attestations are identical"
    else
        fail "Reproducibility check FAILED — builds are not identical across signers"
    fi

    # ── Step 2: GPG signature verification ──
    # Each signer's .asc is a detached GPG signature over their SHA256SUMS.
    # We try to verify each one. If the public key isn't in our keyring,
    # we warn but don't fail — the user may only trust specific signers.
    info "Verifying GPG signatures..."
    local gpg_good=0
    local gpg_unknown=0
    for signer in "${signers[@]}"; do
        local sums="${sigdir}/${signer}/noncodesigned.SHA256SUMS"
        local sig="${sums}.asc"
        if [[ ! -f "$sig" ]]; then
            warn "No .asc for signer '$signer', skipping"
            continue
        fi

        # Try to verify; capture output
        local gpg_out
        if gpg_out=$(gpg --batch --verify "$sig" "$sums" 2>&1); then
            ok "GPG signature VALID for signer: $signer"
            gpg_good=$((gpg_good + 1))
        else
            if echo "$gpg_out" | grep -q "No public key"; then
                warn "GPG key not in keyring for signer: $signer"
                warn "  Fingerprint from signature:"
                echo "$gpg_out" | grep -oP 'RSA key \K[A-F0-9]+' | head -1 | sed 's/^/    /'
                warn "  Import with: gpg --keyserver hkps://keys.openpgp.org --recv-keys <FINGERPRINT>"
                gpg_unknown=$((gpg_unknown + 1))
            else
                warn "GPG signature FAILED for signer: $signer"
                echo "$gpg_out" | sed 's/^/    /'
            fi
        fi
    done

    if [[ $gpg_good -eq 0 && $gpg_unknown -eq ${#signers[@]} ]]; then
        warn "No GPG keys in keyring — cannot verify signatures."
        warn "The SHA256 hashes still match across all signers (reproducibility OK)."
        warn "For full verification, import at least one signer's GPG key and re-run."
        echo ""
        echo "  Signers who attested to this build:"
        for signer in "${signers[@]}"; do
            local sig="${sigdir}/${signer}/noncodesigned.SHA256SUMS.asc"
            local fpr
            fpr=$(gpg --batch --verify "$sig" "${sig%.asc}" 2>&1 | grep -oP 'RSA key \K[A-F0-9]+' | head -1 || true)
            echo "    $signer  (key: ${fpr:-unknown})"
        done
        echo ""
        read -rp "Continue anyway with SHA256 verification only? [y/N] " reply
        [[ "$reply" =~ ^[Yy]$ ]] || fail "Aborted by user"
    elif [[ $gpg_good -gt 0 ]]; then
        ok "GPG verification: $gpg_good valid signature(s)"
    fi

    # ── Step 3: SHA256 hash verification ──
    # Check the downloaded binary against the attested hashes.
    info "Verifying SHA256 hash of downloaded binary..."
    local expected_hash
    expected_hash=$(grep "$NMC_TARBALL" "$reference" | awk '{print $1}')
    if [[ -z "$expected_hash" ]]; then
        fail "Binary '$NMC_TARBALL' not found in SHA256SUMS"
    fi

    local actual_hash
    actual_hash=$(sha256sum "$workdir/$NMC_TARBALL" | awk '{print $1}')

    if [[ "$expected_hash" == "$actual_hash" ]]; then
        ok "SHA256 match: $actual_hash"
        ok "Binary verification PASSED"
    else
        fail "SHA256 MISMATCH!\n  Expected: $expected_hash\n  Got:      $actual_hash"
    fi
}

# ─────────────────────────────────────────────
#  Phase 3: Install and configure Namecoin Core
# ─────────────────────────────────────────────

install_core() {
    local workdir="/tmp/namecoin-deploy"
    cd "$workdir"

    info "Installing Namecoin Core ${NMC_VERSION}..."

    # Extract
    tar xzf "$NMC_TARBALL"
    local extracted="namecoin-${NMC_VERSION}"

    # Install binaries
    install -m 0755 -o root -g root \
        "${extracted}/bin/namecoind" \
        "${extracted}/bin/namecoin-cli" \
        "${extracted}/bin/namecoin-tx" \
        /usr/local/bin/

    # Also install namecoin-qt if present (headless servers won't use it)
    if [[ -f "${extracted}/bin/namecoin-qt" ]]; then
        install -m 0755 -o root -g root "${extracted}/bin/namecoin-qt" /usr/local/bin/
    fi

    ok "Binaries installed to /usr/local/bin/"

    # Create user
    if ! id -u namecoin &>/dev/null; then
        adduser --disabled-password --gecos "" namecoin
        ok "Created user: namecoin"
    fi

    # Configure
    mkdir -p "$NMC_DATADIR"

    local rpc_port=8336
    local p2p_port=8334
    local nmc_conf="${NMC_DATADIR}/namecoin.conf"

    if [[ "$NET" == "testnet" ]]; then
        rpc_port=18336
        p2p_port=18334
    fi

    cat > "$nmc_conf" <<NMCCONF
# Namecoin Core ${NMC_VERSION} configuration
# Generated by deploy-namecoin-electrumx.sh

# Network
$([ "$NET" == "testnet" ] && echo "testnet=1" || echo "# mainnet")
server=1
listen=1
txindex=1

# RPC
rpcuser=${RPC_USER}
rpcpassword=${RPC_PASS}
rpcallowip=127.0.0.1
rpcbind=127.0.0.1

# Performance
dbcache=450
maxmempool=300

# Logging
printtoconsole=0
NMCCONF

    chown -R namecoin:namecoin "$NMC_DATADIR"
    chmod 600 "$nmc_conf"
    ok "Configuration written to $nmc_conf"

    # Store RPC credentials for ElectrumX to read later
    echo "${RPC_USER}:${RPC_PASS}:${rpc_port}" > /tmp/namecoin-deploy/rpc-creds
    chmod 600 /tmp/namecoin-deploy/rpc-creds

    # systemd service
    cat > /etc/systemd/system/namecoind.service <<NMCSVC
[Unit]
Description=Namecoin Core Daemon
After=network-online.target
Wants=network-online.target

[Service]
Type=forking
User=namecoin
Group=namecoin
ExecStart=/usr/local/bin/namecoind -daemon -conf=${nmc_conf} -datadir=${NMC_DATADIR}
ExecStop=/usr/local/bin/namecoin-cli -conf=${nmc_conf} -datadir=${NMC_DATADIR} stop
TimeoutStopSec=600
Restart=on-failure
RestartSec=30
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
NMCSVC

    systemctl daemon-reload
    systemctl enable namecoind
    systemctl start namecoind
    ok "Namecoin Core started and enabled"

    # Wait briefly and check
    sleep 3
    if systemctl is-active --quiet namecoind; then
        local blockcount
        blockcount=$(su - namecoin -c "namecoin-cli -conf=${nmc_conf} getblockcount" 2>/dev/null || echo "connecting...")
        ok "Namecoin Core is running (blocks: $blockcount)"
    else
        warn "Namecoin Core may still be starting up — check: journalctl -fu namecoind"
    fi
}

# ─────────────────────────────────────────────
#  Phase 4: Install and configure ElectrumX
# ─────────────────────────────────────────────

install_electrumx() {
    info "Installing Namecoin ElectrumX (${ELECTRUMX_BRANCH})..."

    # Read RPC creds
    local rpc_creds
    if [[ -f /tmp/namecoin-deploy/rpc-creds ]]; then
        rpc_creds=$(cat /tmp/namecoin-deploy/rpc-creds)
    else
        # Fallback: ask
        echo "RPC credentials file not found."
        read -rp "RPC user: " RPC_USER
        read -rsp "RPC password: " RPC_PASS; echo
        read -rp "RPC port [8336]: " rpc_port_input
        rpc_creds="${RPC_USER}:${RPC_PASS}:${rpc_port_input:-8336}"
    fi
    local rpc_user rpc_pass rpc_port
    IFS=: read -r rpc_user rpc_pass rpc_port <<< "$rpc_creds"

    # Create user
    if ! id -u electrumx &>/dev/null; then
        adduser --disabled-password --gecos "" electrumx
        ok "Created user: electrumx"
    fi

    # Clone repo on the correct branch
    local exdir="/home/electrumx/electrumx"
    if [[ -d "$exdir" ]]; then
        cd "$exdir"
        git fetch -q origin
        git checkout -q "$ELECTRUMX_BRANCH"
        git pull -q origin "$ELECTRUMX_BRANCH"
    else
        su - electrumx -s /bin/bash -c \
            "git clone -b ${ELECTRUMX_BRANCH} ${ELECTRUMX_REPO} ${exdir}"
    fi
    ok "Cloned ElectrumX on branch: $ELECTRUMX_BRANCH"

    # Verify we have the right code
    if ! grep -q "name_get_value_proof" "${exdir}/electrumx/server/session.py"; then
        fail "blockchain.name.get_value_proof not found in session.py — wrong branch?"
    fi
    ok "Confirmed: blockchain.name.get_value_proof is present in source"

    # Python venv and install
    info "Setting up Python virtual environment..."
    su - electrumx -s /bin/bash -c "
        cd ${exdir}
        python3 -m venv venv
        source venv/bin/activate
        pip install --upgrade pip > /dev/null 2>&1
        pip install . > /dev/null 2>&1
    "
    ok "ElectrumX installed in venv"

    # Create DB directory
    mkdir -p "$ELECTRUMX_DBDIR"
    chown electrumx:electrumx "$ELECTRUMX_DBDIR"

    # Generate self-signed SSL certificate for Electrum-NMC clients
    info "Generating self-signed SSL certificate..."
    local ssl_dir="/home/electrumx/ssl"
    mkdir -p "$ssl_dir"
    openssl req -newkey rsa:2048 -sha256 -nodes \
        -x509 -days 3650 \
        -keyout "${ssl_dir}/server.key" \
        -out "${ssl_dir}/server.crt" \
        -subj "/CN=namecoin-electrumx" \
        2>/dev/null
    chown -R electrumx:electrumx "$ssl_dir"
    chmod 600 "${ssl_dir}/server.key"
    ok "SSL certificate generated"

    # ElectrumX configuration
    local daemon_url="http://${rpc_user}:${rpc_pass}@127.0.0.1:${rpc_port}/"

    cat > /etc/electrumx.conf <<EXCONF
# Namecoin ElectrumX configuration
# Generated by deploy-namecoin-electrumx.sh
#
# Branch: ${ELECTRUMX_BRANCH}
# Provides: blockchain.name.get_value_proof (protocol >= 1.4.3)

COIN=Namecoin
NET=${NET}
DB_DIRECTORY=${ELECTRUMX_DBDIR}
DB_ENGINE=leveldb
DAEMON_URL=${daemon_url}

# Services — accessible from the internet
# tcp: plaintext Electrum protocol (port ${ELECTRUMX_TCP_PORT})
# ssl: encrypted Electrum protocol (port ${ELECTRUMX_SSL_PORT})
# rpc: local admin RPC
SERVICES=tcp://:${ELECTRUMX_TCP_PORT},ssl://:${ELECTRUMX_SSL_PORT},rpc://

# SSL
SSL_CERTFILE=${ssl_dir}/server.crt
SSL_KEYFILE=${ssl_dir}/server.key

# Advertise to peer discovery (edit with your public hostname/IP)
# REPORT_SERVICES=tcp://YOUR_PUBLIC_IP:${ELECTRUMX_TCP_PORT},ssl://YOUR_PUBLIC_IP:${ELECTRUMX_SSL_PORT}
# REPORT_HOST=YOUR_PUBLIC_IP

# Performance
CACHE_MB=1200
# EVENT_LOOP_POLICY=uvloop

# Rate limiting — set to 0 for private use, or leave defaults for public
COST_SOFT_LIMIT=0
COST_HARD_LIMIT=0

# Logging
LOG_LEVEL=info
EXCONF

    chmod 600 /etc/electrumx.conf
    ok "ElectrumX configuration written to /etc/electrumx.conf"

    # Increase file descriptor limits
    if ! grep -q "electrumx" /etc/security/limits.conf 2>/dev/null; then
        echo "electrumx soft nofile 8192" >> /etc/security/limits.conf
        echo "electrumx hard nofile 65536" >> /etc/security/limits.conf
    fi

    # systemd service
    cat > /etc/systemd/system/electrumx.service <<EXSVC
[Unit]
Description=Namecoin ElectrumX Server (protocol-1.4.3-v1)
After=network.target namecoind.service
Requires=namecoind.service

[Service]
EnvironmentFile=/etc/electrumx.conf
ExecStart=${exdir}/venv/bin/python3 ${exdir}/electrumx_server
User=electrumx
Group=electrumx
LimitNOFILE=8192
TimeoutStopSec=30min
Restart=on-failure
RestartSec=30

[Install]
WantedBy=multi-user.target
EXSVC

    systemctl daemon-reload
    systemctl enable electrumx
    systemctl start electrumx
    ok "ElectrumX started and enabled"

    sleep 3
    if systemctl is-active --quiet electrumx; then
        ok "ElectrumX is running"
    else
        warn "ElectrumX may be waiting for Namecoin Core to sync — check: journalctl -fu electrumx"
    fi
}

# ─────────────────────────────────────────────
#  Phase 5: Firewall
# ─────────────────────────────────────────────

configure_firewall() {
    info "Configuring firewall..."

    # Namecoin P2P
    local p2p_port=8334
    [[ "$NET" == "testnet" ]] && p2p_port=18334

    if command -v ufw &>/dev/null; then
        ufw allow "$p2p_port"/tcp comment "Namecoin P2P" > /dev/null 2>&1 || true
        ufw allow "$ELECTRUMX_TCP_PORT"/tcp comment "ElectrumX TCP" > /dev/null 2>&1 || true
        ufw allow "$ELECTRUMX_SSL_PORT"/tcp comment "ElectrumX SSL" > /dev/null 2>&1 || true
        ok "UFW rules added"
    elif command -v iptables &>/dev/null; then
        iptables -A INPUT -p tcp --dport "$p2p_port" -j ACCEPT 2>/dev/null || true
        iptables -A INPUT -p tcp --dport "$ELECTRUMX_TCP_PORT" -j ACCEPT 2>/dev/null || true
        iptables -A INPUT -p tcp --dport "$ELECTRUMX_SSL_PORT" -j ACCEPT 2>/dev/null || true
        ok "iptables rules added (not persisted — install iptables-persistent to save)"
    else
        warn "No firewall tool found — manually open ports $p2p_port, $ELECTRUMX_TCP_PORT, $ELECTRUMX_SSL_PORT"
    fi
}

# ─────────────────────────────────────────────
#  Phase 6: Optional Tor hidden service
# ─────────────────────────────────────────────

setup_tor() {
    info "Setting up Tor hidden service..."

    apt-get install -y -qq tor > /dev/null 2>&1

    # Add hidden service config if not already present
    if ! grep -q "electrumx" /etc/tor/torrc 2>/dev/null; then
        cat >> /etc/tor/torrc <<TORCONF

# Namecoin ElectrumX hidden service
HiddenServiceDir /var/lib/tor/electrumx/
HiddenServicePort ${ELECTRUMX_TCP_PORT} 127.0.0.1:${ELECTRUMX_TCP_PORT}
HiddenServicePort ${ELECTRUMX_SSL_PORT} 127.0.0.1:${ELECTRUMX_SSL_PORT}
TORCONF
        systemctl restart tor
        sleep 5
    fi

    local onion_file="/var/lib/tor/electrumx/hostname"
    if [[ -f "$onion_file" ]]; then
        local onion
        onion=$(cat "$onion_file")
        ok "Tor hidden service: $onion"
        echo ""
        echo "  Add to /etc/electrumx.conf:"
        echo "    REPORT_HOST_TOR=${onion}"
        echo "    REPORT_TCP_PORT_TOR=${ELECTRUMX_TCP_PORT}"
        echo "    REPORT_SSL_PORT_TOR=${ELECTRUMX_SSL_PORT}"
    else
        warn "Tor hostname file not yet created — check: sudo systemctl status tor"
    fi
}

# ─────────────────────────────────────────────
#  Phase 7: Summary
# ─────────────────────────────────────────────

print_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e " ${GREEN}Deployment complete${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo " Namecoin Core ${NMC_VERSION}"
    echo "   Config:    ${NMC_DATADIR}/namecoin.conf"
    echo "   Data:      ${NMC_DATADIR}"
    echo "   Service:   systemctl status namecoind"
    echo "   Logs:      journalctl -fu namecoind"
    echo "   CLI:       su - namecoin -c 'namecoin-cli getblockchaininfo'"
    echo ""
    echo " ElectrumX (${ELECTRUMX_BRANCH})"
    echo "   Config:    /etc/electrumx.conf"
    echo "   Database:  ${ELECTRUMX_DBDIR}"
    echo "   Service:   systemctl status electrumx"
    echo "   Logs:      journalctl -fu electrumx"
    echo "   TCP:       port ${ELECTRUMX_TCP_PORT}"
    echo "   SSL:       port ${ELECTRUMX_SSL_PORT}"
    echo "   SSL cert:  /home/electrumx/ssl/server.crt"
    echo ""
    echo " RPC credentials (saved to /etc/electrumx.conf):"
    echo "   User:      ${RPC_USER}"
    echo "   Password:  (see /etc/electrumx.conf or ${NMC_DATADIR}/namecoin.conf)"
    echo ""
    echo " ┌─────────────────────────────────────────────────┐"
    echo " │  IMPORTANT: Namecoin Core must fully sync       │"
    echo " │  before ElectrumX can index. This takes hours   │"
    echo " │  to days. Monitor with:                         │"
    echo " │                                                 │"
    echo " │    journalctl -fu namecoind                     │"
    echo " │    journalctl -fu electrumx                     │"
    echo " │                                                 │"
    echo " │  Once synced, Electrum-NMC clients can connect: │"
    echo " │    electrum-nmc --oneserver \\                    │"
    echo " │      --server YOUR_IP:${ELECTRUMX_SSL_PORT}:s              │"
    echo " └─────────────────────────────────────────────────┘"
    echo ""

    # Edit REPORT_SERVICES reminder
    echo " To advertise your server for peer discovery, edit /etc/electrumx.conf:"
    echo "   REPORT_SERVICES=tcp://YOUR_IP:${ELECTRUMX_TCP_PORT},ssl://YOUR_IP:${ELECTRUMX_SSL_PORT}"
    echo "   REPORT_HOST=YOUR_IP"
    echo " Then: systemctl restart electrumx"
    echo ""

    # Cleanup
    rm -f /tmp/namecoin-deploy/rpc-creds
}

# ─────────────────────────────────────────────
#  Main
# ─────────────────────────────────────────────

main() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " Namecoin Core + ElectrumX Deployment Script"
    echo " Core:      nc${NMC_VERSION} (from namecoin.org)"
    echo " ElectrumX: ${ELECTRUMX_BRANCH} (blockchain.name.get_value_proof)"
    echo " Network:   ${NET}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    check_root
    detect_arch
    install_deps

    if [[ $SKIP_CORE -eq 0 ]]; then
        download_core
        verify_guix_sigs
        install_core
    else
        info "Skipping Namecoin Core (--skip-core)"
    fi

    if [[ $SKIP_ELECTRUMX -eq 0 ]]; then
        install_electrumx
        configure_firewall
    else
        info "Skipping ElectrumX (--skip-electrumx)"
    fi

    if [[ $SETUP_TOR -eq 1 ]]; then
        setup_tor
    fi

    print_summary
}

main "$@"
