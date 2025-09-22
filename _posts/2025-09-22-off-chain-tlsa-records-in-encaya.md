---
layout: post
title: "Off-Chain TLSA Records in Encaya"
author: Jeremy Rand
tags: [News]
---

Now that [hashed TLSA records]({{ "/2025/09/11/hashed-tlsa-records-in-encaya.html" | relative_url }}) are a thing, it's time to ask our inner mad scientist: can we do any better than that?

What would be better for scalability than only putting a hash on the blockchain? What about... not putting *any* TLS things on the blockchain? Sounds impossible, right?

Let's frame this question a different way: why are we putting a TLSA record on the blockchain? Or perhaps we can ask an even more radical question: why do we put *anything* on the blockchain?

There are three main reasons we might put something on the blockchain:

1. *Authenticity*: the data is signed by the rightful owner.
2. *Exclusivity*: the data hasn't been double-spent.
3. *Freshness*: the data isn't outdated.

Exclusivity isn't really relevant for TLSA records; there's not really any incentive for a domain owner to double-spend their own TLSA record.

What about authenticity? The signature is what's important, but the signature doesn't *have* to be the transaction signature. It's straightforward to sign a message with a Bitcoin private key, and verify it against the corresponding Bitcoin address. This concept is frequently used in Bitcoinland for proof of reserves. And conveniently, in Namecoin, it's very easy to check which Namecoin address owns a name.

So how would this look? We're already stapling a public key into the Subject Serial Number, Issuer Serial Number, and AIA Issuer URL. We could also staple a signature, signed by the Namecoin address that owns the name. Encaya can then call out to Namecoin Core or Electrum-NMC to verify the signature.

Does this break freshness? Not really: the signature becomes stale whenever the name is transferred to a new Namecoin address. This means that if you *don't* want to revoke your TLSA records that are stapled in this way, you must keep your name at the same address.

Address reuse is often frowned upon in Bitcoinland due to privacy concerns, but the privacy leakage that results from address reuse is *already* public knowledge in Namecoin: of course those two transactions were made by the same person, they're for the same domain name and they point to the same IP address. Address reuse is also sometimes cited as an issue for quantum safety. That is technically true, but if a quantum computer starts attacking Bitcoin, you probably want better security than unique addresses will give you. Transitioning Bitcoin and Namecoin to post-quantum signatures is likely to be a better approach.

There is, of course, a practical issue with this scheme. Bitcoin Core doesn't yet support message signatures with non-P2PKH addresses. Electrum does support P2WPKH addresses. Neither supports multisig addresses (or any other kind of smart contracts). So for now, this approach will only work if you're using legacy (non-SegWit) single-key addresses; in terms of transaction weight, the witness discount will typically outweigh the benefit from moving TLSA records off-chain. Hopefully Bitcoin Core will fix this soon upstream.

The above has now been implemented into Encaya and ncgencert, and works fine with both AIA and PKCS#11. No changes were needed to ncp11. The ncdns Windows installer will need some small tweaks to relax Encaya's sandbox so that it can talk to Namecoin Core.

This work was funded by NLnet Foundation's NGI0 Core Fund.
