---
layout: post
title: "Namecoin Core 0.18.0 Released, Softfork Incoming at Mainnet Block Height 475,000"
author: Jeremy Rand
tags: [Alerts, Namecoin Core Alerts, Releases, Namecoin Core Releases]
---

Namecoin Core 0.18.0 has been released on the [Downloads page]({{site.baseurl}}download/#namecoin-core-client-stable-release).  This release schedules a softfork for block height 475,000 on mainnet.  Contained in the softfork are:

* P2SH
* CSV
* SegWit

All three of these softfork components are already active in Bitcoin, and should be uncontroversial.  We had originally discussed lowering the block weight limit as part of this softfork, but we decided to defer block weight discussion for a later date, as the extra review procedures involved in changing the block weight limit would have delayed the release, and we wanted to get the softfork activated as soon as feasible.  So, for this softfork, the block weight limit is the same as that of Bitcoin.

**Due to the softfork, we strongly recommend that miners, exchanges, registrars, explorers, ElectrumX servers, and all other service providers upgrade as soon as possible.**  End users who do not need the name management GUI are also strongly encouraged to upgrade.

At this time, the estimated activation date of the softfork is 82 days from now.  However, this may vary depending on hashrate fluctuations, so do not wait until the last minute to upgrade.

See [#239](https://github.com/namecoin/namecoin-core/issues/239) for more details on the softfork.

Also included in this release:

* Windows binaries are available again.
* The `options` argument for `name_new`, `name_firstupdate` and `name_update` can now be used to specify per-RPC encodings for names and values by setting the `nameEncoding` and `valueEncoding` fields, respectively.
* `name_scan` now accepts an optional `options` argument, which can be used to specify filtering conditions (based on number of confirmations, prefix and regexp matches of a name).  See [#237](https://github.com/namecoin/namecoin-core/issues/237) for more details.
* `name_filter` has been removed.  Instead, `name_scan` with the newly added filtering options can be used.
* `ismine` is no longer added to RPC results if no wallet is associated to an RPC call.
* Numerous improvements from upstream Bitcoin Core.
