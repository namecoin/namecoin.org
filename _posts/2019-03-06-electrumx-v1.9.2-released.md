---
layout: post
title: "ElectrumX v1.9.2 Released by Upstream, Includes Checkpointed AuxPoW Truncation"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

[Upstream ElectrumX](https://github.com/kyuupichan/electrumx) has released v1.9.2, which includes several Namecoin-related changes (all of which were submitted by me and merged by Neil).  Here's what's new for Namecoin:

* Add 2 new servers.
* Use the correct default Namecoin Core RPC port; this means ElectrumX server operators won't need to manually set the RPC port via an environment variable anymore.
* [Checkpointed AuxPoW truncation]({{site.baseurl}}2019/02/02/electrum-nmc-checkpointed-auxpow-truncation.html).
* Use a correct `MAX_SEND` by default for AuxPoW chains.  The previous default of 1 MB doesn't work with AuxPoW chains because AuxPoW headers are substantially larger than Bitcoin headers; the new default of 10 MB for AuxPoW chains allows Namecoin to sync properly.  This means ElectrumX server operators won't need to manually set the `MAX_SEND` via an environment variable anymore.

ElectrumX then subsequently released some other revisions, none of which are specific to Namecoin; the latest release is currently v1.9.5.  At least 2 of the 3 public Namecoin ElectrumX servers have already upgraded; as a result, I've merged checkpointed AuxPoW truncation into Electrum-NMC's master branch.  If you run a Namecoin ElectrumX server and haven't yet upgraded, please consider upgrading to the latest ElectrumX release so that your users will be able to use future releases of Electrum-NMC (which will require checkpointed AuxPoW truncation) without any trouble.

(And a reminder that we need more ElectrumX instances... please consider running one if you have a server with spare resources!)

This work was funded by Cyphrs.
