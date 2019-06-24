---
layout: post
title: "Progress on reproducibility of ncdns builds"
author: Hugo Landau
tags: [News]
---

As part of work to ensure that all Namecoin software can be built and
distributed in a reproducible fashion, RBM build scripts for ncdns are [now
available](https://github.com/hlandau/ncdns-repro). These scripts are currently
experimental, but will become the preferred way to build ncdns.

The RBM build system is specifically designed to facilitate reproducible builds
and is also commonly used to build Tor Browser. The RBM build scripts for ncdns
build on the existing Tor Browser build system, which will ease future
integration of ncdns with Tor Browser in a reproducible manner.

This work was funded by NLnet Foundation's Internet Hardening Fund.
