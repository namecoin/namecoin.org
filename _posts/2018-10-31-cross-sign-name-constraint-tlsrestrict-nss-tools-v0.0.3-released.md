---
layout: post
title: cross_sign_name_constraint_tool v0.0.3 and tlsrestrict_nss_tool v0.0.3 Released
author: Jeremy Rand
tags: [Releases, ncdns Releases]
---

We've released `cross_sign_name_constraint_tool` v0.0.3 and `tlsrestrict_nss_tool` v0.0.3.  Here's what's new:

* Both `cross_sign_name_constraint_tool` and `tlsrestrict_nss_tool`:
    * Properly handle input CA's that don't have a CommonName.
    * Code quality improvements.
* `tlsrestrict_nss_tool` only:
    * Compatibility fixes for Windows:
        * Stop using `cp` to enable CKBI visibility, since no such command exists on Windows.
        * Pass cert nicknames in NSS `certutil` batch files instead of as command-line args, because Windows doesn't handle Unicode command-line args correctly.
    * Error when CKBI appears to be empty; this is usually a symptom of missing libraries.
    * Communicate with `certutil` via PEM instead of DER; this should reduce the risk of concatenated certs not having a clearly defined boundary.
    * Fix compatibility with Go 1.11 and higher.
    * Fix cert deletion on Fedora 28 and higher (and probably various other platforms too).
    * Partial support for bundling both 32-bit and 64-bit `certutil` on Windows.
    * Partial support for continuously syncing an NSS DB on Windows whenever CKBI is updated (not yet ready for use; will be included in a future ncdns release).
    * Code quality improvements.

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#cross_sign_name_constraint_tool).

This work was funded by NLnet Foundation's Internet Hardening Fund.
