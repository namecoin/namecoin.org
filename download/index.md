---
layout: page
title: Download
---

{::options parse_block_html="true" /}

## Namecoin Core Client (with Qt Name Tab)

* Includes graphical interface and command-line interface for registering, tracking, updating, and renewing names (if you don't already have some namecoins, you'll need to [buy some at an exchange]({{site.baseurl}}exchanges/)).
* Allows looking up names (use in combination with ncdns or NMControl to browse .bit domains).
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

### Mac OS X

OS X builds of Namecoin Core are not yet available.  For now, either build Namecoin Core from source or use Namecoin Legacy.

</div>

</div>

## Namecoin Legacy Client

* Use this instead of Namecoin Core if Namecoin Core doesn't work or if you need OS X binaries.
* **Not suitable for mining or development.**
* **Always wait for six confirmations.**
* **Backup your `wallet.dat` before enabling wallet encryption.**

[Source on GitHub](https://github.com/namecoin/namecoin-legacy).

<div class="row">

<div class="col-sm-4">

### Windows

Download [v0.3.80 installer](https://namecoin.info/files/Namecoin_v0.3.80_setup.exe)<br>
[Release information and signatures](https://forum.namecoin.info/viewtopic.php?f=8&t=2123).

</div>

<div class="col-sm-4">

### Linux Packages

Linux packages provided by OBS.<br>
[Command line client (namecoind)](https://software.opensuse.org/download.html?project=home%3Ap_conrad%3Acoins&amp;package=namecoin).<br>
[Graphical interface (Namecoin-Qt)](https://software.opensuse.org/download.html?project=home%3Ap_conrad%3Acoins&amp;package=namecoin-gui).

</div>

<div class="col-sm-4">

### Mac OS X

Download [v0.3.80 Namecoin-Qt](https://namecoin.info/files/Namecoin-Qt.app-0.3.80-a00c33d.zip).<br>
[Release information](https://forum.namecoin.info/viewtopic.php?f=8&t=2235).

</div>

</div>

## NMControl Middleware

NMControl connects your browser/application to the client. It allows you, for example, to browse .bit domains. [Source and installation instructions on Github](https://github.com/namecoin/nmcontrol).

<div class="row">

<div class="col-sm-4">

### Windows

Download [v0.8.1 installer](https://namecoin.info/files/NMControl_v0.8.1_setup.exe).<br>
[Release information and signatures (read this first)](https://forum.namecoin.info/viewtopic.php?f=8&t=2402).

</div>

<div class="col-sm-4">

### Linux and Mac OS X

With Python 2.7 installed you can run nmcontrol.py directly from [source](https://github.com/namecoin/nmcontrol). If you need help ask on Github or on the [forum](https://forum.namecoin.info/viewtopic.php?f=8&t=2402).

</div>

</div>

## Namecoin Core Client (Stable Release)

* No graphical interface for managing names.
* No binaries; only source code.
* Recommended for miners.

[Download release 0.13.0rc1 on GitHub.](https://github.com/namecoin/namecoin-core/releases/tag/nc0.13.0rc1)

## Help Us Test Betas

Want to help us test improvements in Namecoin?  Check out the [Beta Downloads]({{site.baseurl}}download/betas/) page.
