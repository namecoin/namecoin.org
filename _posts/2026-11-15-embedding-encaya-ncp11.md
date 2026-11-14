---
layout: post
title: "Embedding Encaya in ncp11"
author: Jeremy Rand
tags: [News]
---

ncp11 and Encaya have historically always been distinct files: a PKCS#11 module and a standard executable. ncp11 acts as a shim, leaving all the hard work to Encaya. The intent of this segregation was to have better isolation in case something goes horribly wrong (a Go panic inside ncp11 would cause Firefox to crash). However, that isolation comes at a cost: two files are larger than one file. For some users, this is the right tradeoff, but Tor Browser has some pretty strong constraints on download size, so I've been looking into whether the opposite tradeoff is workable.

Robert has refactored Encaya to be callable as a library that can be statically linked into ncp11, and meanwhile I've refactored ncp11 to abstract the Encaya calling method. (The HTTP client/server libraries have been stripped out in this mode, so they don't contribute to the build size.) The default remains the two-file mode, but you can now pass `-tags "ncp11_encaya_embedded"` to the ncp11 build to use an embedded Encaya instance.

An incidental benefit here is that `encayagen` is embedded inside ncp11 as well, meaning that the Encaya root CA is never persisted to disk. This might yield some security benefit if you're worried about an attacker who can read your local storage.

So how does the size improvement stack up?

* **Before**:
    * libncp11.so: 10.3 MiB
    * encaya: 18.9 MiB
    * encayagen: 13.5 MiB
    * **Total**: 42.8 MiB
* **After**:
    * libncp11+encaya.so: 14.4 MiB

That's a size ratio of 2.97x! Not a bad result.

This work was funded by NLnet Foundation's NGI0 Core Fund.
