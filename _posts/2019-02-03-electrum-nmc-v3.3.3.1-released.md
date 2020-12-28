---
layout: post
title: "Electrum-NMC v3.3.3.1 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.3.1.  This release includes important security fixes from upstream Electrum, and we recommend that all users upgrade.  Here's what's new since v3.2.4b1:

* Fix accidental Namecoin rebranding in the AuxPoW branch that was causing the AuxPoW branch to error.
* Fix some tests that were failing.
* Fix broken imports in revealer plugin.
* Various fixes for the Android port.
* Rebranding fixes for the Qt GUI.
* Fix filter columns in the Manage Names tab.
* Fix compatibility of Manage Names tab with current upstream Electrum.
* Fix bug where some names were missing from the Manage Names tab.
* Fix Renew and Configure buttons in Manage Names tab.
* Fix Max button on Send tab.
* Rebranding fixes for history list.
* Rebranding fixes for exported history.
* Fix broken imports in KeepKey plugin.
* Fix broken imports in Labels plugin.
* Fix bug that prevented using Coin Control for name updates.
* Add 2 new servers.
* Improve documentation of timewarp hardfork.
* Rebranding fixes for update check.
* Fix icons.
* Windows binaries are available again.
* Improvements from upstream Electrum (**including security fixes**).

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.
