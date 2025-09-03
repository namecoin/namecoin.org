---
layout: post
title: "What's the maximum length of an AIA Issuer URL in Windows 11 CryptoAPI?"
author: Jeremy Rand
tags: [News]
---

For those of you who haven't seen my various conference talks about Namecoin TLS, AIA (*Authority Information Access*) is a mechanism for a TLS certificate to provide a URL where you can find the certificate of its issuer. Namecoin does some, uh, *creative* things with AIA. For reasons that will be elaborated on in a future post (don't worry, all will be explained there), I wanted to know the maximum length of the URL that AIA can link to.

I had no luck finding any such limit in any relevant RFC, nor could I find anyone on the Internet who had documented any such limit, so I had to fall back to experimentation. I ended up writing a patched certificate generator and AIA HTTP server that could test whether arbitrary AIA URL lengths were usable to build a certificate chain. I then wrote a PowerShell script that tried various AIA URL lengths with Windows 11's `certutil -verify`, to see what CryptoAPI's limits were.

After running some tests, I have some answers:

* AIA URL lengths up to `65534` bytes work fine.
* AIA URL lengths `65535` bytes and higher do not work.

I am not certain why the upper bound is *2* less than a power of 2. If it were *1* less than a power of 2, that would be sensible since that would indicate a length field that's an unsigned 16-bit integer. My best guess is that Windows is using a strange data structure that uses both a 16-bit length field *and* a NULL terminator.

Checking CryptoAPI's logs in Event Viewer indicates that none of the AIA-related code paths are running when the limit is exceeded.

Scope caveats:

* I only ran this test in Windows 11 24H2. I suspect that sufficiently old Windows releases are less tolerant.
* I don't know what happens if you try to put Unicode in the URL.
* I would not expect to see the same limit in other TLS clients that implement AIA, e.g. macOS.

Should you wish to reproduce these results yourself (*Science Rules!*), the code should be included in the next release of Encaya.

This work was funded by Power Up Privacy.
