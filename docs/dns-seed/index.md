---
layout: page
title: Running a Namecoin DNS Seed
---

{::options parse_block_html="true" /}

A DNS seed is a server that crawls the Namecoin P2P network, maintains a list of healthy nodes, and serves their IP addresses via DNS responses.  When a fresh Namecoin Core node starts up, it queries DNS seeds to find its first peers.

Namecoin currently has very few mainnet DNS seeds, so running one is a high-impact contribution.  Typical bandwidth usage is approximately 2.5 MB per day.

## Prerequisites

* A server or VPS running **Debian** (12 Bookworm or later) with a **static public IP** (IPv4; IPv6 also recommended)
* A **domain name** you control (to delegate a subdomain as the seed)
* Port **53/udp** reachable from the internet
* **Go 1.15+** (installation covered below)

## Step 1: DNS Configuration

Choose a subdomain to dedicate as your seed hostname.  For example:

~~~
Seed domain:       nmc-seed.example.com
Nameserver domain: ns-seed.example.com
~~~

At your domain registrar or DNS provider, create these records:

~~~
;; Point the nameserver hostname to your server IP
ns-seed.example.com.    IN  A       203.0.113.50
ns-seed.example.com.    IN  AAAA    2001:db8::50    ; optional but recommended

;; Delegate the seed subdomain to your server
nmc-seed.example.com.   IN  NS      ns-seed.example.com.
~~~

**Important:** Do NOT create an A/AAAA record for `nmc-seed.example.com` itself.  The NS delegation tells resolvers to ask your seeder directly, and the seeder will reply with Namecoin node IPs.

## Step 2: Install Go and Build the Seeder

