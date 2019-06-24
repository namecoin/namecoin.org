---
layout: post
title: "More rbm Projects Added: DNSSEC-HSTS, certdehydrate-dane-rest-api, Dependencies, and macOS Support"
author: Jeremy Rand
tags: [News]
---

A few days ago I [mentioned ]({{site.baseurl}}2019/06/12/ncp11-now-builds-in-rbm-gnu-linux-64-bit-and-32-bit.html) that ncp11 now builds in rbm.  As you may recall, rbm is the build system used by Tor Browser; it facilitates reproducible builds, which improves the security of the build process against supply-chain attacks.  I've now added several new projects/targets to Namecoin's rbm descriptors:

* DNSSEC-HSTS now builds.  For those of you who aren't familiar with DNSSEC-HSTS, see my [35C3 slides]({{site.baseurl}}2019/05/08/35c3-summary.html).
* certdehydrate-dane-rest-api now builds.  This is a backend tool that's used by both ncp11 and DNSSEC-HSTS.
* Dependencies of the above, including:
    * qlib (a library for flexible DNS queries, based on Miek Gieben's excellent q CLI tool).
    * crosssign (a library for cross-signing X.509 certificates).
    * safetlsa (a library for converting DNS TLSA records into certificates that are safe to import into a TLS trust store, using dehydrated certificates and name constraints).
* ncdns can now be built as a library, not just as an executable.  This was needed in order to build certdehydrate-dane-rest-api.
* ncdns now builds for macOS.
* Several library dependencies were updated; this fixes a number of bugs that existed due to accidentally using outdated dependencies.  (Chief among them was a bug that broke ncdns's ability to talk to ConsensusJ-Namecoin and Electrum-NMC.)  Thanks to grringo for catching this.

I've also submitted a patch to upstream Tor that will hopefully allow us to make our rbm descriptors a lot cleaner.  Specifically, upstream Tor has a special template for building Go libraries, but it doesn't work for Go executables, so Go executable projects need to have a bunch of boilerplate.  My patch allows the Go library template to work with executable projects as well.  That patch is currently awaiting review.

This work was funded by NLnet Foundation's Internet Hardening Fund.
