---
layout: page
title: Beta Downloads
---

{::options parse_block_html="true" /}

## Warning

The downloads on this page are not yet ready for general-purpose production use.  We'd love to hear what works and what doesn't (that's why they're posted here), but don't use them in any situation where failure could result in consequences that you're unwilling to accept.  For example, don't use them with wallets that contain coins or names that you aren't willing to sacrifice to science.

The more people test these downloads, the faster they'll be ready for release.  However, there are no guarantees of when, or if, these downloads will be released in final form.

As usual, it is a good idea to verify the hashes and signatures of these downloads (especially the ones not hosted on namecoin.org).  The more people reproduced the hashes, the better.  If you're paranoid, run them inside an isolated virtual machine.

Nightly builds are produced by infrastructure that is not under our direct control.  As such, they should be treated with extra suspicion.

## Namecoin Core

### Stable Branch Beta 28.0

<div class="col-sm-4">

#### Windows

* [64-bit installer]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-win64-setup-unsigned.exe)
* [64-bit zip]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-win64.zip)

</div>

<div class="col-sm-4">

#### GNU/Linux

* [POWER 64-bit BE]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-powerpc64-linux-gnu.tar.gz)
* [POWER 64-bit LE Temporarily Disabled]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-powerpc64le-linux-gnu.tar.gz)
* [ARM 64-bit]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-aarch64-linux-gnu.tar.gz)
* [ARM 32-bit]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-arm-linux-gnueabihf.tar.gz)
* [RISC-V 64-bit]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-riscv64-linux-gnu.tar.gz)
* [x86 64-bit]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-x86_64-linux-gnu.tar.gz)

</div>

<div class="col-sm-4">

#### macOS

* [ARM 64-bit app]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-arm64-apple-darwin-unsigned.zip)
* [ARM 64-bit tar.gz]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-arm64-apple-darwin.tar.gz)
* [x86 64-bit app]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-x86_64-apple-darwin-unsigned.zip)
* [x86 64-bit tar.gz]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0-x86_64-apple-darwin.tar.gz)

</div>

</div>