This guide uses the [gombadi/dnsseeder](https://github.com/gombadi/dnsseeder), which is the seeder recommended by the Namecoin project.  It ships with a `namecoin.json` config file.

**Important:** The upstream repository does not currently generate SOA or NS records, and its `handleDNS()` switch falls through to `UNKNOWN` for SOA queries — never matching a map key.  Modern recursive resolvers expect an authoritative nameserver to answer SOA queries; without SOA/NS responses many resolvers treat the zone as broken and cache SERVFAIL, making the seed effectively unreachable via normal DNS resolution.  Until [these fixes](https://github.com/gombadi/dnsseeder/compare/master...mstrofnone:dnsseeder:master) are merged upstream, use the [mstrofnone/dnsseeder](https://github.com/mstrofnone/dnsseeder) fork which adds synthetic SOA and NS record generation ([`388ad4b`](https://github.com/gombadi/dnsseeder/commit/388ad4bc48796bdfd1e2d49ebbaa56896ca797c0)).

### Option A: Automated deploy script (recommended)

The fork includes a `deploy-debian.sh` script ([`f36b4fa`](https://github.com/gombadi/dnsseeder/commit/f36b4fa6a8c6797e31552af339a7b10418c55f5f)) that handles the entire setup — installing Go, building the seeder, creating a systemd service, and configuring iptables port-53 redirection:

~~~
git clone https://github.com/mstrofnone/dnsseeder.git
cd dnsseeder

# Review the script, then run:
sudo ./deploy-debian.sh
~~~

Run `sudo ./deploy-debian.sh --help` for options (`--dns-port`, `--web-port`, `--netfile`, `--skip-iptables`, `--uninstall`).  After it finishes, skip ahead to [Step 3](#step-3-configure-for-namecoin) to edit the config files in `/opt/dnsseeder/configs/`, then restart the service with `sudo systemctl restart dnsseeder`.

### Option B: Manual build

~~~
# Install build dependencies
sudo apt update
sudo apt install -y wget git

# Install Go (see https://go.dev/dl/ for the latest version)
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Clone and build the seeder (use the fork with SOA/NS fixes)
mkdir -p $GOPATH/src/github.com/gombadi
cd $GOPATH/src/github.com/gombadi
git clone https://github.com/mstrofnone/dnsseeder.git
cd dnsseeder
go install
~~~

The binary will be at `$GOPATH/bin/dnsseeder`.

## Step 3: Configure for Namecoin

The repo ships with config files in the `configs/` directory, including a `namecoin.json`.  If it is not present or you want to create one from scratch, save the following as `namecoin.json`:

~~~
{
    "Name": "namecoin",
    "Description": "Namecoin Mainnet",
    "DNSName": "nmc-seed.example.com",
    "Port": 8334,
    "Pver": 70016,
    "TTL": 600,
    "InitialIP": "",
    "Magic": "f9beb4fe",
    "Secret": false,
    "MaxSize": 25,
    "MaxStart": 25
}
~~~

Replace `nmc-seed.example.com` with your actual seed subdomain.

Key fields:

* **`DNSName`** — your seed subdomain (the hostname clients will query)
* **`Port`** (`8334`) — Namecoin mainnet P2P port
* **`Pver`** (`70016`) — protocol version
* **`Magic`** (`f9beb4fe`) — Namecoin mainnet magic bytes
* **`InitialIP`** — optional comma-separated IPs of known nodes to bootstrap crawling
* **`TTL`** (`600`) — DNS TTL in seconds

### Optional: Bootstrap with known peers

If the other DNS seeds are down and you have no initial peers, add some from the Namecoin Core source (`contrib/seeds/nodes_main.txt`) or from a running node (`namecoin-cli getpeerinfo`):

~~~
"InitialIP": "1.2.3.4,5.6.7.8,9.10.11.12"
~~~

## Step 4: Run the Seeder

### Option A: Bind to port 53 directly (recommended on Debian)

~~~
# Grant the binary permission to bind to privileged ports
sudo setcap 'cap_net_bind_service=+ep' $GOPATH/bin/dnsseeder

# Run
dnsseeder -v -netfile namecoin.json -w 8880
~~~

### Option B: Use iptables to redirect port 53

~~~
# Redirect port 53 to 5353
sudo iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-port 5353
sudo iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-port 5353

# Run on the unprivileged port
dnsseeder -v -p 5353 -netfile namecoin.json -w 8880
~~~

**Note:** On Debian, `systemd-resolved` may be listening on port 53.  If so, either disable it (`sudo systemctl disable --now systemd-resolved`) or use the iptables redirect method above.

The `-w 8880` flag enables a local web UI at `http://localhost:8880/summary` showing crawler stats.  It binds to localhost only; use an SSH tunnel to access it remotely:

~~~
ssh -L 8880:localhost:8880 user@your-server
~~~

## Step 5: Run as a systemd Service

Create a dedicated user and a systemd unit file:

~~~
sudo useradd -r -m -s /bin/bash dnsseeder
~~~

Copy the `dnsseeder` binary and `namecoin.json` config to `/home/dnsseeder/`.

Create `/etc/systemd/system/nmc-dnsseeder.service`:

~~~
[Unit]
Description=Namecoin DNS Seeder
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=dnsseeder
WorkingDirectory=/home/dnsseeder
ExecStart=/home/dnsseeder/go/bin/dnsseeder \
    -v \
    -netfile /home/dnsseeder/namecoin.json \
    -w 8880
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
~~~

If you used `setcap`, the `User=dnsseeder` line is sufficient.  If you did not use `setcap`, add `AmbientCapabilities=CAP_NET_BIND_SERVICE` under `[Service]`.

Enable and start the service:

~~~
sudo systemctl daemon-reload
sudo systemctl enable --now nmc-dnsseeder
sudo journalctl -u nmc-dnsseeder -f
~~~

## Step 6: Verify It Works

From any other machine, query your seed:

~~~
# Query your seed directly
dig @203.0.113.50 nmc-seed.example.com A

# Or via normal DNS resolution (after NS propagation)
dig nmc-seed.example.com A
~~~

A healthy seed returns multiple A records, each one the IP of a reachable Namecoin node:

~~~
;; ANSWER SECTION:
nmc-seed.example.com. 600 IN A  45.76.xx.xx
nmc-seed.example.com. 600 IN A  198.51.xx.xx
nmc-seed.example.com. 600 IN A  91.234.xx.xx
~~~

Also verify that SOA and NS queries return valid responses (required for recursive resolvers to treat the zone as healthy):

~~~
dig @203.0.113.50 nmc-seed.example.com SOA
dig @203.0.113.50 nmc-seed.example.com NS
~~~

## Step 7: Get Your Seed Added to Namecoin Core

Once your seed has been running reliably for a few weeks:

1. Open an issue or pull request at [namecoin-core](https://github.com/namecoin/namecoin-core) requesting your seed be added to `chainparams.cpp`.
2. The addition will look like: `vSeeds.emplace_back("nmc-seed.example.com.");`

## Troubleshooting

**Seeder finds 0 nodes:**

* Make sure port 8334/tcp outbound is open (the crawler connects to Namecoin nodes on this port)
* Provide `InitialIP` with at least one known good node
* Check that the magic bytes and protocol version are correct

**DNS queries return nothing or SERVFAIL from recursive resolvers:**

* Verify your NS delegation: `dig NS nmc-seed.example.com`
* Make sure port 53/udp inbound is open on your firewall
* Check that the `DNSName` in your JSON matches your actual subdomain exactly
* Confirm your seeder responds to SOA queries: `dig @your-server-ip nmc-seed.example.com SOA`.  If it returns no answer, you are likely running the upstream seeder without the SOA/NS patch — switch to the [mstrofnone/dnsseeder](https://github.com/mstrofnone/dnsseeder) fork

**Low node count:**

* Normal initially — the crawler takes time to discover the network
* Namecoin has a relatively small number of reachable nodes (~100–400)
* The crawler periodically re-checks and prunes unreachable nodes
