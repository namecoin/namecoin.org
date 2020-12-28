---
layout: post
title: "Fixing a gzip Reproducibility Bug in Tor Browser and rbm"
author: Jeremy Rand
tags: [News]
---

As I've [discussed before]({{site.baseurl}}2019/08/06/decoupling-ncdns-go-versions.html), Namecoin is using Tor's rbm-based build system for our various Go projects, such as ncdns and ncp11, in order to reduce the risk of supply-chain attacks.  Naturally, one of the important ways to test a reproducible build system is to build a binary twice in a row and see if the hashes are the same.  If the hashes don't match, then tools like [Diffoscope](https://diffoscope.org/) can be used to figure out what the source of the reproducibility failure is.  Now that Namecoin's usage of rbm is reasonably stable (i.e. working binaries are produced for most of Namecoin's software now), it's a good time to look into how reproducible our binaries are.

So, I tried building ncdns twice to see if I got matching hashes.  Alas, the hashes did not match.  Plugging the results into Diffoscope yielded the information that the files within the `.tar.gz` archive were indeed identical, but that the time value embedded in the gzip header was nonreproducible.  Given that this didn't seem like anything I had screwed up on my end, I tried building a `.tar.gz` binary from upstream Tor Browser.  Same issue: nonreproducible binaries due to gzip header time values.

I also observed that `.tar.xz` binaries weren't affected by the issue.  This would explain why upstream Tor hadn't noticed or fixed the bug on their end -- all of their end-user binaries are `.tar.xz`; `.tar.gz` is only used by Tor for intermediate binaries, which probably aren't tested for reproducibility as thoroughly.  Obviously, Namecoin could work around the issue by switching to `.tar.xz` for end-user binaries (I was planning to do this anyway since `.tar.xz` archives have much better compression), but since Namecoin likes to be a good neighbor, I figured it was a good idea to report the bug upstream to Tor.

After some discussion with Nicolas from Tor (lead developer of rbm), we converged on a 2-line patch to rbm that should resolve the issue.  Once this patch is merged upstream, Namecoin binaries will be substantially closer to reproducibility, and as a bonus, the intermediate binaries produced by Tor will probably be reproducible too.

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.
