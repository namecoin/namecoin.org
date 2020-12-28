---
layout: post
title: "ncp11 Now Builds in rbm for GNU/Linux (64-bit and 32-bit)"
author: Jeremy Rand
tags: [News]
---

ncp11 is the next-gen Namecoin TLS interoperability project that Aerth and I have been cooking up in the Namecoin R&D lab for a while.  (See my [35C3 slides and workshop notes]({{site.baseurl}}2019/05/08/35c3-summary.html) for more info on it if you haven't heard about it yet.)  Last month, I [mentioned]({{site.baseurl}}2019/05/16/ncdns-rbm-linux32-win64-win32.html) that I intended to get ncp11 building in rbm.  I now have ncp11 building in rbm for GNU/Linux 64-bit and 32-bit x86 targets.  32-bit support involved fixing a bug in ncdns's usage of PKCS#11 (specifically, ncp11 was making type assumptions that are only valid on 64-bit targets, which produced a build error on 32-bit targets).  I've tested the resulting 64-bit binary in a Debian Buster VM, and it works fine when used as a drop-in replacement for NSS's CKBI library.  (It looks like there are issues when loaded alongside CKBI, which I'll need to debug when I have some free time, but this isn't a release blocker, and the same issues are reproducible with the non-rbm binary I used at 35C3.)

This work was funded by NLnet Foundation's Internet Hardening Fund.
