---
layout: post
title: "Electrum-NMC: Checkpointed AuxPoW Truncation"
author: Jeremy Rand
tags: [News]
---

I posted previously about [auditing Electrum-NMC's bandwidth usage]({{site.baseurl}}2018/11/28/electrum-nmc-checkpoints.html).  In that post, I mentioned that there were probably optimizations that could be done to reduce the 3.2 MB per 2016 block headers that get downloaded when looking up a name that's covered by a checkpoint.  I've now implemented one of them: AuxPoW truncation.

Some background: AuxPoW (auxilliary proof of work) is the portion of Namecoin block headers that allows clients to verify that the PoW expended by miners on the parent chain (usually Bitcoin) applies to Namecoin as well.  As a result, SPV clients such as Electrum-NMC (which verify PoW) need to download the AuxPoW data.  However, the AuxPoW data in a Namecoin block header *does not contribute to the block hash*.  As a result, the commitment in a Namecoin block header to the previous block header can be verified without having access to any AuxPoW data.

Why does this matter?  AuxPoW is by far the largest part of a Namecoin block header, because it contains a coinbase transaction from the parent chain.  Coinbase transactions can frequently be quite large, especially if the parent block is mined by a mining pool that's paying a large number of miners via the coinbase transaction.  If we can omit the AuxPoW data from Namecoin block headers, then that saves a lot of bytes.

Obviously, we can't get rid of the AuxPoW data completely, since SPV validation requires PoW verification.  But not all blocks are verified via SPV -- blocks that are covered by a checkpoint don't need to have their PoW checked, since the checkpoint implies validity.  So, we can simply not check the AuxPoW for any blocks that are committed to by a checkpoint.  And if we don't need to check the AuxPoW for such blocks, we don't need to download it either.

Conveniently, the Electrum protocol includes a feature that allows the client to tell the server what height its checkpoint is set to.  This feature isn't actually used yet in the Electrum client, but we can use that feature to have Electrum-NMC tell ElectrumX what height its checkpoint is set to, such that ElectrumX will then truncate AuxPoW data from the block headers it responds with.  I've submitted a PR for ElectrumX that does exactly that: with this PR, ElectrumX truncates AuxPoW data from block headers when the client supplies a checkpoint height that is higher than the height of the block header.  Neil from ElectrumX has already merged my PR; once it's in a tagged release, I'll push the relevant changes to Electrum-NMC as well.

What does the data transfer look like now?

* Before: 3.2 MB per 2016 headers
* After: 323 KB per 2016 headers

So that's roughly a 90% reduction.  Not bad.  There are probably some additional optimizations that can still be done, but those will have to wait for another day.

This work was funded by Cyphrs.
