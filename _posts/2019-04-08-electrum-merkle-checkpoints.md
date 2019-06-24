---
layout: post
title: "Electrum: Merkle Checkpoints"
author: Jeremy Rand
tags: [News]
---

*This post is an explanation of work originally done by Neil Booth and Roger Taylor (for ElectrumX and Electron-Cash), which Namecoin is adapting for use in Electrum and Electrum-NMC.*

When I [last posted about auditing Electrum-NMC's bandwidth usage]({{site.baseurl}}2019/02/02/electrum-nmc-checkpointed-auxpow-truncation.html), I had managed to reduce the data transfer of the portion of the blockchain covered by a checkpoint from 3.2 MB per chunk down to 323 KB per chunk.  I hinted then that there was most likely some further optimization that could be done.  Today I'll briefly describe one of them: Merkle checkpoints.

A blockchain, by its nature, is a sequence of blocks where the block at height *N* commits to the block at height *N-1*.  From this fact, it follows that if you know the most recent block, you can verify the authenticity of any earlier block by recursively following those commitments until you arrive at the block you want to verify.  Cryptographically knowledgeable readers will recognize this as a particularly inefficient form of a Merkle tree.  For readers who aren't familiar with Merkle trees, they're a cryptographic construction by which a single hash can commit to a large number of hashes, via recursive commitments.  Merkle trees come in a wide variety of constructions, but the most common form of a Merkle tree is a balanced binary Merkle tree.  In such a tree, the proof size to connect a given hash to the root hash is logarithmic in terms of the total number of hashes committed to.  Balanced binary Merkle trees are used, for example, to allow a block header to commit to the transactions in a block.  A blockchain is an optimally unbalanced Merkle tree, in which the proof size is linear rather than logarithmic.

Linear proof size means that, in Electrum today, if I want to prove that header 2016 is committed to by a checkpoint on header 4031, I need to download 2016 headers, which is an unpleasantly large download of `(4031 - 2016 + 1) * 80 = 161280` bytes [1].  Logarithmic proof sizes given by a balanced binary Merkle tree, by contrast, would mean downloading `ceil(log2(4031)) * 32 + 80 = 464` bytes.  What if the checkpoint is for height 1,000,000?  In that case, it ends up as `ceil(log2(1000000)) * 32 + 80 = 720` bytes.  Naturally, we'd like logarithmic proof sizes rather than linear proof sizes.  Using block headers themselves as Merkle roots can't achieve this, but there's nothing whatsoever that prevents us from taking all the historical block headers, and arranging them into a balanced binary Merkle tree.  We could then use the Merkle root as a checkpoint, and thereby gain extremely small proofs that a given header is committed to by a checkpoint.

This is exactly what Neil Booth implemented in ElectrumX, as the `cp_height` checkpoint system, and which Roger Taylor subsequently implemented in Electron-Cash.  Since Electrum-NMC's upstream implementation is Electrum, I've been working on porting Roger's Electron-Cash support for Merkle checkpoints to Electrum.  At the moment, I have a pull request undergoing review for upstream Electrum.  I'm hopeful that it will pass peer review soon, at which point I'll work on merging it to Electrum-NMC.

Once Merkle checkpoints are merged to Electrum-NMC, we'll be able to set a checkpoint on a recent height (rather than the 36-kiloblock-ago height that we currently set), without causing a severe delay on name lookups.  This will be a substantial improvement to Electrum-NMC's performance.

(However, there are additional optimizations that can be made.  More on those in a future post.)

This work was funded by Cyphrs.

[1] These figures assume binary encoding, but Electrum's protocol uses hex encoding, which effectively doubles the byte count of all of these figures.