* [Guix signatures](https://github.com/namecoin/guix.sigs/tree/master/28.0)
    * **Make sure you check for matching Guix signatures!**
* [Source code tarball]({{ site.files_url }}/files/namecoin-core/namecoin-core-28.0/namecoin-28.0.tar.gz)
* [Source code](https://github.com/namecoin/namecoin-core/)

### Name Tab Beta

* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux ARM 64-bit)]({{ site.files_url }}/files/namecoin-core/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-aarch64-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux ARM 32-bit)]({{ site.files_url }}/files/namecoin-core/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-arm-linux-gnueabihf.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux x86 64-bit)]({{ site.files_url }}/files/namecoin-core/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-x86_64-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (GNU/Linux x86 32-bit)]({{ site.files_url }}/files/namecoin-core/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99-i686-pc-linux-gnu.tar.gz)
* [Namecoin Core 0.15.99-name-tab-beta1 (Source code tarball)]({{ site.files_url }}/files/namecoin-core/namecoin-core-0.15.99-name-tab-beta1/namecoin-0.15.99.tar.gz)
* [Namecoin Core 0.15.99 Gitian signatures](https://github.com/namecoin/gitian.sigs/)
* [Namecoin Core source code](https://github.com/namecoin/namecoin-core/)

#### Things to Test

* Full flow for registering names.
* Full flow for updating and renewing names.
* State display in the names list.
* The above with mainnet, testnet, and regtest networks.
* The above with encrypted locked, encrypted unlocked, and unencrypted wallets.

#### Known Issues

* Windows builds not working (should be fixed in Beta 2)
* macOS builds not working (should be fixed in Beta 2)

## ConsensusJ-Namecoin

ConsensusJ-Namecoin is a lightweight SPV client that acts as a drop-in replacement for Namecoin Core's name lookup functionality (e.g. for browsing `.bit` domains with [ncdns]({{ "/docs/ncdns" | relative_url }})).  It synchronizes faster and uses less storage than Namecoin Core, but trusts Namecoin miners more than Namecoin Core does.

You need to have Java installed:

* If you're using GNU/Linux, use your package manager.
* If you're using Windows, [download it from the Oracle website](https://www.java.com/en/download/manual.jsp).  **Make sure you right-click the `.exe` installer, click `Properties`, and click `Digital Signatures`.  It should be signed by `Oracle America, Inc.`  If it is not, do not install it.**
* We're not sure about macOS.  If anyone can contribute instructions for macOS, let us know.

**If you're using Windows, you will need to install the [Microsoft Visual C++ 2010 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=26999).**

* [ConsensusJ-Namecoin v0.3.2.1 (cross-platform JAR)]({{ site.files_url }}/files/consensusj-namecoin/consensusj-namecoin-0.3.2.1/namecoinj-daemon-0.3.2-SNAPSHOT.jar)
* [ConsensusJ-Namecoin v0.3.2.1 Signature (Release signed by Jeremy Rand)]({{ site.files_url }}/files/consensusj-namecoin/consensusj-namecoin-0.3.2.1/SHA256SUMS.asc)
* [ConsensusJ-Namecoin source code (use the `consensusj-namecoin-0.3.2.1` branch)](https://github.com/JeremyRand/consensusj/)
* [libdohj source code](https://github.com/dogecoin/libdohj/)

[Preliminary ConsensusJ-Namecoin documentation is here.]({{ "/docs/consensusj-namecoin/" | relative_url }})

### Known Issues

* Relies on patches to ConsensusJ that are not yet upstreamed.
* Proxies are not yet supported.
* Build is not yet reproducible.

## Electrum-NMC

Electrum-NMC is the Namecoin port of the lightweight Bitcoin wallet Electrum.

[Electrum-NMC documentation is here.]({{ "/docs/electrum-nmc/" | relative_url }})

* [Electrum-NMC v4.0.6 for GNU/Linux, Windows, and macOS (Python tar.xz, best compression)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-4.0.6.tar.xz) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-4.0.6.tar.xz.asc))
* [Electrum-NMC v4.0.6 for GNU/Linux, Windows, and macOS (Python tar.gz, average compression)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-4.0.6.tar.gz) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-4.0.6.tar.gz.asc))
* [Electrum-NMC v4.0.6 for GNU/Linux (x86_64 AppImage)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-x86_64.AppImage) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-x86_64.AppImage.asc))
* [Electrum-NMC v4.0.6 for Windows (Standalone Executable)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6.exe) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6.exe.asc))
* [Electrum-NMC v4.0.6 for Windows (Portable version)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-portable.exe) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-portable.exe.asc))
* [Electrum-NMC v4.0.6 for Windows (Installer)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-setup.exe) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/electrum-nmc-nc4.0.6-setup.exe.asc))
* [Electrum-NMC v4.0.0b1 for macOS (DMG)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.0b1/electrum-nmc-nc4.0.0b1.dmg)
* [Electrum-NMC v4.0.0b1 for Android/Linux (64-bit ARM)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.0b1/Electrum_NMC-4.0.0.1-arm64-v8a-debug.apk) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.0b1/Electrum_NMC-4.0.0.1-arm64-v8a-debug.apk.asc))
* [Electrum-NMC v4.0.0b1 for Android/Linux (32-bit ARM)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.0b1/Electrum_NMC-4.0.0.1-armeabi-v7a-debug.apk) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.0b1/Electrum_NMC-4.0.0.1-armeabi-v7a-debug.apk.asc))
* [Electrum-NMC v4.0.6 source only (Python tar.xz, best compression)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-sourceonly-4.0.6.tar.xz) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-sourceonly-4.0.6.tar.xz.asc))
* [Electrum-NMC v4.0.6 source only (Python tar.gz, average compression)]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-sourceonly-4.0.6.tar.gz) | ([Signature]({{ site.files_url }}/files/electrum-nmc/electrum-nmc-4.0.6/Electrum-NMC-sourceonly-4.0.6.tar.gz.asc))
* [Electrum-NMC source code](https://github.com/namecoin/electrum-nmc/)

### Known Issues

* AuxPoW support is still experimental.
* Hardware wallets other than Trezor and Safe-T mini are untested and probably don't work.
* Name transactions are not yet supported for hardware wallets.
* The Android/Linux version doesn't yet have most of the Namecoin-specific GUI features.
* macOS binaries are untested, unsigned, and are built on Cirrus infrastructure.  The Python binaries should work on macOS.
* Build reproducibility is not yet tested.

## ncdns

ncdns is software for accessing `.bit` domain names.  If you want to access `.bit` domain names, ncdns is most likely what you want to install.

See the [ncdns documentation]({{ "/docs/ncdns" | relative_url }}).

The ncdns Windows installer also automatically installs and configures a Namecoin client (Namecoin Core, ConsensusJ-Namecoin, or Electrum-NMC) and Dnssec-Trigger/Unbound, and sets up TLS certificate validation in any supported web browsers that are installed (see documentation for a list of supported browsers).  It's basically all you need for browsing `.bit` domain names.

**Before running the ncdns Windows installer, you will need to install the following:**

* [Visual C++ Redistributable for Visual Studio 2015](https://www.microsoft.com/en-us/download/details.aspx?id=53587)

ncdns plain binaries are also available for most major operating systems.  These are useful for advanced users or for users who are not on Windows.  Using these will require setting up a Namecoin client (Namecoin Core, ConsensusJ-Namecoin, or Electrum-NMC) and a recursive DNS resolver (e.g. Unbound) separately; they can sometimes be used for TLS certificate validation, but additional setup is required.

* [ncdns Nightly GNU/Linux (64-bit POWER BE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_ppc64.tar.gz)
* [ncdns Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_ppc64le.tar.gz)
* [ncdns Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_arm64.tar.gz)
* [ncdns Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_arm.tar.gz)
* [ncdns Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_amd64.tar.gz)
* [ncdns Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--linux_386.tar.gz)
* [ncdns Nightly DragonFlyBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--dragonfly_amd64.tar.gz)
* [ncdns Nightly FreeBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--freebsd_arm.tar.gz)
* [ncdns Nightly FreeBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--freebsd_amd64.tar.gz)
* [ncdns Nightly FreeBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--freebsd_386.tar.gz)
* [ncdns Nightly NetBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--netbsd_arm.tar.gz)
* [ncdns Nightly NetBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--netbsd_amd64.tar.gz)
* [ncdns Nightly NetBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--netbsd_386.tar.gz)
* [ncdns Nightly OpenBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--openbsd_amd64.tar.gz)
* [ncdns Nightly OpenBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--openbsd_386.tar.gz)
* [ncdns Nightly Solaris (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--solaris_amd64.tar.gz)
* [ncdns Nightly Windows (64-bit x86) installer](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns-nsis/Cross-Compile%20Fedora/binaries/ncdns--win64-install.exe)
* [ncdns Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--windows_amd64.tar.gz)
* [ncdns Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--windows_386.tar.gz)
* [ncdns Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncdns/Cross-Compile%20Go%20latest/binaries/dist/ncdns--darwin_amd64.tar.gz)
* [ncdns Windows Installer Source Code](https://github.com/namecoin/ncdns-nsis)
* [ncdns rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [ncdns Source Code](https://github.com/namecoin/ncdns)

### Known Issues

* Build is not yet reproducible.

## generate_nmc_cert

generate_nmc_cert is a tool for generating TLS server certificates of the form expected by Namecoin.  If you run a `.bit` website, you should use generate_nmc_cert to create a TLS certificate for your website.

See the [documentation on setting up TLS for name owners]({{ "/docs/name-owners/tls/" | relative_url }}).

* generate_nmc_cert stable binaries are shipped with ncdns.
* [generate_nmc_cert Nightly GNU/Linux (64-bit POWER BE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_ppc64.tar.gz)
* [generate_nmc_cert Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_ppc64le.tar.gz)
* [generate_nmc_cert Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_arm64.tar.gz)
* [generate_nmc_cert Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_arm.tar.gz)
* [generate_nmc_cert Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_amd64.tar.gz)
* [generate_nmc_cert Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--linux_386.tar.gz)
* [generate_nmc_cert Nightly DragonFlyBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--dragonfly_amd64.tar.gz)
* [generate_nmc_cert Nightly FreeBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--freebsd_arm.tar.gz)
* [generate_nmc_cert Nightly FreeBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--freebsd_amd64.tar.gz)
* [generate_nmc_cert Nightly FreeBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--freebsd_386.tar.gz)
* [generate_nmc_cert Nightly NetBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--netbsd_arm.tar.gz)
* [generate_nmc_cert Nightly NetBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--netbsd_amd64.tar.gz)
* [generate_nmc_cert Nightly NetBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--netbsd_386.tar.gz)
* [generate_nmc_cert Nightly OpenBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--openbsd_amd64.tar.gz)
* [generate_nmc_cert Nightly OpenBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--openbsd_386.tar.gz)
* [generate_nmc_cert Nightly Solaris (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--solaris_amd64.tar.gz)
* [generate_nmc_cert Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--windows_amd64.tar.gz)
* [generate_nmc_cert Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--windows_386.tar.gz)
* [generate_nmc_cert Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/generate_nmc_cert/Cross-Compile%20Go%20latest/binaries/dist/generate_nmc_cert--darwin_amd64.tar.gz)
* [generate_nmc_cert Source Code](https://github.com/namecoin/generate_nmc_cert)

## certinject

certinject is a tool for adding and manipulating certificates in the Windows CryptoAPI certificate store.  Unlike the built-in Windows tool `certutil`, certinject can easily set the EKU (extended key usage, AKA enhanced key usage) and NC (name constraints) properties on certificates, and does not require Administrator privileges.

* certinject stable binaries are shipped with ncdns.
* [certinject Nightly GNU/Linux (64-bit POWER BE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_ppc64.tar.gz)
* [certinject Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_ppc64le.tar.gz)
* [certinject Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_arm64.tar.gz)
* [certinject Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_arm.tar.gz)
* [certinject Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_amd64.tar.gz)
* [certinject Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--linux_386.tar.gz)
* [certinject Nightly DragonFlyBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--dragonfly_amd64.tar.gz)
* [certinject Nightly FreeBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--freebsd_arm.tar.gz)
* [certinject Nightly FreeBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--freebsd_amd64.tar.gz)
* [certinject Nightly FreeBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--freebsd_386.tar.gz)
* [certinject Nightly NetBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--netbsd_arm.tar.gz)
* [certinject Nightly NetBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--netbsd_amd64.tar.gz)
* [certinject Nightly NetBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--netbsd_386.tar.gz)
* [certinject Nightly OpenBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--openbsd_amd64.tar.gz)
* [certinject Nightly OpenBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--openbsd_386.tar.gz)
* [certinject Nightly Solaris (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--solaris_amd64.tar.gz)
* [certinject Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--windows_amd64.tar.gz)
* [certinject Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--windows_386.tar.gz)
* [certinject Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/certinject/Cross-Compile%20Go%20latest/binaries/dist/certinject--darwin_amd64.tar.gz)
* [certinject Source Code](https://github.com/namecoin/certinject)

## Encaya

Encaya enables Namecoin TLS (positive overrides only) in applications that support AIA, such as Chromium.  Encaya is also a dependency of ncp11 and the Chromium version of DNSSEC-HSTS.

* Encaya stable binaries are shipped with ncdns.
* [Encaya Nightly GNU/Linux (64-bit POWER BE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_ppc64.tar.gz)
* [Encaya Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_ppc64le.tar.gz)
* [Encaya Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_arm64.tar.gz)
* [Encaya Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_arm.tar.gz)
* [Encaya Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_amd64.tar.gz)
* [Encaya Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--linux_386.tar.gz)
* [Encaya Nightly DragonFlyBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--dragonfly_amd64.tar.gz)
* [Encaya Nightly FreeBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--freebsd_arm.tar.gz)
* [Encaya Nightly FreeBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--freebsd_amd64.tar.gz)
* [Encaya Nightly FreeBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--freebsd_386.tar.gz)
* [Encaya Nightly NetBSD (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--netbsd_arm.tar.gz)
* [Encaya Nightly NetBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--netbsd_amd64.tar.gz)
* [Encaya Nightly NetBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--netbsd_386.tar.gz)
* [Encaya Nightly OpenBSD (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--openbsd_amd64.tar.gz)
* [Encaya Nightly OpenBSD (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--openbsd_386.tar.gz)
* [Encaya Nightly Solaris (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--solaris_amd64.tar.gz)
* [Encaya Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--windows_amd64.tar.gz)
* [Encaya Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--windows_386.tar.gz)
* [Encaya Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/encaya/Cross-Compile%20Go%20latest/binaries/dist/encaya--darwin_amd64.tar.gz)
* [Encaya Source Code](https://github.com/namecoin/encaya)

### Known Issues

* Build is not yet reproducible.

## cross_sign_name_constraint_tool

`cross_sign_name_constraint_tool` applies a name constraint exclusion to a DER-encoded TLS trust anchor via cross-signing, without that trust anchor's consent. The intended use case is to disallow a CA from issuing certificates for a domain name that it has no legitimate business issuing certificates for. For example:

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

* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Firefox]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-firefox.xpi)
* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Chromium/Chrome (Unpacked)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-chromium.zip)
* [DNSSEC-HSTS WebExtensions Component v0.0.2 for Chromium/Chrome (CRX)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-0.0.2-chromium-crx.tar.xz)
* [DNSSEC-HSTS Native Component v0.0.1 for GNU/Linux (64-bit x86)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-linux-x86_64.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for GNU/Linux (32-bit x86)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-linux-i686.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for Windows (64-bit x86)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-windows-x86_64.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for Windows (32-bit x86)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-windows-i686.tar.gz)
* [DNSSEC-HSTS Native Component v0.0.1 for macOS (64-bit x86)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/dnssec-hsts-native-0.0.1-osx-x86_64.tar.gz)
* [DNSSEC-HSTS v0.0.2 Signature (Release signed by Jeremy Rand)]({{ site.files_url }}/files/ncdns/ncdns-0.0.10.3/ncdns-0.0.10.3.SHA256SUMS.asc)
* [DNSSEC-HSTS rbm Build Harness Source Code](https://github.com/namecoin/ncdns-repro)
* [DNSSEC-HSTS WebExtensions Component Source Code](https://github.com/namecoin/dnssec-hsts)
* [DNSSEC-HSTS Native Component Source Code](https://github.com/namecoin/dnssec-hsts-native)

### Known Issues

* Build is not yet reproducible.

## ncp11

ncp11 enables Namecoin TLS in applications that support PKCS#11, such as Firefox and Tor Browser.

* ncp11 stable binaries are shipped with ncdns.
* [ncp11 Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20linux%20ppc64le/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20linux%20arm64/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20linux%20arm/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20linux%20amd64/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20linux%20386/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20windows%20amd64/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20windows%20386/binaries/dist/ncp11.tar.gz)
* [ncp11 Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/ncp11/Compile%20Go%20latest%20darwin%20amd64/binaries/dist/ncp11.tar.gz)
* [ncp11 Source Code](https://github.com/namecoin/ncp11)

### Known Issues

* Build is not yet reproducible.

## pkcs11mod

pkcs11mod is a library for making PKCS#11 modules in Go.  This download includes the pkcs11proxy and p11proxy modules.

* [pkcs11mod Nightly GNU/Linux (64-bit POWER LE) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20linux%20ppc64le/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly GNU/Linux (64-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20linux%20arm64/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly GNU/Linux (32-bit ARM) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20linux%20arm/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly GNU/Linux (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20linux%20amd64/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly GNU/Linux (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20linux%20386/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly Windows (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20windows%20amd64/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly Windows (32-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20windows%20386/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Nightly macOS (64-bit x86) plain binaries](https://api.cirrus-ci.com/v1/artifact/github/namecoin/pkcs11mod/Compile%20Go%20latest%20darwin%20amd64/binaries/dist/pkcs11mod.tar.gz)
* [pkcs11mod Source Code](https://github.com/namecoin/pkcs11mod)

## tlsrestrict_nss_tool

`tlsrestrict_nss_tool` applies a name constraint exclusion to an NSS sqlite database for all CKBI (built-in) TLS trust anchors, without those trust anchors' consent. The intended use case is to disallow public CA's from issuing certificates for TLD's with unique regulatory or policy requirements, such as:

* The `.bit` TLD used by Namecoin.
* A TLD controlled by your corporate intranet.

Namecoin users will probably want to use `tlsrestrict_nss_tool` to disallow all CA's that are on their system by default from signing `.bit` certificates.  For CA's that you manually imported yourself, you probably instead want `cross_sign_name_constraint_tool` (see above).

* [tlsrestrict_nss_tool v0.0.4.2 binaries for GNU/Linux, DragonFlyBSD, FreeBSD, NetBSD, OpenBSD, Solaris, Windows, macOS (hosted by GitHub)](https://github.com/namecoin/tlsrestrictnss/releases/tag/v0.0.4.2)
* [tlsrestrict_nss_tool Source Code at GitHub.](https://github.com/namecoin/tlsrestrictnss)

### Known Issues

* `tlsrestrict_nss_tool` will probably prevent HPKP from working as intended, unless HPKP is applied to user-defined trust anchors. Firefox is capable of doing this (though it's not the default); Chromium is not (as far as we know).
* Build is not yet reproducible.

## dns-prop279

dns-prop279 enables Namecoin naming (or any other naming method that speaks the DNS protocol) to be used with Tor, via the draft Prop279 pluggable naming API.  `.bit` domains can point to IP addresses (A/AAAA records), DNS names (CNAME records), and onion services.

See the [Namecoin Tor resolution documentation]({{ "/docs/tor-resolution" | relative_url }})
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

See the [Namecoin Tor resolution documentation]({{ "/docs/tor-resolution" | relative_url }}).

* ncprop279 stable binaries are shipped with ncdns.
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

## StemNS

StemNS enables Prop279 pluggable naming in Tor.  It is a dependency of ncprop279.  StemNS is a lightweight, security-focused fork of meejah's TorNS.

* [StemNS v0.1.1 Python tarball (hosted by GitHub)](https://github.com/namecoin/StemNS/releases/tag/v0.1.1)
* [StemNS Source Code at GitHub.](https://github.com/namecoin/StemNS)

## qlib

qlib is a memory-safe alternative to `dig`.  You can use qlib to debug DNS servers such as ncdns and Unbound.  qlib is a library-friendly refactorization of Miek Gieben's `q` tool.

* qlib stable binaries are shipped with ncdns.
* [qlib Source Code](https://github.com/namecoin/qlib)
