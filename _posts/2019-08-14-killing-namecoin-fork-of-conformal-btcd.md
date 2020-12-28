---
layout: post
title: "Killing Namecoin's Fork of Conformal's btcd"
author: Jeremy Rand
tags: [News]
---

One of the lesser-known dirty secrets of the ncdns codebase [1] is that it relies on an unmaintained fork of Conformal's btcd, which dates back to 2015.  Specifically, ncdns uses a fork of the JSON-RPC client from btcd in order to query Namecoin Core, ConsensusJ-Namecoin, or Electrum-NMC.  Why did Namecoin not find upstream btcd to be sufficient?

1. btcd's RPC client expected a modern Bitcoin Core codebase to be used, and in 2015 Namecoin was somewhat behind upstream Bitcoin Core.  Thus Hugo needed to add a patch to avoid compatibility issues.
2. btcd's RPC client expected JSON-RPC 1.0 to be used, and errored when it encountered JSON-RPC 2.0.  Both ConsensusJ-Namecoin and Electrum-NMC use JSON-RPC 2.0, so I had to add a patch to avoid that error.
3. btcd's RPC client didn't support cookie authentication, and Namecoin Core is easiest to set up when cookie authentication is in use.  Thus Hugo had to implement cookie authentication.

To make matters more complicated, Conformal decided to rewrite btcd's JSON-RPC client from scratch a few months after Namecoin forked it; the rewrite has a completely different API, so it wasn't a drop-in replacement.  This was yet further complicated by the fact that one of the features in the original btcd JSON-RPC client's API allowed adding custom RPC methods for altcoins (e.g. `name_show` and `name_scan`), which ncdns relied on; the rewrite's API doesn't expose that functionality nearly as cleanly.

We've been throwing around the idea of using upstream Conformal's btcd package for a while, but finally I decided to start implementing it.  Happily, Conformal includes example code for using the new API, so it wasn't hard to get it to talk to Namecoin Core.  I submitted a patch to Conformal that exposes the API features needed for custom RPC methods (the patch was pretty easy to write, and hopefully will be merged soon).  I also implemented `name_show` and `name_scan` for btcd.  (ncdns also includes support for `name_filter` and `name_sync`, but these methods weren't actually used for anything and aren't even included in current Namecoin Core releases, so I didn't bother implementing them.)  Happily, issues (1) and (2) are no longer relevant, because ancient versions of Namecoin Core have long ago been phased out, and upstream btcd now supports JSON-RPC 2.0 without erroring.  Conveniently, the new API looks very similar to a custom high-level API that ncdns had implemented itself, so I was able to kill off quite a lot of glue code in ncdns as well.

Finally, I ported Hugo's cookie authentication code to btcd.  This wasn't particularly difficult, since most of the relevant code could be copied from ncdns into btcd without major changes.  (ncdns is GPLv3+-licensed, while btcd is ISC-licensed, but Hugo is the only developer who's touched the relevant code, and he's authorized re-licensing that code to both MIT and ISC licenses, so licensing concerns aren't an issue.)

Killing off the legacy Namecoin fork of btcd will be an important step toward making Namecoin more secure, since unmaintained code is a potential source of bugs and vulnerabilities.  It also means we'll benefit from whatever features Conformal has added since 2015, and whatever features they add in the future.  Now we just wait for Conformal to review the patches.

This work was funded by NLnet Foundation's Internet Hardening Fund.

[1] Of course, nothing is really secret in the ncdns codebase, since it's free software.  That said, it's rare for people to actually thoroughly check the dependency tree of free software they work with, which makes it a bit of a de facto secret.
