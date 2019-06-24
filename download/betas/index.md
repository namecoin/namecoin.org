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

ConsensusJ-Namecoin is a lightweight SPV client that acts as a drop-in replacement for Namecoin Core's name lookup functionality (e.g. for browsing `.bit` domains with ncdns).  It synchronizes faster and uses less storage than Namecoin Core, but trusts Namecoin miners more than Namecoin Core does.

You need to have Java installed:

* If you're using GNU/Linux, use your package manager.
* If you're using Windows, [download it from the Oracle website](https://www.java.com/en/download/manual.jsp).  **Make sure you right-click the `.exe` installer, click `Properties`, and click `Digital Signatures`.  It should be signed by `Oracle America, Inc.`  If it is not, do not install it.**
* We're not sure about OS X.  If anyone can contribute instructions for OS X, let us know.

**If you're using Windows, you will need to install the [Microsoft Visual C++ 2010 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=26999).**

* [ConsensusJ-Namecoin v0.3.2.1 (cross-platform JAR)](https://www.namecoin.org/files/ConsensusJ-Namecoin/0.3.2.1/namecoinj-daemon-0.3.2-SNAPSHOT.jar)
* [ConsensusJ-Namecoin v0.3.2.1 Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ConsensusJ-Namecoin/0.3.2.1/SHA256SUMS.asc)
* [ConsensusJ-Namecoin source code (use the `consensusj-namecoin-0.3.2.1` branch)](https://github.com/JeremyRand/consensusj/)
* [libdohj source code](https://github.com/dogecoin/libdohj/)

[Preliminary instructions are here.]({{site.baseurl}}docs/bitcoinj-name-lookups/)

### Known Issues

* Relies on patches to ConsensusJ that are not yet upstreamed.
* Proxies are not yet supported.
* Build is not yet reproducible.

## Electrum-NMC

Electrum-NMC is the Namecoin port of the lightweight Bitcoin wallet Electrum.

[Preliminary Electrum-NMC documentation is here.]({{site.baseurl}}docs/electrum-nmc/)

* [Electrum-NMC v3.3.6 for GNU/Linux, Windows, and macOS (Python tar.gz)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6/Electrum-NMC-3.3.6.tar.gz)
* [Electrum-NMC v3.3.6 for GNU/Linux, Windows, and macOS (Python zip)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6/Electrum-NMC-3.3.6.zip)
* [Electrum-NMC v3.3.6 for GNU/Linux (x86_64 AppImage)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6/electrum-nmc-nc3.3.6-x86_64.AppImage)
* [Electrum-NMC v3.3.6.1 for Windows (Standalone Executable)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6.1/electrum-nmc-nc3.3.6.1.exe)
* [Electrum-NMC v3.3.6.1 for Windows (Portable version)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6.1/electrum-nmc-nc3.3.6.1-portable.exe)
* [Electrum-NMC v3.3.6.1 for Windows (Installer)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6.1/electrum-nmc-nc3.3.6.1-setup.exe)
* [Electrum-NMC v3.3.6 for Android](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6/Electrum_NMC-3.3.6.0-debug.apk)
* [Electrum-NMC v3.3.6 Signature (Release signed by Jeremy Rand)](https://beta.namecoin.org/files/electrum-nmc/electrum-nmc-3.3.6/SHA256SUMS.asc)
* [Electrum-NMC source code](https://github.com/namecoin/electrum-nmc/)

### Known Issues

* AuxPoW support is still experimental.
* P2SH and SegWit are not yet disabled in the GUI.  Don't use those features, since P2SH and SegWit aren't enforced on Namecoin yet, meaning that coins sent to such addresses can trivially be stolen.
* Hardware wallets other than Trezor and Safe-T mini are untested and probably don't work.
* Name transactions are not yet supported for hardware wallets.
* The Android version doesn't yet have most of the Namecoin-specific GUI features.
* AppImage binaries have not yet been tested.
* macOS binaries are not yet available.
* Build reproducibility is not yet tested.

## ncdns

ncdns is software for accessing `.bit` domain names.  If you want to access `.bit` domain names, ncdns is most likely what you want to install.

See the [ncdns documentation]({{site.baseurl}}docs/ncdns).

The ncdns Windows installer also automatically installs and configures a Namecoin client (Namecoin Core or ConsensusJ-Namecoin) and Dnssec-Trigger/Unbound, and sets up TLS certificate validation in any supported web browsers that are installed (see documentation for a list of supported browsers).  It's basically all you need for browsing `.bit` domain names.

**Before running the ncdns Windows installer, you will need to install the [Visual C++ Redistributable for Visual Studio 2012](https://www.microsoft.com/en-us/download/details.aspx?id=30679).**

ncdns plain binaries are also available for most major operating systems.  These are useful for advanced users or for users who are not on Windows.  Using these will require setting up Namecoin Core and a recursive DNS resolver (e.g. Unbound) separately; they can sometimes be used for TLS certificate validation, but additional setup is required.

* [ncdns v0.0.8 Windows (64-bit) installer](https://www.namecoin.org/files/ncdns-v0.0.8/ncdns-v0.0.8-win64-install.exe)
* [ncdns v0.0.8 Windows (32-bit) installer](https://www.namecoin.org/files/ncdns-v0.0.8/ncdns-v0.0.8-win32-install.exe)
* [ncdns v0.0.8 Windows Signature (Release signed by Jeremy Rand)](https://www.namecoin.org/files/ncdns-v0.0.8/ncdns-v0.0.8-win.SHA256SUMS.asc)
* [ncdns v0.0.8 plain binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, macOS (hosted by GitHub)](https://github.com/namecoin/ncdns/releases/tag/v0.0.8)
* [ncdns Windows Installer Source Code](https://github.com/namecoin/ncdns-nsis)
* [ncdns Source Code](https://github.com/namecoin/ncdns)

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

## tlsrestrict_nss_tool

This tool applies a name constraint exclusion to an NSS sqlite database for all CKBI (built-in) TLS trust anchors, without those trust anchors' consent. The intended use case is to disallow public CA's from issuing certificates for TLD's with unique regulatory or policy requirements, such as:

* The `.bit` TLD used by Namecoin.
* A TLD controlled by your corporate intranet.

Namecoin users will probably want to use `tlsrestrict_nss_tool` to disallow all CA's that are on their system by default from signing `.bit` certificates.  For CA's that you manually imported yourself, you probably instead want `cross_sign_name_constraint_tool` (see above).

* [tlsrestrict_nss_tool v0.0.3 binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, macOS (hosted by GitHub)](https://github.com/namecoin/tlsrestrictnss/releases/tag/v0.0.3)
* [tlsrestrict_nss_tool Source Code at GitHub.](https://github.com/namecoin/tlsrestrictnss)

### Known Issues

* This tool will probably prevent HPKP from working as intended, unless HPKP is applied to user-defined trust anchors. Firefox is capable of doing this (though it's not the default); Chromium is not (as far as we know).
* Build is not yet reproducible.

## dns-prop279

This is a tool that permits Namecoin naming (or any other naming method that speaks the DNS protocol) to be used with Tor, via the draft Prop279 pluggable naming API.  `.bit` domains can point to IP addresses (A/AAAA records), DNS names (CNAME records), and onion services.

See the [Namecoin Tor resolution documentation]({{site.baseurl}}docs/tor-resolution)
* Binaries distributed with ncdns.
* [Source code at GitHub.](https://github.com/namecoin/dns-prop279)

### Known Issues

* Prop279 is still an early draft, and might change heavily.  dns-prop279 will change accordingly.
* `tor` doesn't implement Prop279 (see above point); the [TorNS](https://github.com/meejah/TorNS) shim is required if you want to use or test dns-prop279.
* dns-prop279 doesn't follow the current Namecoin Domain Names specification for onion service records (we might amend the specification to match dns-prop279's behavior).
* dns-prop279 doesn't properly return error codes; all errors will be treated as `NXDOMAIN`.
* dns-prop279 hasn't been carefully checked for proxy leaks.
* Using dns-prop279 will make you stand out from other Tor users.
* Stream isolation for streams opened by applications (e.g. Tor Browser) should work fine.  However, stream isolation metadata won't propagate to streams opened by the DNS server.  That means you should only use `dns-prop279` with a DNS server that will not generate outgoing traffic when you query it.  ncdns is probably fine as long as it's using a full-block-receive Namecoin node such as Namecoin Core or libdohj-namecoin in leveldbtxcache mode.  ncdns should **not** be used with headers-only name lookup clients such as Electrum-NMC.  Unbound is also not a good idea.
* Nothing in dns-prop279 prevents the configured DNS server from caching lookups. If lookups are cached, this could be used to fingerprint users. ncdns has caching enabled by default.
* DNSSEC support hasn't been tested at all, and is probably totally unsafe right now. Only use dns-prop279 when you fully trust the configured DNS server and your network path to it.
* Build is not yet reproducible.
