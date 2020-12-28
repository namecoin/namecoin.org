---
layout: post
title: "Electrum-NMC v3.3.9.1 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.9.1.  This release (which is still based on upstream Electrum v3.3.8) includes a few high-demand new features and bug fixes that we wanted to get released before upstream Electrum tags v4.0.0.

Here's what's new since v3.3.8:

* From upstream Electrum:
    * Build script fixes backported from Electrum v4.0.0.
* Namecoin-specific:
    * Features:
        * Add DNS builder GUI based on Namecoin Core.  (Patch by Jeremy Rand; based on a Namecoin Core patch by Brandon Roberts.)
        * Add more servers.  (Patches by Jeremy Rand; thanks to deafboy, ccomp, and s7r for running the servers.)
        * Allow pausing network on startup; unpause via an RPC command (mostly relevant for Tor Browser integration).  (Patch by Jeremy Rand; thanks to Georg Koppen and mjgill89 for reporting Tor Browser issue; thanks to SomberNight for brainstorming solutions.)
        * Update checkpoint.  (Patch by Jeremy Rand.)
    * Bug fixes:
        * Return correct error code when looking up nonexistent names.  Fixes issue where ncdns was recognizing this error as `SERVFAIL` instead of `NXDOMAIN`.  (Patch by Jeremy Rand; thanks to Georg Koppen for reporting Tor Browser issue.)
        * Fix connectivity issues that could cause slow syncup or syncup getting stuck completely (these bugs were related to the stream isolation and parallel chain download patches).  (Patches by Jeremy Rand; thanks to Georg Koppen, mjgill89, and s7r for reporting issues.)
        * Fix minor error handling bugs in name registration GUI and `name_show` RPC command.  (Patches by Jeremy Rand; thanks to s7r for reporting issues.)
        * Add some additional AuxPoW checks.  (Patches by Jeremy Rand.)
        * Disable stream-isolated server pool if in `oneserver` mode (fixes a privacy leak).  (Patch by Jeremy Rand; thanks to s7r for reporting issue.)
        * Fix missing help text for `name_show` RPC command.  (Patch by Jeremy Rand.)
        * Fix missing locale data in Python binaries.  (Patch by Jeremy Rand.)

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).
