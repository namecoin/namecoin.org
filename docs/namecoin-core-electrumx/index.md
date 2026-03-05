---
layout: page
title: "Namecoin Core + ElectrumX on Debian"
---

{::options parse_block_html="true" /}

This guide explains how to deploy a fully verified **Namecoin Core 28.0** node and a **Namecoin ElectrumX** server on Debian.  The ElectrumX instance uses the `protocol-1.4.3-v1` branch, which provides the `blockchain.name.get_value_proof` method.  Remote Electrum-NMC clients can connect over TCP and SSL.

An automated deployment script is included.  This document explains what the script does and how to operate the stack after deployment.

## Architecture

~~~
┌──────────────────────────────────────────────────────────┐
│                     Your Debian Server                    │
│                                                           │
│  ┌─────────────────┐       ┌──────────────────────────┐  │
│  │  Namecoin Core   │ RPC   │  ElectrumX               │  │
│  │  (namecoind)     │◄─────►│  (protocol-1.4.3-v1)     │  │
│  │                  │:8336  │                           │  │
│  │  txindex=1       │       │  COIN=Namecoin            │  │
│  │  Full blockchain │       │  blockchain.name.          │  │
│  │                  │       │    get_value_proof         │  │
│  └─────────────────┘       └──────┬───────┬────────────┘  │
│                                   │       │               │
│                             :50001│ :50002│               │
│                              TCP  │  SSL  │               │
└──────────────────────────────┼───────┼────────────────────┘
                               │       │
                        ┌──────┴───────┴──────┐
                        │   Electrum-NMC       │
                        │   (remote clients)   │
                        └──────────────────────┘
~~~

## Prerequisites

* **Debian 12 (bookworm)** or later (Ubuntu 22.04+ also works)
* Root or sudo access
* At least **20 GB free disk** for blockchain + indexes (SSD strongly recommended)
* At least **4 GB RAM** (8 GB recommended; ElectrumX uses ~1.2 GB cache during sync)
* Internet connectivity

## Quick Start

Download the deployment script and run it as root:

~~~
wget -O deploy.sh https://raw.githubusercontent.com/mstrofnone/namecoin.org/docs/debian-namecoin-electrumx-setup/docs/namecoin-core-electrumx/deploy-namecoin-electrumx.sh
chmod +x deploy.sh
sudo ./deploy.sh
~~~

Options:

| Flag | Effect |
|---|---|
| `--skip-core` | Skip Namecoin Core install (use existing daemon) |
| `--skip-electrumx` | Skip ElectrumX install |
| `--testnet` | Deploy on testnet instead of mainnet |
| `--tor` | Also configure a Tor hidden service |

## What the Script Does

### Phase 1: Download Namecoin Core 28.0

The script auto-detects your CPU architecture and downloads the corresponding tarball from the [Namecoin Core download page]({{ "/download/" | relative_url }}).

Supported architectures: x86_64, aarch64, armv7l, riscv64, ppc64.

### Phase 2: Guix Signature Verification

