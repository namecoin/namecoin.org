---
layout: post
title: TLS Support for Chromium on Windows Released
author: Jeremy Rand
tags: [Releases, ncdns Releases]
---

After quite a bit of code cleanup, we've released a new beta of ncdns for Windows, which includes Namecoin-based TLS certificate validation for Chromium, Google Chrome, and Opera on Windows.  This includes both the CryptoAPI certificate injection and NUMS HPKP injection that were discussed previously.  You can download it on the [Beta Downloads page]({{site.baseurl}}download/betas/#ncdns).  We've also posted binaries of ncdns (without install scripts or TLS support) for a number of other operating systems; they're also linked on the Beta Downloads page.

Credit for this release goes to:

* Jeremy Rand: Cert injection Go implementation; NUMS HPKP injection concept and Go implementation; review of Hugo's code.
* Hugo Landau: Cert injection NSIS implementation; NUMS HPKP injection NSIS implementation; review of Jeremy's code.
* Ryan Castellucci: Dehydrated certificates concept+algorithm; NUMS hash algorithm and Python implementation.

This work was funded by NLnet Foundation's Internet Hardening Fund.

Meanwhile, Namecoin TLS development focus has started to shift toward Firefox TLS support.
