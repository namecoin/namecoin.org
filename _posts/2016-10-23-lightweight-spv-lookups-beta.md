---
layout: post
title: "Lightweight SPV Lookups: Initial Beta"
author: Jeremy Rand
tags: [Releases, libdohj Releases]
---

If you watched [my lightning talk at Decentralized Web Summit 2016](https://archive.org/details/DecentralizedWeb20160609pt1?start=21490) (and if you didn't, shame on you -- go watch it right now along with [the other talks](https://archive.org/details/decentralizedwebsummit2016?&sort=publicdate)!), you'll remember that I announced SPV name lookups were working.  I'm happy to announce that that code is now published *in preliminary form* on GitHub, and binaries are available for testing.

You can download it at the [Beta Downloads]({{site.baseurl}}download/betas/#consensusj-namecoin) page.  Once installed, it's basically a drop-in replacement for Namecoin Core for any application that does name lookups (such as ncdns).  Test reports are greatly appreciated so that we can do a proper release sooner.

Initial syncup using a residential clearnet cable modem connection takes between 5 minutes and 10 minutes, depending on the settings.  (It is probably feasible to improve this.)  Lookup latency for `name_show` varies from 2 seconds to 4 milliseconds, depending on the settings.  (It is also probably feasible to improve this.)

This work wouldn't have been possible without the work of some very awesome people whom I need to thank.

First, I need to thank Ross Nicoll from [Dogecoin (warning: non-TLS link)](http://dogecoin.com/) for creating [libdohj](https://github.com/dogecoin/libdohj), an altcoin abstraction library that has prevented Namecoin from needing to maintain a fork of [BitcoinJ](https://bitcoinj.github.io/).  We're using the same AuxPoW implementation from libdohj that Dogecoin is using -- a fitting repayment, since Dogecoin Core uses the same AuxPoW implementation that Daniel Kraft wrote for Namecoin Core.  We look forward to continuing to work with Ross and the other excellent people at Dogecoin on areas of shared interest.

Second, I need to thank Sean Gilligan for his work on [bitcoinj-addons](https://github.com/msgilligan/bitcoinj-addons), a collection of tools that includes a JSON-RPC server implemented using BitcoinJ, which can substitute for Bitcoin Core.  Sean is also a big Namecoin enthusiast.  (I also finally got to meet Sean in person at DWS.)

Last but not least, I need to thank Marius Hanne, operator of the [webbtc.com block explorer](https://www.webbtc.com/).  The SPV lookup client currently is capable of using webbtc.com for extra efficiency (either for checking the height of blocks to download over P2P, or for downloading merkle proofs).  Marius has been incredibly helpful at customizing the webbtc.com API for this purpose.  [webbtc.com is under a free software license (AGPLv3)](https://github.com/mhanne/block_browser), so you can run your own instance if you like.

Remember: this is a beta, *for testing purposes only*.  Don't use this for situations where incorrect name responses could lead to results that you aren't willing to accept.

In addition, some notes about security.  SPV protects you from being served expired name data, and protects you from being served unexpired name data that isn't part of the longest chain.  However, the SPV modes other than `leveldbtxcache` (see the documentation) don't protect you from being served outdated name data that hasn't yet expired, nor does it protect you from being served false nonexistence responses, nor does it protect you from someone logging which names you look up.  We made an intentional design decision to trust webbtc.com here, rather than the Namecoin P2P network, because the P2P network is unauthenticated, trivially easy to wiretap, and trivially easy to Sybil.  `leveldbtxcache` mode avoids these isues, although it takes about twice as long to synchronize.  We have plans to add further improvements in these areas as well.  SPV also doesn't protect you from attackers with a large amount of hashpower.  As with Bitcoin, a major reason that miners can't easily attack end users is because there are enough full nodes on the network to keep the miners honest.  If you have the ability to run Namecoin Core (syncup time of a few hours, and a few GB of storage), you should do so -- you'll have better security for yourself, and you'll be improving the security of other users who can't run a full node.

Have fun testing!
