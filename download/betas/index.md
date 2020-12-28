---
layout: page
title: Beta Downloads
---

{::options parse_block_html="true" /}

## Warning

The downloads on this page are not yet ready for general-purpose production use.  We'd love to hear what works and what doesn't (that's why they're posted here), but don't use them in any situation where failure could result in consequences that you're unwilling to accept.  For example, don't use them with wallets that contain coins or names that you aren't willing to sacrifice to science.

The more people test these downloads, the faster they'll be ready for release.  However, there are no guarantees of when, or if, these downloads will be released in final form.

As usual, it is a good idea to verify the hashes and signatures of these downloads (especially the ones not hosted on namecoin.org).  The more people reproduced the hashes, the better.  If you're paranoid, run them inside an isolated virtual machine.

## Namecoin Core

* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux ARM 64-bit)](https://www.namecoin.org/files/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-aarch64-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux ARM 32-bit)](https://www.namecoin.org/files/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-arm-linux-gnueabihf.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux x86 64-bit)](https://www.namecoin.org/files/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-x86_64-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux x86 32-bit)](https://www.namecoin.org/files/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-i686-pc-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (Source code tarball)](https://www.namecoin.org/files/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99.tar.gz)
* [Namecoin Core Gitian signatures](https://github.com/namecoin/gitian.sigs/)
* [Namecoin Core source code](https://github.com/namecoin/namecoin-core/)

### Things to Test

* Full flow for registering names.
* Full flow for updating and renewing names.
* State display in the names list.
* The above with mainnet, testnet, and regtest networks.
* The above with encrypted locked, encrypted unlocked, and unencrypted wallets.

### Known Issues

* Windows builds not working (should be fixed in Beta 2)
* macOS builds not working (should be fixed in Beta 2)

## ConsensusJ-Namecoin

ConsensusJ-Namecoin is a lightweight SPV client that acts as a drop-in replacement for Namecoin Core's name lookup functionality (e.g. for browsing `.bit` domains with [ncdns]({{site.baseurl}}docs/ncdns)).  It synchronizes faster and uses less storage than Namecoin Core, but trusts Namecoin miners more than Namecoin Core does.

You need to have Java installed:

* If you're using GNU/Linux, use your package manager.
* If you're using Windows, [download it from the Oracle website](https://www.java.com/en/download/manual.jsp).  **Make sure you right-click the `.exe` installer, click `Properties`, and click `Digital Signatures`.  It should be signed by `Oracle America, Inc.`  If it is not, do not install it.**
* We're not sure about macOS.  If anyone can contribute instructions for macOS, let us know.

**If you're using Windows, you will need to install the [Microsoft Visual C++ 2010 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=26999).**

* [ConsensusJ-Namecoin v0.3.2.1 (cross-platform JAR)](https://www.namecoin.org/files/ConsensusJ-Namecoin/0.3.2.1/namecoinj-daemon-0.3.2-SNAPSHOT.jar)
* [ConsensusJ-Namecoin v0.3.2.1 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ConsensusJ-Namecoin/0.3.2.1/SHA256SUMS.asc)
* [ConsensusJ-Namecoin source code (use the `consensusj-namecoin-0.3.2.1` branch)](https://github.com/JeremyRand/consensusj/)
* [libdohj source code](https://github.com/dogecoin/libdohj/)

[Preliminary ConsensusJ-Namecoin documentation is here.]({{site.baseurl}}docs/consensusj-namecoin/)

### Known Issues

* Relies on patches to ConsensusJ that are not yet upstreamed.
* Proxies are not yet supported.
* Build is not yet reproducible.

## Electrum-NMC

Electrum-NMC is the Namecoin port of the lightweight Bitcoin wallet Electrum.

[Preliminary Electrum-NMC documentation is here.]({{site.baseurl}}docs/electrum-nmc/)

* [Electrum-NMC v3.3.10 for GNU/Linux, Windows, and macOS (Python tar.xz, best compression)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/Electrum-NMC-3.3.10.tar.xz)
* [Electrum-NMC v3.3.10 for GNU/Linux, Windows, and macOS (Python tar.gz, average compression)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/Electrum-NMC-3.3.10.tar.gz)
* [Electrum-NMC v3.3.10 for GNU/Linux, Windows, and macOS (Python zip, worst compression)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/Electrum-NMC-3.3.10.zip)
* [Electrum-NMC v3.3.10 for GNU/Linux (x86_64 AppImage)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/electrum-nmc-nc3.3.10-x86_64.AppImage)
* [Electrum-NMC v3.3.10 for Windows (Standalone Executable)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/electrum-nmc-nc3.3.10.exe)
* [Electrum-NMC v3.3.10 for Windows (Portable version)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/electrum-nmc-nc3.3.10-portable.exe)
* [Electrum-NMC v3.3.10 for Windows (Installer)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/electrum-nmc-nc3.3.10-setup.exe)
* [Electrum-NMC v3.3.9.1 for Android/Linux](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.9.1/Electrum_NMC-3.3.9.0-debug.apk)
* [Electrum-NMC v3.3.10 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.10/SHA256SUMS.asc)
* [Electrum-NMC v3.3.9.1 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.9.1/SHA256SUMS.asc)
* [Electrum-NMC source code](https://github.com/namecoin/electrum-nmc/)

### Known Issues

* AuxPoW support is still experimental.
* Hardware wallets other than Trezor and Safe-T mini are untested and probably don't work.
* Name transactions are not yet supported for hardware wallets.
* The Android/Linux version doesn't yet have most of the Namecoin-specific GUI features.
* macOS binaries are not yet available (but the Python binaries should work on macOS).
* Build reproducibility is not yet tested.

## ncdns

ncdns is software for accessing `.bit` domain names.  If you want to access `.bit` domain names, ncdns is most likely what you want to install.

See the [ncdns documentation]({{site.baseurl}}docs/ncdns).

The ncdns Windows installer also automatically installs and configures a Namecoin client (Namecoin Core or ConsensusJ-Namecoin) and Dnssec-Trigger/Unbound, and sets up TLS certificate validation in any supported web browsers that are installed (see documentation for a list of supported browsers).  It's basically all you need for browsing `.bit` domain names.

**Before running the ncdns Windows installer, you will need to install the following:**

* [Visual C++ Redistributable for Visual Studio 2015](https://www.microsoft.com/en-us/download/details.aspx?id=53587)

ncdns plain binaries are also available for most major operating systems.  These are useful for advanced users or for users who are not on Windows.  Using these will require setting up Namecoin Core and a recursive DNS resolver (e.g. Unbound) separately; they can sometimes be used for TLS certificate validation, but additional setup is required.

* [ncdns v0.0.10.3 GNU/Linux (64-bit x86) plain binaries](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-linux-x86_64.tar.gz)
* [ncdns v0.0.10.3 GNU/Linux (32-bit x86) plain binaries](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-linux-i686.tar.gz)
* [ncdns v0.0.10.3 Windows (64-bit x86) installer](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-windows-x86_64-install.exe)
* [ncdns v0.0.10.3 Windows (64-bit x86) plain binaries](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-windows-x86_64.tar.gz)
* [ncdns v0.0.10.3 Windows (32-bit x86) plain binaries](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-windows-i686.tar.gz)
* [ncdns v0.0.10.3 macOS (64-bit x86) plain binaries](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3-osx-x86_64.tar.gz)
* [ncdns v0.0.10.3 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [ncdns v0.0.10.3 plain binaries for GNU/Linux (non-x86), DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, and Solaris (hosted by GitHub)](https://github.com/namecoin/ncdns/releases/tag/v0.0.10.3)
* [ncdns Windows Installer Source Code](https://github.com/namecoin/ncdns-nsis)
* [ncdns rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [ncdns Source Code](https://github.com/namecoin/ncdns)

### Known Issues

* Build is not yet reproducible.

## certdehydrate-dane-rest-api

certdehydrate-dane-rest-api is a dependency of ncp11 and the Chromium version of DNSSEC-HSTS.

* [certdehydrate-dane-rest-api v0.0.1 for GNU/Linux (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/certdehydrate-dane-rest-api-0.0.1-linux-x86_64.tar.gz)
* [certdehydrate-dane-rest-api v0.0.1 for GNU/Linux (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/certdehydrate-dane-rest-api-0.0.1-linux-i686.tar.gz)
* [certdehydrate-dane-rest-api v0.0.1 for Windows (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/certdehydrate-dane-rest-api-0.0.1-windows-x86_64.tar.gz)
* [certdehydrate-dane-rest-api v0.0.1 for Windows (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/certdehydrate-dane-rest-api-0.0.1-windows-i686.tar.gz)
* [certdehydrate-dane-rest-api v0.0.1 for macOS (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/certdehydrate-dane-rest-api-0.0.1-osx-x86_64.tar.gz)
* [certdehydrate-dane-rest-api v0.0.1 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [certdehydrate-dane-rest-api rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [certdehydrate-dane-rest-api Source Code](https://github.com/namecoin/certdehydrate-dane-rest-api)

### Known Issues

* Build is not yet reproducible.

## cross_sign_name_constraint_tool

This tool applies a name constraint exclusion to a DER-encoded TLS trust anchor via cross-signing, without that trust anchor's consent. The intended use case is to disallow a CA from issuing certificates for a domain name that it has no legitimate business issuing certificates for. For example:

* Disallowing a public CA from issuing certificates for the `.bit` TLD used by Namecoin.
* Disallowing a public CA from issuing certificates for a TLD controlled by your corporate intranet.
* Disallowing your corporate intranet's CA from issuing certificates for a TLD allocated by ICANN.

Namecoin users will probably want to use `cross_sign_name_constraint_tool` to disallow any non-Namecoin CA's that they have manually imported to their system from signing `.bit` certificates.  For CA's that are on your system by default, you probably instead want `tlsrestrict_nss_tool` (see below) or `tlsrestrict_chromium_tool` (bundled with ncdns, see above).

* [cross_sign_name_constraint_tool v0.0.3 binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, macOS (hosted by GitHub)](https://github.com/namecoin/crosssignnameconstraint/releases/tag/v0.0.3)
* [cross_sign_name_constraint_tool Source Code at GitHub.](https://github.com/namecoin/crosssignnameconstraint)

### Known Issues

* Build is not yet reproducible.

## DNSSEC-HSTS

DNSSEC-HSTS enforces TLS for Namecoin websites that support TLS, which protects against sslstrip attacks.  Firefox users need both the WebExtensions Component and the Native Component.  Chromium users need the WebExtensions component and certdehydrate-dane-rest-api (see above), but not the Native Component.

* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Firefox](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-firefox.xpi)
* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Chromium/Chrome (Unpacked)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-chromium.zip)
* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Chromium/Chrome (CRX)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-chromium-crx.tar.xz)
* [DNSSEC-HSTS Native Component v0.0.1 for GNU/Linux (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-linux-x86_64.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for GNU/Linux (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-linux-i686.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for Windows (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-windows-x86_64.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for Windows (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-windows-i686.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for macOS (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-osx-x86_64.tar.gz)
* [DNSSEC-HSTS v0.0.2 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [DNSSEC-HSTS rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [DNSSEC-HSTS WebExtensions Component Source Code](https://github.com/namecoin/dnssec-hsts)
* [DNSSEC-HSTS Native Component Source Code](https://github.com/namecoin/dnssec-hsts-native)

### Known Issues

* Build is not yet reproducible.

## ncp11

ncp11 enables Namecoin TLS in applications that support PKCS#11, such as Tor Browser.

* [ncp11 v0.0.1 for GNU/Linux (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncp11-0.0.1-linux-x86_64.tar.gz)
* [ncp11 v0.0.1 for GNU/Linux (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncp11-0.0.1-linux-i686.tar.gz)
* [ncp11 v0.0.1 for Windows (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncp11-0.0.1-windows-x86_64.tar.gz)
* [ncp11 v0.0.1 for Windows (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncp11-0.0.1-windows-i686.tar.gz)
* [ncp11 v0.0.1 for macOS (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncp11-0.0.1-osx-x86_64.tar.gz)
* [ncp11 v0.0.1 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [ncp11 rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [ncp11 Source Code](https://github.com/namecoin/ncp11)

### Known Issues

* Build is not yet reproducible.

## tlsrestrict_nss_tool

This tool applies a name constraint exclusion to an NSS sqlite database for all CKBI (built-in) TLS trust anchors, without those trust anchors' consent. The intended use case is to disallow public CA's from issuing certificates for TLD's with unique regulatory or policy requirements, such as:

* The `.bit` TLD used by Namecoin.
* A TLD controlled by your corporate intranet.

Namecoin users will probably want to use `tlsrestrict_nss_tool` to disallow all CA's that are on their system by default from signing `.bit` certificates.  For CA's that you manually imported yourself, you probably instead want `cross_sign_name_constraint_tool` (see above).

* [tlsrestrict_nss_tool v0.0.4.2 binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, macOS (hosted by GitHub)](https://github.com/namecoin/tlsrestrictnss/releases/tag/v0.0.4.2)
* [tlsrestrict_nss_tool Source Code at GitHub.](https://github.com/namecoin/tlsrestrictnss)

### Known Issues

* This tool will probably prevent HPKP from working as intended, unless HPKP is applied to user-defined trust anchors. Firefox is capable of doing this (though it's not the default); Chromium is not (as far as we know).
* Build is not yet reproducible.

## dns-prop279

This is a tool that permits Namecoin naming (or any other naming method that speaks the DNS protocol) to be used with Tor, via the draft Prop279 pluggable naming API.  `.bit` domains can point to IP addresses (A/AAAA records), DNS names (CNAME records), and onion services.

See the [Namecoin Tor resolution documentation]({{site.baseurl}}docs/tor-resolution)
* Binaries distributed with [ncdns v0.0.8 plain binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, and macOS (hosted by GitHub)](https://github.com/namecoin/ncdns/releases/tag/v0.0.8).
* [Source code at GitHub.](https://github.com/namecoin/dns-prop279)

### Known Issues

* Prop279 is still an early draft, and might change heavily.  dns-prop279 will change accordingly.
* `tor` doesn't implement Prop279 (see above point); the [StemNS](https://github.com/namecoin/StemNS) or [TorNS](https://github.com/meejah/TorNS) shim is required if you want to use or test dns-prop279.
* dns-prop279 doesn't follow the current Namecoin Domain Names specification for onion service records (we might amend the specification to match dns-prop279's behavior).
* dns-prop279 doesn't properly return error codes; all errors will be treated as `NXDOMAIN`.
* dns-prop279 hasn't been carefully checked for proxy leaks.
* Using dns-prop279 will make you stand out from other Tor users.
* Stream isolation for streams opened by applications (e.g. Tor Browser) should work fine.  However, stream isolation metadata won't propagate to streams opened by the DNS server.  That means you should only use `dns-prop279` with a DNS server that will not generate outgoing traffic when you query it.  ncdns is probably fine as long as it's using a full-block-receive Namecoin node such as Namecoin Core or ConsensusJ-Namecoin in leveldbtxcache mode.  ncdns should **not** be used with headers-only name lookup clients such as Electrum-NMC.  Unbound is also not a good idea.
* Nothing in dns-prop279 prevents the configured DNS server from caching lookups. If lookups are cached, this could be used to fingerprint users. ncdns has caching enabled by default.
* DNSSEC support hasn't been tested at all, and is probably totally unsafe right now. Only use dns-prop279 when you fully trust the configured DNS server and your network path to it.
* Build is not yet reproducible.

## ncprop279

ncprop279 enables Namecoin naming (but not DNS naming) to be used with Tor, via the draft Prop279 pluggable naming API.  ncprop279 is somewhat smaller and more efficient than dns-prop279.  `.bit` domains can point to IP addresses (A/AAAA records), DNS names (CNAME records), and onion services.

See the [Namecoin Tor resolution documentation]({{site.baseurl}}docs/tor-resolution).

* [ncprop279 v0.0.3 for GNU/Linux (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncprop279-0.0.3-linux-x86_64.tar.gz)
* [ncprop279 v0.0.3 for GNU/Linux (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncprop279-0.0.3-linux-i686.tar.gz)
* [ncprop279 v0.0.3 for Windows (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncprop279-0.0.3-windows-x86_64.tar.gz)
* [ncprop279 v0.0.3 for Windows (32-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncprop279-0.0.3-windows-i686.tar.gz)
* [ncprop279 v0.0.3 for macOS (64-bit x86)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncprop279-0.0.3-osx-x86_64.tar.gz)
* [ncprop279 v0.0.3 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [ncprop279 rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [ncprop279 Source Code](https://github.com/namecoin/ncprop279)

### Known Issues

* Prop279 is still an early draft, and might change heavily.  ncprop279 will change accordingly.
* `tor` doesn't implement Prop279 (see above point); the [StemNS](https://github.com/namecoin/StemNS) or [TorNS](https://github.com/meejah/TorNS) shim is required if you want to use or test ncprop279.
* ncprop279 doesn't follow the current Namecoin Domain Names specification for onion service records (we might amend the specification to match ncprop279's behavior).
* ncprop279 hasn't been carefully checked for proxy leaks.
* Using ncprop279 will make you stand out from other Tor users.
* Stream isolation for streams opened by applications (e.g. Tor Browser) should work fine.  However, stream isolation metadata will only propagate to streams opened by the Namecoin client if you're running Tor 0.4.3.1-alpha or higher with a recent StemNS (TorNS hasn't merged the needed changes yet).  If you meet those requirements, then any Namecoin client is fine.  If not, that means you should only use `ncprop279` with a Namecoin client that will not generate outgoing traffic when you query it.  A full-block-receive Namecoin node such as Namecoin Core or ConsensusJ-Namecoin in leveldbtxcache mode is probably fine.  A headers-only name lookup client such as Electrum-NMC should **not** be used without Tor 0.4.3.1-alpha or higher with a recent StemNS.
* ncprop279 caches lookups.  Isolation of the caching has the same dependencies as stream isolation.  If you don't have the needed Tor and StemNS version, ncprop279's caching could be used to fingerprint you.
* Build is not yet reproducible.
