---
layout: post
title: "Deterministic Salts"
author: Jeremy Rand
tags: [News]
---

When Namecoin was first being designed, an attack had to be dealt with: the *frontrunning attack*.  The attack works like this:

* Julian broadcasts a transaction, indicating that he wants to buy `wikileaks.bit`.
* Keith sees Julian's transaction as soon as it gets broadcasted.
* Keith infers that Julian places a significant value on `wikileaks.bit`.
* Keith broadcasts his own transaction, trying to buy `wikileaks.bit`.
* Keith bribes a miner to mine his transaction rather than Julian's.  (This could be done by using a much higher transaction fee than Julian's transaction, or it could be done via out-of-band channels, perhaps a court order.)
* Keith now owns `wikileaks.bit`, not Julian, even though Julian was the first person to try to buy it.

Astute readers will note that the fundamental problem here is that DNS-like systems are supposed to be "first-come-first-served", but a blockchain isn't able to meaningfully determine which transaction came first if they were both broadcasted before either was mined.  Similar problems happen in Bitcoin when an attacker tries to spend the same coins to two different destination addresses at the same block height: there's no reliable way to determine which spend came first, so it's up to the miners to decide.

So, how was this fixed?  Via *commitments*.  When Julian wants to buy `wikileaks.bit`, he first broadcasts a *commitment* transaction.  The transaction doesn't reveal the name he wants to buy; it instead consists of a hash of two things: the name he wants to buy, and a secret randomly generated string (called a *salt*).  Without knowing the salt and the name already, Keith can't determine what name Julian is buying.  And since the salt is randomly generated and is high in entropy, Keith can't even mount a dictionary attack on the hash; even if Keith suspects that Julian is buying `wikileaks.bit`, Keith can't verify this without knowing the salt.

After the commitment transaction has received 12 confirmations, Julian broadcasts a 2nd transaction that reveals the name and the salt.  Once this 2nd transaction is mined, Julian officially owns `wikileaks.bit`.  The key point here is that once the 2nd transaction is broadcasted, Julian only needs 1 block to be mined in order to obtain the name -- but if Keith tries to register it, he'll need to broadcast his own commitment (now that he knows the name) and wait for 12 blocks before he can register the name.  In other words, the existence of the commitment gives Julian a 12-block head start against Keith, which should ensure that Julian gets the name (unless Keith has successfully bribed the miners of 12 blocks in a row, which seems unlikely).

This scheme brings important security, but it also poses a problem.  Imagine the following:

* Matthew broadcasts a commitment transaction for `theintercept.bit`.
* Sometime in the next 12 blocks, Matthew's hard drive dies.
* Matthew restores his wallet from his seed phrase on another machine.
* Matthew tries to register `theintercept.bit` by spending the commitment transaction in his wallet.
* Uh oh.  Matthew's wallet doesn't know what the salt is!  It was only on the hard drive that died.  Matthew forfeits the name registration fee, and has to start over.

Can we improve this situation?  Yes!  The answer is *deterministic salts*.

On a high level, we want the wallet application to pick a salt that is reliably predictable to the wallet owner, but still unpredictable to anyone else.  We homed in on the following secret knowledge:

* The private key of the address that owns the commitment transaction.
* The name being registered.

We don't want the name to be the only input to the salt, since at that point the salt is pretty much ineffectual: remember that the purpose of the salt is to stop people who can guess the name from figuring out whether their guess is accurate!  We also don't want the private key to be the only input, because this would imply predictable salt reuse if address reuse occurs.  (Yes, I know, address reuse is bad.  But address reuse is typically only a privacy harm; there's no reason to unnecessarily exacerbate the impact of address reuse by turning it into a name theft harm too.)

So, how do we combine the private key and the name to get a salt?  It turns out that there's a standard cryptographic function for this: [HKDF (RFC 5869)](https://tools.ietf.org/html/rfc5869).  Conveniently, HKDF is already present in both Bitcoin Core and Electrum, so no additional libraries need to be imported.  Specifically, we can use the following HKDF parameters:

* Initial key material: private key
* Salt: name identifier
* Info: "Namecoin Registration Salt"

The "Info" parameter is designed to prevent cross-protocol attacks, where someone uses the same construction for two completely different purposes in order to induce a user of one protocol to compromise themselves in the other protocol.

I've now implemented HKDF-based deterministic salts in Electrum-NMC.  For example, you can now do the following command as before:

~~~
name_new("d/example")
~~~

And you'll get back a transaction and a salt, like before.  But, you're now free to ignore this salt, because you don't need it anymore!  You can complete the registration 12 blocks later like this:

~~~
name_firstupdate("d/example")
~~~

Note that you don't need to enter a salt or a TXID anymore!  Electrum-NMC checks each `name_new` UTXO in its wallet to see if the output of HKDF yields the commitment in the `name_new`, and if it does, Electrum-NMC uses that TXID and salt automatically.  This works even if you're running `name_firstupdate` after restoring the wallet from a seed on a different machine than the one that produced the `name_new` transaction.

Pretty cool, huh?

*Thanks to s7r for the idea of deterministic salts; thanks to Ryan Castellucci for cryptographic advice; and thanks to Daniel Kraft for discussions about Namecoin Core integration.*
