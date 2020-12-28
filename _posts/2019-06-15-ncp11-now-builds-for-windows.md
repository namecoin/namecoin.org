---
layout: post
title: "ncp11 Now Builds for Windows Targets"
author: Jeremy Rand
tags: [News]
---

ncp11 (our next-gen Namecoin TLS interoperability software for Firefox, Tor Browser, and other NSS-based software) now builds without errors for Windows targets, including rbm descriptors.  Getting it to build was a little bit more involved than just tweaking the rbm end of things, because the PKCS#11 spec requires that structs be packed on Windows, while Go doesn't support packed structs.  So, some minor hackery was needed (I wrote a C function that converts between packed and unpacked structs).  Kudos to Miek Gieben (author of the Go pkcs11 package) for his useful sample code, which made this fix quite easy to code up.

Meanwhile, qlib (our Go library for DNS queries, based on Miek's q command-line tool) has also been fixed to build in rbm for Windows targets.  This was just a matter of fixing some sloppiness that snuck into the rbm descriptors, which happened to not be causing any problems on GNU/Linux targets due to dumb luck.  All of our rbm projects that depend on qlib (specifically, certdehydrate-dane-rest-api and dnssec-hsts-native) also now build for Windows targets.

It should be noted that ncp11 probably doesn't actually *work* as intended on Windows and macOS targets yet.  I already fixed a couple of GNU/Linux-specific assumptions in ncp11's codebase yesterday, and there are likely to be more that will need fixing before ncp11 will actually be usable on Windows and macOS targets.  Presumably these will be teased out with further testing.

This work was funded by NLnet Foundation's Internet Hardening Fund.
