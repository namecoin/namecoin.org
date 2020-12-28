---
layout: page
title: "Namecoin 36C3 Workshop: Namecoin in Tor Browser Demo"
redirect_from:
  - /36c3-workshop/
---

{::options parse_block_html="true" /}

Welcome to the 36C3 Namecoin / Tor Browser Workshop.  We'll walk you through the steps below, feel free to follow along in this document.

## Prerequisites

You'll need a GNU/Linux system to run Namecoin in Tor Browser.  Either bare-metal or a VM is fine.  Note that Tails, Whonix, and Subgraph OS will probably **not** work.

## Download Tor Browser

If you don't already have Tor Browser, you'll need to download and install it.  [https://www.torproject.org/download/](https://www.torproject.org/download/)

## Download Tor Browser Nightly

Tor Browser Nightly builds are available via an onion service managed by boklm from Tor: [http://f4amtbsowhix7rrf.onion/tor-browser-builds/](http://f4amtbsowhix7rrf.onion/tor-browser-builds/)

Proof of authenticity (if you trust public TLS CA's and DNS): [https://trac.torproject.org/projects/tor/wiki/doc/TorBrowser/Hacking#NightlyBuilds](https://trac.torproject.org/projects/tor/wiki/doc/TorBrowser/Hacking#NightlyBuilds)

Download and install the latest Tor Browser Nightly release.  You want either `nightly-linux-i686` or `nightly-linux-x86_64` depending on whether your GNU/Linux machine is 32-bit or 64-bit.  You want the `.tar.xz` archive, not the `.mar` archive.

## Run Tor Browser Nightly

Verify that you can visit regular websites in Tor Browser Nightly, e.g. [https://www.torproject.org/](https://www.torproject.org/)

Then close Tor Browser Nightly.

## Run Tor Browser Nightly with Namecoin enabled

Run Tor Browser Nightly with the environment variable `TOR_ENABLE_NAMECOIN=1`.

If you don't know how to set environment variables, there are (at least) 3 ways you can do this **(only do 1 of the following)**:

1. Persistently enable Namecoin (unless you revert the setting).
   
   Run the following:
   
   `echo "export TOR_ENABLE_NAMECOIN=1" >> ~/.profile`
   
   Then reboot your machine, and run Tor Browser Nightly as usual.  ``
   
2. Enable Namecoin for one terminal session.

   Run the following in a terminal:
   
   `export TOR_ENABLE_NAMECOIN=1`
   
   You can now start Tor Browser Nightly from that terminal session like this:
   
   `./start-tor-browser.desktop`
   
3. Enable Namecoin for one Tor Browser session.
   
   Start Tor Browser Nightly from a terminal like this:
   
   `TOR_ENABLE_NAMECOIN=1 ./start-tor-browser.desktop`

## Try some Namecoin onion services

All of the following Namecoin onion services should work in Tor Browser Nightly:

* [http://federalistpapers.bit/](http://federalistpapers.bit/)
* [http://onionshare.bit/](http://onionshare.bit/)
* [http://riseuptools.bit/](http://riseuptools.bit/)
* [http://submit.theintercept.bit/](http://submit.theintercept.bit/)
* [http://submit.wikileaks.bit/](http://submit.wikileaks.bit/)

Try viewing the circuit display in Tor Browser while on a Namecoin site.  It will show the real `.onion` domain next to the `.bit` domain.

You can use either `.bit` or `.bit.onion` suffixes.  They currently have identical semantics, though `.bit` might be capable of pointing to IP addresses in the future.  `.bit` domains won't show up as having a secure origin (`.bit.onion` correctly is marked as secure); this is a bug in the Namecoin Tor Browser integration that will be fixed later.

## Discussion

* What do you think?
* What should we improve on?
* Let us know your questions, comments, etc.
