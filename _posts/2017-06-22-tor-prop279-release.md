---
layout: post
title: Namecoin Resolution for Tor Released
author: Jeremy Rand
tags: [Releases, Prop279 Releases]
---

The [aforementioned licensing issues with TorNS]({{site.baseurl}}2017/06/21/tor-prop279.html) have been dealt with, and I've released the DNS provider for Tor's Prop279 Pluggable Naming API.  This allows Namecoin resolution in Tor.

One issue I encountered is that TorNS currently implements a rather unfortunate restriction that input and output domain names must be in the `.onion` TLD.  I've created a fork of TorNS (which I call [LibreTorNS](https://github.com/namecoin/LibreTorNS)) which removes this restriction.  LibreTorNS is currently required for Namecoin usage.

The code is available from the [Beta Downloads page]({{site.baseurl}}download/betas/#dns-prop279).  Please let me know what works and what doesn't.  And remember, using Namecoin naming with Tor will make you heavily stand out, so don't use this in any scenario where you need anonymity.  (Also please refer to the extensive additional scary warnings in the readme if you're under the mistaken impression that using this in production is a good idea.)

This development was funded by NLnet.
