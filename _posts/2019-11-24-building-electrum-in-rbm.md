---
layout: post
title: "Building Electrum in rbm"
author: Jeremy Rand
tags: [News]
---

As I've [discussed before]({{site.baseurl}}2019/08/25/fixing-a-gzip-reproducibility-bug-in-tor-browser-and-rbm.html), Namecoin is using Tor's rbm-based build system for our various Go projects, such as ncdns and ncp11, in order to reduce the risk of supply-chain attacks.  I'm now looking into building Electrum in rbm as well.  Upstream Electrum's Python tarball binaries aren't reproducible at all, and their Windows binaries' reproducible builds are heavily dependent on sketchy dependencies that I'd prefer not to trust.  rbm offers a potential solution.

At this time, I've successfully gotten rbm to build an Electrum-NMC Python tarball that behaves pretty much the same as the standard build method (including the dependency bundling) -- except that it should be substantially more reproducible.  The only two components that aren't being built by my rbm descriptor are the Protobuf definition for the Payment Protocol (should be fixable easily, since I'm already building the Protobuf compiler) and the locales folder (hopefully easy to handle, I just haven't looked at it yet).

Building the Windows binaries in rbm is something I intend to look into later, though it's not at the top of my priority queue.  Obviously, the intent is to contribute all of this work upstream to Electrum.

This work was funded by Cyphrs.
