---
layout: post
title: "ncdns rbm build scripts added support for Linux32, Win64, and Win32 targets"
author: Jeremy Rand
tags: [News]
---

As Hugo [mentioned previously]({{site.baseurl}}2019/04/15/ncdns-repro.html), rbm-based build scripts for ncdns are available.  rbm is the build system used by Tor Browser.  This work paves the way for reproducible builds of ncdns, improves the security of the build process against supply-chain attacks, and also paves the way for Windows and macOS support in our next-gen TLS interoperability codebase, ncp11 [1].  I've been spending some time improving those build scripts; here's what's new:

* Considerable effort has gone into shrinking the diff compared to upstream tor-browser-build as much as possible.  Upstream Tor has much better QA resources, so it's important to avoid deviating from what they do unless it's critically important.
* `binutils` and `gcc` are now dependencies of Go projects that use cgo.  This means that we build the compiler from a fixed version of the source code rather than using whatever compiler Debian ships with.  This brings us closer in line with what upstream tor-browser-build does, probably fixes some compiler bugs, and probably improves reproducibility.
* Linux cross-compiling was fixed.  Currently, this means that 32-bit x86 Linux targets now build.  In the future, once upstream tor-browser-build merges [my (currently WIP) patch](https://wiki.raptorcs.com/wiki/Porting/Tor_Browser) for cross-compiled Linux non-x86 targets (e.g. ARM and POWER), those targets should work fine with ncdns as well.
* Windows targets were fixed.  This mostly consisted of fiddling with dependencies (ncdns uses different libraries on Linux and Windows), but also meant adding the `mingw-w64` project from upstream tor-browser-build.

All of the above improvements are currently awaiting code review.

The next things I'll be working on are:

* Fixing macOS targets.  So far, all of the dependencies for ncdns build without errors, but ncdns itself fails because of an interesting bug that seems to manifest when two different cgo-enabled packages have the same name.  ncdns includes a fork of the Go standard library's `x509` package; both the forked package and the original package are dependencies of the ncdns package, and it turns out that the only OS where cgo is used in `x509` is... macOS.  We never noticed this before, because our existing ncdns macOS binaries are built without cgo (because no macOS cross-compiler was present); now that we're building in an environment where cgo is present for macOS, we're subject to whatever quirks impact cgo on macOS.  I think this is going to be pretty easy to work around by disabling cgo for the ncdns `x509` fork, but the cleanest way to do that is going to require getting a patch merged upstream to `tor-browser-build`.
* Adding an `ncdns-nsis` project, so that rbm builds the Windows installer.  This is already started, but I haven't gotten very far yet.
* Adding other Namecoin Go projects, such as `crosssignnameconstraint` and `ncp11`.  ncp11 is going to be especially interesting, due to its exercising of cgo code paths that almost no one uses.  This should be useful in finally getting ncp11 binaries for Windows and macOS [1].

This work was funded by NLnet Foundation's Internet Hardening Fund.

[1] Wait, you haven't heard about ncp11 yet?  Go check out [my 35C3 slides and workshop notes]({{site.baseurl}}2019/05/08/35c3-summary.html) about that!
