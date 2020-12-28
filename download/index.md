---
layout: page
title: Download
---

{::options parse_block_html="true" /}

## Namecoin Core Client (Stable Release)

* Name wallet: includes command-line interface for registering, tracking, updating, and renewing names (if you don't already have some namecoins, you'll need to [buy some at an exchange]({{site.baseurl}}exchanges/)).
* **No graphical interface for name wallet.  Use the Name Tab Beta (see below) if you require this functionality.**
* Name lookup: allows looking up names (use in combination with [ncdns]({{site.baseurl}}docs/ncdns) or NMControl to browse `.bit` domains).
* Currency wallet: includes graphical interface and command-line interface for receiving and sending namecoins.
* Recommended for miners.
* Recommended for users who don't own any names.
* Recommended for users who are comfortable registering, updating, and renewing their names via the command-line.

Current release: 0.19.0.1.

* [Namecoin Core 0.19.0.1 (GNU/Linux RISC-V 64-bit)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-riscv64-linux-gnu.tar.gz)
* [Namecoin Core 0.19.0.1 (GNU/Linux ARM 64-bit)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-aarch64-linux-gnu.tar.gz)
* [Namecoin Core 0.19.0.1 (GNU/Linux ARM 32-bit)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-arm-linux-gnueabihf.tar.gz)
* [Namecoin Core 0.19.0.1 (GNU/Linux x86 64-bit)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-x86_64-linux-gnu.tar.gz)
* [Namecoin Core 0.19.0.1 (GNU/Linux x86 32-bit)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-i686-pc-linux-gnu.tar.gz)
* [Namecoin Core 0.19.0.1 (Windows 64-bit installer)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-win64-setup-unsigned.exe)
* [Namecoin Core 0.19.0.1 (Windows 64-bit zip)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-win64.zip)
* [Namecoin Core 0.19.0.1 (macOS dmg)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-osx-unsigned.dmg)
* [Namecoin Core 0.19.0.1 (macOS tar.gz)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1-osx64.tar.gz)
* [Namecoin Core 0.19.0.1 (Source code tarball)](https://www.namecoin.org/files/namecoin-core/namecoin-core-0.19.0.1/namecoin-0.19.0.1.tar.gz)
* [Namecoin Core Gitian signatures](https://github.com/namecoin/gitian.sigs/)
* [Namecoin Core source code](https://github.com/namecoin/namecoin-core/)

## Namecoin Core Client (with Qt Name Tab)

* Name wallet: includes graphical interface and command-line interface for registering, tracking, updating, and renewing names (if you don't already have some namecoins, you'll need to [buy some at an exchange]({{site.baseurl}}exchanges/)).
* Name lookup: allows looking up names (use in combination with ncdns or NMControl to browse .bit domains).
* Currency wallet: includes graphical interface and command-line interface for receiving and sending namecoins.
* **Not suitable for mining.**

Current release: 0.13.99-name-tab-beta1.

[Source on GitHub](https://github.com/namecoin/namecoin-core).

<div class="row">

<div class="col-sm-4">

### Windows

* [64-bit Installer](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-win64-setup-unsigned.exe)
* [32-bit Installer](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-win32-setup-unsigned.exe)
* [64-bit zip](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-win64.zip)
* [32-bit zip](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-win32.zip)

[Gitian signatures at GitHub.](https://github.com/namecoin/gitian.sigs/tree/master/0.13.99-name-tab-beta1-win-unsigned)

</div>

<div class="col-sm-4">

### GNU/Linux

* [x86 64-bit tgz](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-x86_64-linux-gnu.tar.gz)
* [x86 32-bit tgz](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-i686-pc-linux-gnu.tar.gz)
* [ARM 64-bit tgz](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-aarch64-linux-gnu.tar.gz)
* [ARM 32-bit tgz](https://namecoin.org/files/namecoin-core-0.13.99-name-tab-beta1-notreproduced/namecoin-0.13.99-arm-linux-gnueabihf.tar.gz)

[Gitian signatures at GitHub.](https://github.com/namecoin/gitian.sigs/tree/master/0.13.99-name-tab-beta1-linux)

</div>

<div class="col-sm-4">

### macOS

**macOS binaries of Namecoin Core Name Tab Beta are not yet available.  For now, macOS users should use the Stable Release (see above), build Namecoin Core from source, or use Namecoin Legacy (see below).**

</div>

</div>

## Namecoin Legacy Client

* Use this instead of Namecoin Core if Namecoin Core doesn't work or if you need macOS binaries that include the name management tab.
* **Not suitable for mining or development.**
* **Always wait for six confirmations.**
* **Backup your `wallet.dat` before enabling wallet encryption.**

[Source on GitHub](https://github.com/namecoin/namecoin-legacy).

<div class="row">

<div class="col-sm-4">

### Windows

Download [v0.3.80 installer](https://namecoin.org/files/Namecoin_v0.3.80_setup.exe)<br>
[Release information and signatures](https://forum.namecoin.org/viewtopic.php?f=8&t=2123).

</div>

<div class="col-sm-4">

### GNU/Linux Packages

GNU/Linux packages provided by OBS.<br>
[Command line client (namecoind)](https://software.opensuse.org/download.html?project=home%3Ap_conrad%3Acoins&amp;package=namecoin).<br>
[Graphical interface (Namecoin-Qt)](https://software.opensuse.org/download.html?project=home%3Ap_conrad%3Acoins&amp;package=namecoin-gui).

</div>

<div class="col-sm-4">

### macOS

Download [v0.3.80 Namecoin-Qt](https://namecoin.org/files/Namecoin-Qt.app-0.3.80-a00c33d.zip).<br>
[Release information](https://forum.namecoin.org/viewtopic.php?f=8&t=2235).

</div>

</div>

## NMControl Middleware

NMControl connects your browser/application to the client. It allows you, for example, to browse .bit domains. [Source and installation instructions on Github](https://github.com/namecoin/nmcontrol).

<div class="row">

<div class="col-sm-4">

### Windows

Download [v0.8.1 installer](https://namecoin.org/files/NMControl_v0.8.1_setup.exe).<br>
[Release information and signatures (read this first)](https://forum.namecoin.org/viewtopic.php?f=8&t=2402).

</div>

<div class="col-sm-4">

### GNU/Linux and macOS

With Python 2.7 installed you can run nmcontrol.py directly from [source](https://github.com/namecoin/nmcontrol). If you need help ask on Github or on the [forum](https://forum.namecoin.org/viewtopic.php?f=8&t=2402).

</div>

</div>

## Help Us Test Betas

Want to help us test improvements in Namecoin?  Check out the [Beta Downloads]({{site.baseurl}}download/betas/) page.
