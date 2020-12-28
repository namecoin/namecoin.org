---
layout: post
title: "Electrum-NMC v3.3.10 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.10.  This release (which is still based on upstream Electrum v3.3.8) includes a few high-demand bug fixes that we wanted to get released before upstream Electrum tags v4.0.0.

Here's what's new since v3.3.9.1:

* From upstream Electrum:
    * Build script fixes.  (Backported from Electrum v4.0.0.)
    * Fix connecting to non-DNS IPv6 servers on Windows.  (Backported from Electrum v4.0.0.)
* Namecoin-specific:
    * Features:
        * Enable Renew/Configure buttons based on selection.  (Patch by Jeremy Rand.)
    * Bug fixes:
        * Fix `name_show` fault detection.  (Patch by Jeremy Rand; thanks to s7r for reporting issue.)
        * Fix exception when right-clicking on a `name_new` for which the name identifier is unknown in `UNOList`.  (Patch by Jeremy Rand; thanks to ghost for reporting issue.)
        * Fix exception handling in name registration Qt GUI.  (Patch by Jeremy Rand; thanks to s7r for reporting issue.)
        * Fix Mempool-based fee estimation limits.  (Patch by Jeremy Rand; thanks to s7r for reporting issue.)

Unfortunately, due to a currently-unresolved upstream bug, we are not able to provide Android/Linux binaries at this time.  Android/Linux users should remain on v3.3.9.1.

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).
