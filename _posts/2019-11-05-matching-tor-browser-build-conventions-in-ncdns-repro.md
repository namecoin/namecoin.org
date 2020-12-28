---
layout: post
title: "Matching tor-browser-build Conventions in ncdns-repro"
author: Jeremy Rand
tags: [News]
---

As I've [discussed before]({{site.baseurl}}2019/08/25/fixing-a-gzip-reproducibility-bug-in-tor-browser-and-rbm.html), Namecoin is using Tor's rbm-based build system for our various Go projects, such as ncdns and ncp11, in order to reduce the risk of supply-chain attacks.  Namecoin's relevant Git repository, ncdns-repro, is heavily based on a Tor repo, tor-browser-build.  As we gained more experience with using rbm, it became more clear that even trivial deviations from upstream tor-browser-build can cause interoperability headaches.  So, I've been bringing ncdns-repro more in line with tor-browser-build conventions.  In particular, two noticeable changes have been made.

First off, rbm divides the build scripts into "projects".  For example, in Tor Browser, OpenSSL is a project, as is Tor, as is Firefox, as is GCC, etc.  Projects can depend on each other (for example, Tor depends on OpenSSL, and OpenSSL, Tor, and Firefox all depend on GCC).  When ncdns-repro was initially created, we didn't really think much about the project names, and on a whim decided to the projects written in Go names that reflected their full package path.  For example, the Go package `golang.org/x/crypto` was given an rbm project name of `golang.org,x,crypto` in ncdns-repro.  In contrast, upstream tor-browser-build gives their Go-based projects abbreviated names, e.g. the aforementioned package was given an rbm project name of `goxcrypto` [1].  Unfortunately, we figured out via experience that this causes problems, especially when ncdns-repro pulls in data from tor-browser-build (or vice versa) as a Git submodule, because it means that if a project from one repo wants to pull in a project from another repo as a dependency, the project names will be inconsistent.

Second, ncdns-repro stored all of the Git hashes for its projects in a root-directory-level file called `hashlist`, whereas upstream tor-browser-build stores them in the configuration file in each project's directory.  The intent on our end was to make it easier to enumerate all of the Git hashes, but again, experience showed that this causes problems when Git submodules are used to let tor-browser-build and ncdns-repro share configuration data.

As of now, ncdns-repro uses the same project naming conventions as tor-browser-build, and no longer uses a `hashlist` file.  This should improve interoperability of ncdns-repro with tor-browser-build going forward.

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.

[1] Insert snarky reference to Mark Karpeles here.