This is the most important phase.  The script clones the [guix.sigs repository](https://github.com/namecoin/guix.sigs) and performs three checks:

**Check 1 — Reproducibility.**  The `28.0/` directory contains attestations from multiple independent builders.  Each provides a `noncodesigned.SHA256SUMS` file listing the SHA-256 hash of every build artifact.  The script diffs all these files against each other.  If the build is reproducible, they are byte-identical — meaning independent people compiled the same source and got the exact same binary output.

**Check 2 — GPG signatures.**  Each builder signs their `SHA256SUMS` file with their personal GPG key, producing a `.asc` detached signature.  The script verifies each signature.  If the public key is not in your keyring, it warns you with the fingerprint so you can import it:

~~~
gpg --keyserver hkps://keys.openpgp.org --recv-keys <FINGERPRINT>
~~~

Import at least one builder's key before running the script for meaningful GPG verification.

**Check 3 — SHA-256 hash.**  The downloaded `.tar.gz` is hashed and compared against the attested value.  A match means the binary is identical to what the builders independently compiled.

### Phase 3: Install Namecoin Core

Installs `namecoind`, `namecoin-cli`, and `namecoin-tx` to `/usr/local/bin/`.  Creates a `namecoin` system user and writes `namecoin.conf` with:

* `txindex=1` — required by ElectrumX to look up arbitrary transactions
* `server=1` — enables the RPC interface
* Random RPC credentials generated at deploy time

Starts `namecoind` via systemd.  The daemon begins syncing the blockchain immediately.

### Phase 4: Install ElectrumX

Clones [namecoin/electrumx](https://github.com/namecoin/electrumx) on the **`protocol-1.4.3-v1`** branch — the branch that contains `blockchain.name.get_value_proof` in the `NameIndexElectrumX` session class.

Installs in a Python venv under `/home/electrumx/electrumx/venv/`.  Key configuration:

* `COIN=Namecoin` — activates the Namecoin name index and AuxPoW support
* `SERVICES=tcp://:50001,ssl://:50002,rpc://` — listens on both plaintext and SSL
* `COST_SOFT_LIMIT=0` / `COST_HARD_LIMIT=0` — disables rate limiting (adjust for public servers)

The script verifies the source contains `name_get_value_proof` before proceeding.

### Phase 5: SSL + Firewall

Generates a self-signed SSL certificate.  Electrum-NMC clients will pin this certificate on first connection.  Opens ports 50001 (TCP) and 50002 (SSL) via ufw or iptables.

### Phase 6: Optional Tor Hidden Service

With `--tor`, the script installs Tor and configures a hidden service that maps the ElectrumX ports.  The `.onion` address is printed at the end.

## Post-Deployment

### Monitor Sync Progress

Namecoin Core must fully sync before ElectrumX can begin indexing.

~~~
# Namecoin Core sync progress
su - namecoin -c 'namecoin-cli getblockchaininfo' | grep -E 'blocks|verificationprogress'

# ElectrumX indexing progress
journalctl -fu electrumx
~~~

Namecoin Core sync takes roughly 2–8 hours on an SSD.  ElectrumX indexing takes another 2–6 hours after that.

### Connect Electrum-NMC

From a remote machine with [Electrum-NMC]({{ "/docs/electrum-nmc/" | relative_url }}) installed:

~~~
# Connect via SSL (recommended)
electrum-nmc --oneserver --server YOUR_IP:50002:s

# Connect via TCP (plaintext)
electrum-nmc --oneserver --server YOUR_IP:50001:t

# Connect via Tor
electrum-nmc --oneserver --server YOUR_ONION:50001:t --proxy socks5:127.0.0.1:9050
~~~

### Test blockchain.name.get\_value\_proof

Once ElectrumX is fully synced, verify the name proof method is active:

~~~
echo '{"jsonrpc":"2.0","method":"server.version","params":["test","1.4.3"],"id":1}' \
    | nc localhost 50001
~~~

If `server.version` returns 1.4.3, the name proof handler is active.

### Advertise Your Server

Edit `/etc/electrumx.conf` and set:

~~~
REPORT_SERVICES=tcp://YOUR_PUBLIC_IP:50001,ssl://YOUR_PUBLIC_IP:50002
REPORT_HOST=YOUR_PUBLIC_IP
~~~

Then restart: `sudo systemctl restart electrumx`

Your server will appear in Electrum-NMC's server list via peer discovery.

### Manage Services

~~~
# Status
sudo systemctl status namecoind electrumx

# Restart
sudo systemctl restart electrumx

# Stop everything
sudo systemctl stop electrumx namecoind

# View ElectrumX server info
/home/electrumx/electrumx/venv/bin/python3 \
    /home/electrumx/electrumx/electrumx_rpc getinfo
~~~

## How blockchain.name.get\_value\_proof Works

When an Electrum-NMC client calls `name_show` using protocol 1.4.3, it issues a `blockchain.name.get_value_proof` request.  The ElectrumX server responds with:

1. The full name update history for that scripthash, in reverse chronological order.
2. For each update: the raw transaction, a Merkle proof tying the txid to the block header, and (if the block is at or below the client's checkpoint height) a header proof tying the block to the checkpoint.
3. The history stops at the `NAME_EXPIRATION` boundary (36,000 blocks for Namecoin).

The client can then verify the entire chain of name updates without trusting the server.

## Security Notes

* **RPC credentials** are randomly generated and stored in both `namecoin.conf` and `electrumx.conf` with permissions restricted to their respective users.
* **The SSL certificate is self-signed.**  Electrum-NMC clients pin the certificate on first connection.  If you regenerate it, clients will need to reconnect.
* **ElectrumX trusts the daemon.**  If Namecoin Core is compromised, ElectrumX will relay bad data.  This is why `txindex=1` and a full sync are non-negotiable.
* **Guix verification** with no GPG keys in your keyring still gives you the reproducibility check, but not authentication.  Import at least one builder's key for meaningful GPG verification.

## Troubleshooting

**ElectrumX exits immediately after starting:**  Check `journalctl -fu electrumx`.  The most common cause is Namecoin Core not being synced yet, or wrong RPC credentials.

**"method not found" for blockchain.name.get\_value\_proof:**  Verify ElectrumX is on the correct branch: `cd /home/electrumx/electrumx && git branch` should show `protocol-1.4.3-v1`.

**plyvel installation fails:**  Install LevelDB headers: `sudo apt install libleveldb-dev`

**ElectrumX indexing is very slow:**  Increase `CACHE_MB` in `/etc/electrumx.conf`.  Use an SSD.

**Namecoin Core stuck syncing:**  Increase `dbcache` in `namecoin.conf` (default 450, try 1024).  Restart with `sudo systemctl restart namecoind`.

**Cannot connect from Electrum-NMC:**  Check firewall ports (50001, 50002).  Verify ElectrumX is listening: `ss -tlnp | grep -E '50001|50002'`.

## File Locations

| Component | Path |
|---|---|
| Namecoin Core binaries | `/usr/local/bin/namecoind`, `namecoin-cli` |
| Namecoin Core config | `/home/namecoin/.namecoin/namecoin.conf` |
| Namecoin Core data | `/home/namecoin/.namecoin/` |
| Namecoin Core service | `/etc/systemd/system/namecoind.service` |
| ElectrumX source | `/home/electrumx/electrumx/` |
| ElectrumX venv | `/home/electrumx/electrumx/venv/` |
| ElectrumX config | `/etc/electrumx.conf` |
| ElectrumX database | `/home/electrumx/db/` |
| ElectrumX service | `/etc/systemd/system/electrumx.service` |
| SSL certificate | `/home/electrumx/ssl/server.crt` |
| SSL private key | `/home/electrumx/ssl/server.key` |
| Tor hidden service | `/var/lib/tor/electrumx/hostname` |
