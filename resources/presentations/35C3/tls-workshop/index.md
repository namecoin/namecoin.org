---
layout: page
title: 35C3 TLS Workshop Notes
redirect_from:
  - /35c3-tls-workshop/
---

{::options parse_block_html="true" /}

Welcome to the 35C3 Namecoin TLS Workshop, home of the code that first worked a few days ago.  We'll walk you through the steps below, feel free to follow along in this document.

## Get a Namecoin lookup client

You only need one of ConsensusJ-Namecoin or Electrum-NMC.  ConsensusJ-Namecoin requires x86 architecture (either 32-bit or 64-bit).  Electrum-NMC requires Python 3.6 or higher.

### ConsensusJ-Namecoin

* [https://www.namecoin.org/download/betas/#consensusj-namecoin](https://www.namecoin.org/download/betas/#consensusj-namecoin)

### Electrum-NMC

* [https://www.namecoin.org/download/betas/#electrum-nmc](https://www.namecoin.org/download/betas/#electrum-nmc) (you want the v3.2.4b1 Beta)

## Install a Namecoin lookup client

You only need one of ConsensusJ-Namecoin or Electrum-NMC.

### ConsensusJ-Namecoin

1. Install Java.  In Debian, this can be done via `sudo apt-get install openjdk-8-jre`; in Fedora, use `sudo dnf install java-1.8.0-openjdk`
2. In a dedicated terminal: `java -jar ./namecoinj-daemon-0.3.2-SNAPSHOT.jar --connection.proxyenabled=false --connection.streamisolation=false --server.port=8336 --namelookup.latest.algo=leveldbtxcache`
3. It'll take a few minutes to sync.

### Electrum-NMC

1. Install Python3-PyQt5.  In Debian, this can be done via `sudo apt-get install python3-pyqt5` ; in Fedora, use `sudo dnf install python3-qt5`
2. `./run_electrum_nmc setconfig rpcport 8336`
3. `./run_electrum_nmc setconfig rpcuser whateverusernameyouwant`
4. `./run_electrum_nmc setconfig rpcpassword whateverpasswordyouwant`
5. In a dedicated terminal: `./run_electrum_nmc` 
    1. Choose "Select server manually" and click "Next"
    2. Use server "ulrichard.ch", port 50006, then click "Next"
    3. Create a Standard wallet with a Legacy seed type; use whatever other settings you like.
    4. Once the setup wizard finishes, click "Tools" -> "Network", and check that the block count next to "Blockchain" matches the one listed next to each "Connected node".  It might take some time to sync, if it's not fully synced yet, feel free to move onto the next step while it syncs.
6. `./run_electrum_nmc daemon load_wallet`

### For both ConsensusJ-Namecoin and Electrum-NMC

* Test lookups with `curl --data-binary '{"id":"curltext","method":"name_show","params":["d/ca-test"]}' http://whateverusernameyouwant:whateverpasswordyouwant@127.0.0.1:8336` ; it should show some JSON that includes an IP address.

## Get ncdns

### Binary downloads

* [https://www.namecoin.org/download/betas/#ncdns](https://www.namecoin.org/download/betas/#ncdns)

### Build from source

1. Install Go: [https://golang.org/dl/](https://golang.org/dl/)
2. `go get -d github.com/namecoin/ncdns/...`
3. `go generate github.com/namecoin/ncdns/...`
4. `go get github.com/namecoin/ncdns/...`

## Install ncdns

### If you're using Electrum-NMC

1. Create `ncdns.conf` in the directory where ncdns is, and fill in the following, substituting your Electrum-NMC username and password:
~~~
[ncdns]
bind="127.0.0.1:5391"
namecoinrpcusername="whateverusernameyouwant"
namecoinrpcpassword="whateverpasswordyouwant"
[xlog]
severity="debug"
~~~

### If you're using ConsensusJ-Namecoin

1. Create `ncdns.conf` in the directory where ncdns is, and fill in the following, using any username and password that you like:
~~~
[ncdns]
bind="127.0.0.1:5391"
namecoinrpcusername="whateverusernameyouwant"
namecoinrpcpassword="whateverpasswordyouwant"
[xlog]
severity="debug"
~~~

### For either Electrum-NMC or ConsensusJ-Namecoin

1. Install socat; in Debian, this can be done via `sudo apt-get install socat`
2. In a dedicated terminal: `./ncdns`
3. In a dedicated terminal: `sudo socat tcp-listen:53,fork tcp:127.0.0.1:5391`
4. In a dedicated terminal: `sudo socat udp-listen:53,fork udp:127.0.0.1:5391`
5. To test: `./q @127.0.0.1 ca-test.bit` ; it should return an IP address.  If it times out, try again (Electrum-NMC can be especially slow).
6. You can switch your OS's DNS to 127.0.0.1 now if you like.  Note that this will prevent resolving non-Namecoin domains, so you'll want to switch it back to what it was before if you want to access non-Namecoin domains.

## Get dns-prop279

Only needed if you want to use Tor Browser over Tor.

### Binary downloads

Included in ncdns binary downloads; see above.

### Build from source

1. `go get github.com/namecoin/dns-prop279`

## Install dns-prop279

1. See instructions at [https://www.namecoin.org/docs/tor-resolution/#install-torns](https://www.namecoin.org/docs/tor-resolution/#install-torns) .

## Get certdehydrate-dane-rest-api

### Binary downloads

* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_386.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_386.tar.gz)
* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_amd64.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_amd64.tar.gz)
* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_arm64.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_arm64.tar.gz)
* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_arm.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_arm.tar.gz)
* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_ppc64le.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_ppc64le.tar.gz)
* [https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_ppc64.tar.gz](https://www.namecoin.org/files/certdehydrate-dane-rest-api/master-2018-12-22/certdehydrate-dane-rest-api-HEAD-linux_ppc64.tar.gz)

### Build from source

1. Install Go: [https://golang.org/dl/](https://golang.org/dl/)
2. `go get github.com/namecoin/certdehydrate-dane-rest-api`
3. If you get an error mentioning miekg/dns, then do this: `pushd $(go env GOPATH)/src/github.com/miekg/dns; git checkout v1.0.15; popd` and then try again.

## Install certdehydrate-dane-rest-api

1. In a dedicated terminal, `./certdehydrate-dane-rest-api`
2. If you haven't already switched your OS's network settings to use DNS `127.0.0.1`, do so now to test.
3. You can test it by running `curl http://127.0.0.1:8080/lookup?domain=ca-test.bit` ; it should show a base64-encoded certificate.
4. If you want, you can restore your DNS settings to the default until we're ready to test ncp11.

## Get ncp11

### Binary downloads

Only available for amd64; if you're on another arch, you'll need to build from source.

* [https://www.namecoin.org/files/ncp11/master-2018-12-23/ncp11-linux-amd64.tar.gz](https://www.namecoin.org/files/ncp11/master-2018-12-23/ncp11-linux-amd64.tar.gz)

### Build from source

1. Install the `libltdl` development headers.  On Debian, this can be done via `sudo apt-get install libldtl-dev`
2. Install Go: [https://golang.org/dl/](https://golang.org/dl/)
3. `go get -d github.com/namecoin/ncp11`
4. `cd $(go env GOPATH)/src/github.com/namecoin/ncp11`
5. `make` ; if you get an error about constants overflowing ints, run `pushd $(go env GOPATH)/src/github.com/miekg/pkcs11; git remote add JeremyRand https://github.com/JeremyRand/pkcs11; git fetch JeremyRand; git checkout JeremyRand/32bit-hack; popd` and then try again.

## Install ncp11

1. Build ncp11 from source (see above) or download binaries from Namecoin.org.
2. Install [certdehydrate-dane-rest-api](https://github.com/namecoin/certdehydrate-dane-rest-api/) and make sure that it's running.  (You'll probably want to set it to launch automatically on boot.)
3. Follow the instructions below for your desired TLS implementation:

### Generic NSS (Anything that uses the shared NSS trust store, e.g. Chromium)

4. `sudo make install`
5. Find the `libnssckbi.so` file that shipped with NSS.  You can easily search for it via `find /usr/ -name libnssckbi.so`.  Commonly found locations include `/usr/lib64/nss/libnssckbi.so` (on Fedora for amd64) and `/usr/lib/x86_64-linux-gnu/nss/libnssckbi.so` (on Debian for amd64).
6. Copy `libnssckbi.so` to `/usr/local/namecoin/libnssckbi-namecoin-target.so`.  For example, `sudo cp /usr/lib64/nss/libnssckbi.so /usr/local/namecoin/libnssckbi-namecoin-target.so`.
7. `make nss-shared-install`

You'll need to restart your NSS-using programs (e.g. Chromium) if you want them to notice that ncp11 is installed.

Remember to re-copy `libnssckbi.so` whenever NSS is upgraded on your system!

TODO: If it breaks, use the Tor Browser method.

### Firefox

4. `sudo make install`
5. Find the `libnssckbi.so` file that shipped with Firefox.  You can easily search for it via `find /usr/ -name libnssckbi.so`.  Commonly found locations include `/usr/lib/firefox-esr/libnssckbi.so` (on Debian Stretch).  Some operating systems (e.g. Fedora, and Debian Buster) don't ship an NSS that's specific to Firefox and instead make Firefox use the system NSS; if you're on such an OS, use the system `libnssckbi.so`.
6. Copy `libnssckbi.so` to `/usr/local/namecoin/libnssckbi-namecoin-target.so`.  For example, `sudo cp /usr/lib/firefox-esr/libnssckbi.so /usr/local/namecoin/libnssckbi-namecoin-target.so`.
7. `make nss-firefox-install`

Note that it's a very bad idea to install both Generic NSS and Firefox support at the same time, because the copied `libnssckbi.so` instances will conflict.  However, if your OS's Firefox package uses the system NSS (e.g. Fedora or Debian Buster), then it's totally fine to install both simultaneously (since the `libnssckbi.so` files are identical).

You'll need to restart Firefox if you want it to notice that ncp11 is installed.

Remember to re-copy `libnssckbi.so` whenever NSS is upgraded on your system!

TODO: If it breaks, use the Tor Browser method.

### Tor Browser

4. Make sure that Tor Browser isn't currently running.
5. Rename `libnssckbi.so` in the Tor Browser `Browser` directory to `libnssckbi-namecoin-target.so`.
6. Copy `libnamecoin.so` from ncp11 to the Tor Browser `Browser` directory.
7. Rename `libnamecoin.so` in the Tor Browser `Browser` directory to `libnssckbi.so`.

You can now start Tor Browser.

Remember to re-do these steps whenever Tor Browser is upgraded on your system!

## Bonus content: Get generate_nmc_cert

TODO
