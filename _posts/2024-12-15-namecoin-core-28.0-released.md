---
layout: post
title: "Namecoin Core 28.0 Released (UPDATED)"
author: Jeremy Rand
tags: [Releases, Namecoin Core Releases]
---

Namecoin Core 28.0 has been released on the [Downloads page]({{ "/download/#namecoin-core-client-stable-release" | relative_url }}).

Here's what's new since 22.0:

* RPC
    * Disambiguate "expired" from "never existed" in `name_show` error message. (Patch by Jeremy Rand; Review by Daniel Kraft.)
* GUI
    * Disable configuring/renewing names that are unspendable due to expiration or transfer. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Clarify passphrase dialog to make clear that names are protected by the passphrase. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Clarify Receive tab to make clear that it can be used for name transfers. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Fix suboptimal Unicode usage in Manage Names tab. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Add "Export" button to Manage Names tab. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * `name_firstupdate` Qt GUI. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Add decoration for incoming and outgoing name transfers. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Add decoration for name renewals. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Move name operation into Type column. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Add icon for Configure Name button. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Show name count in Manage Names tab. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Check availability in Buy Names tab. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Show `.bit` form for `d/` names in `TransactionRecord`. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Show namespace in Type column of Transactions tab. (Patch by Jeremy Rand; Review by Daniel Kraft and Yanmaani.)
    * Prioritize Data over Transfer in tab order in Configure Name dialog. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Avoid jargon in Configure Name dialog. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Show value size in Configure Name dialog. (Patch by Jeremy Rand; Review by Daniel Kraft.)
    * Check for invalid JSON in Configure Name dialog. (Patch by Rose Turing; Review by Jeremy Rand and Daniel Kraft.)
    * Check for non-minimal JSON in Configure Name dialog. (Patch by Rose Turing; Review by Jeremy Rand and Daniel Kraft.)
* Misc
    * Use `fundrawtransaction` more in the suggested atomic name trades workflow. (Patch by Daniel Kraft; Review by Yanmaani.)
    * Add mainnet DNS seeds from s7r. (Patch by s7r; Review by Daniel Kraft and Jeremy Rand.)
    * Fix missing `#include` in `buynamespage.h`. (Patch by Zoltan Konder; Review by Daniel Kraft and Jeremy Rand.)
* Numerous improvements from upstream Bitcoin Core.

Known potential issues (will hopefully be resolved soon):

* Initial peer discovery may not work reliably over Tor.
* Setting `-fallbackfee` may be needed if you don't want to wait some blocks before you can issue transactions.
* The Buy Names tab only performs `name_firstupdate`, not `name_new`; you'll have to do `name_new` from the console first.
* The Buy Names tab might require setting `-addresstype bech32 -changetype bech32`.
* Some GUI lag is present when switching to the Overview and Transactions tabs, and when scrolling in the Transactions tab.
* Old BDB-based wallets are no longer supported (per upstream policy). Migration of BDB wallets to the new Descriptor wallets is not thoroughly tested, so if you have high-value BDB wallets, you may want to back them up and keep an old version of Namecoin Core around until you are confident that your wallets migrated properly.

~~Why is it on the Beta Downloads page, you ask? As of this writing, we only have 1 set of Guix signatures, and we require 2 sets to do a release. For logistical optimization reasons, we have decided to upload the binaries and publish the changelog now. However, do not consider the release to be official until a 2nd set of matching Guix signatures has had a PR submitted (which we expect to be in the next week). We fully expect these binaries to be bit-for-bit identical to the ones that we place on the main Downloads page in a little while. If you see another set of matching Guix signatures by the time you read this, then you can safely conclude that these binaries are of the quality you would normally expect on the main Downloads page.~~

Huge thanks to Rose Turing and mjgill89 for Guix-signing this release. Also huge pre-emptive thanks to Robert Nganga for Guix-signing this release in the next week or so.

This work was funded by Cyphrs.
