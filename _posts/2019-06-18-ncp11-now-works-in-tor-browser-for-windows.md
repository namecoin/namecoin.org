---
layout: post
title: "ncp11 Now Works in Tor Browser for Windows"
author: Jeremy Rand
tags: [News]
---

ncp11 is now working (both positive and negative TLS certificate overrides) in Tor Browser for Windows.  It turned out that the only things keeping it from working properly once it [built without errors]({{site.baseurl}}2019/06/15/ncp11-now-builds-for-windows.html) were a couple of GNU/Linux-specific file path assumptions, both of which were quite easy to fix.

Actually testing it was mildly tricky, due to the fact that I was trying to use StemNS (a fork I made of meejah's TorNS tool) for the DNS resolution in Tor Browser, and it turns out that there was a bug in both upstream TorNS and StemNS that caused the Prop279 implementation to launch with an empty set of environment variables.  In GNU/Linux, this is harmless, but (surprise, surprise) in Windows this causes a variety of horrible effects, chief among which is that cryptographic software will be unable to generate random numbers and thus will crash.  I was going to find that out anyway once the Tor community started messing with StemNS, so probably a good thing that I found it early.  (I wish it hadn't taken me quite so long to figure out why things were crashing, but alas, that's life.)  StemNS now has a fix for that bug, and I've submitted a fix upstream to TorNS as well.

So, my estimate of what remains before we can release Tor Browser TLS support:

1. Get the remaining PR's merged to the relevant repos (in particular, ncdns-repro has a few pending PR's that are needed for this).
2. Tag a release and build/upload binaries.
3. Write some documentation (should be easy to adapt from the 35C3 workshop notes).

Meanwhile, I also tried ncp11 in Firefox for Windows (same installation method as in Tor Browser), and ran into some severe trouble there.  As far as I can tell, the ncp11 library is failing very early in the boot process: it doesn't even get as far as running the `init()` functions in the Go code.  Firefox gives a relatively useless "library failure" error, which is presumably a different code path from the "library failure" error that I'm getting in Debian when loading ncp11 into Firefox via a totally different installation method from the Tor Browser method.

Inspecting Mozilla's CKBI library and ncp11 with the `file` commmand yielded 2 noticeable differences in file format:

1. CKBI's PE metadata is set to use the GUI subsystem, while ncp11 is set to use the console subsystem.
2. CKBI isn't stripped, while ncp11 is stripped.

Difference 1 was ruled out by switching ncp11's PE metadata to use the GUI subsystem; it didn't help.  Difference 2 is certainly a possible explanation, and I'll spend some time later checking what happens if ncp11 isn't built with the `-s` linker flag.  That said, I suspect that the best way to figure out what's going wrong is to patch in some debug output to Firefox and NSS so that I can figure out what code path the "library failure" error is happening in.

However, as curious as I am to see what's failing in Firefox, it should be noted that ncp11's current funding from NLnet is contingent on Tor Browser support, not Firefox support, which means that I'm unlikely to spend a lot of time debugging the Firefox failure in the near future (especially since the "TLS for Tor Browser" milestone for NLnet has already gone severely over-budget due to the unexpectedly large amount of R&D needed to produce ncp11).  I'll probably resume the Firefox debugging after we've secured more funding for this effort.

In the meantime, Namecoin TLS support for Tor Browser is likely to be released very soon.  Yay!

This work was funded by NLnet Foundation's Internet Hardening Fund.
