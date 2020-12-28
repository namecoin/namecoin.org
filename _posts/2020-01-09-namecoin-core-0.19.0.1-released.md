---
layout: post
title: "Namecoin Core 0.19.0.1 Released"
author: Jeremy Rand
tags: [Releases, Namecoin Core Releases]
---

Namecoin Core 0.19.0.1 has been released on the [Downloads page]({{site.baseurl}}download/#namecoin-core-client-stable-release).

Here's what's new since 0.18.0:

* The mempool now allows multiple updates of a single name (in a chain of transactions). This is something that is allowed in blocks already, i.e. it is just a policy change. The `name_update` RPC command still prevents such transactions from being created for now, until miners and relaying nodes have updated sufficiently. More details can be found in [#322](https://github.com/namecoin/namecoin-core/pull/322).
* Numerous improvements from upstream Bitcoin Core.
