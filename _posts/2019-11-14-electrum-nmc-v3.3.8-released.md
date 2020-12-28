---
layout: post
title: "Electrum-NMC v3.3.8 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.8.  This release includes a large number of improvements, mostly focused on performance (both initial syncup speed and name lookup latency) and anonymity (in particular support for Tor stream isolation).  Here's what's new since v3.3.7:

* From upstream Electrum:
    * fix some bugs with recent bump fee (RBF) improvements (#5483, #5502)
    * fix #5491: watch-only wallets could not bump fee in some cases
    * appimage: URLs could not be opened on some desktop environments (#5425)
    * faster tx signing for segwit inputs for really large txns (#5494)
    * A few other minor bugfixes and usability improvements.
* Namecoin-specific:
    * Fix signature creation for P2SH and SegWit names (Namecoin mainnet now supports P2SH and SegWit; these features should now work in Electrum-NMC, including in name transactions).  (Patch by Daniel Kraft.)
    * Fix an error that occurred when displaying the Manage Names tab if the blockchain is empty but the wallet is not.  (Patch by Jeremy Rand.)
    * [Merkle checkpoints]({{site.baseurl}}2019/04/08/electrum-merkle-checkpoints.html) (improves initial syncup speed).  (Patch by Jeremy Rand; based on a patch by Roger Taylor.)
    * Create a `.tar.xz` archive (improves binary download size).  (Patch by Jeremy Rand.)
    * Use random SOCKS authentication for stream isolation of connections to servers (improves performance and anonymity).  (Patch by Jeremy Rand.)
    * Add `stream_id` argument to network RPC methods for stream isolation (improves performance and anonymity).  (Patch by Jeremy Rand.)
    * Building Electrum-NMC without wallet functionality, GUI functionality, and BIP70 functionality is now supported (improves binary download size).  (Patch by Jeremy Rand.)
    * Support a Namecoin-Core-style `options` argument in `name_show` RPC method (fixes compatibility with latest ncdns).  (Patch by Jeremy Rand.)
    * Retry name lookups with different server if NXDOMAIN returned (improves censorship resistance).  (Patch by Jeremy Rand.)
    * Download blockchain from different servers in parallel (improves initial syncup speed).  (Patch by Jeremy Rand.)
    * Add `from_coins` argument to wallet RPC methods (improves anonymity).  (Patch by Jeremy Rand.)
    * Avoid returning outdated `name_show` results while the blockchain is still syncing (improves security of key revocations).  (Patch by Jeremy Rand.)
    * Avoid broadcasting `name_new` if `name_firstupdate` failed (improves reliability of name registration).  (Bug reported by DogHunter; patch by Jeremy Rand.)
    * Avoid `NotEnoughFunds` error in CoinChooser if zero buckets are sufficient (fixes a spurious error during name registration).  (Bug reported by DogHunter; patch by Jeremy Rand.)
    * Code quality improvements.  (Patches by Daniel Kraft and Jeremy Rand.)

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.
