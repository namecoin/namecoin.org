---
layout: post
title: "Is Post-Quantum Namecoin TLS Feasible?"
author: Jeremy Rand
tags: [News]
---

As the shelf life of most public-key cryptography nears its quantum-induced termination, many protocols are moving toward post-quantum (PQ) cryptography. PQ crypto, defined as cryptosystems that are believed to be secure against both classical and quantum cryptanalysis, is an active research area, with rapid advances happening in both the cryptosystems and the attacks. It would be nice if we had more time to research secure PQ cryptosystems, but alas we do not have that luxury. TLS is thus beginning to deploy PQ crypto. Which begs the question: how is Namecoin affected by PQ crypto adoption in TLS?

There are actually three different cryptosystems in Namecoin TLS that need a PQ replacement:

1. Replacing ECDHE for the TLS handshake.
2. Replacing ECDSA for the X.509 certificates.
3. Replacing Schnorr for the on-chain transactions.

What would they be replaced with?

1. ECDHE would be replaced with something like CRYSTALS-Kyber (standardized by NIST as ML-KEM).
2. ECDSA would be replaced with something like CRYSTALS-Dilithium (standardized by NIST as ML-DSA).
3. Schnorr would be replaced with CRYSTALS-Dilithium, or perhaps something like Falcon or Lamport signatures.

(Yes, cryptographers like sci-fi jokes when naming things.)

And who has to do the work to replace them?

1. ECDHE is handled by web browsers. Encaya doesn't touch this. Web browsers are already starting to deploy CRYSTALS-Kyber; no action is needed on Namecoin's end.
2. ECDSA in X.509 is handled specially by Encaya. It's our job to make sure this doesn't break when users try to use CRYSTALS-Dilithium!
3. Schnorr on-chain is handled by Bitcoin. As the Bitcoin community moves toward PQ crypto adoption, Namecoin will have to follow Bitcoin on a softfork, but no additional action is needed on Namecoin's end.

Yeah, uh, about number 2. What's the challenge with CRYSTALS-Dilithium? The big problem is that Dilithium involves really really big public keys and really really big signatures (at least compared to ECDSA). Specifically, Dilithium5 public keys are 2592 bytes, with signatures of 4595 bytes. Dilithium is probably not catastrophic for TLS in general, but recall that Encaya needs to staple a public key (and maybe a signature too) into the AIA Issuer URL as well as the Issuer/Subject Serial Number. Mainstream TLS clients generally have no reason to expect massive amounts of data in these fields.

I already looked into the [length limit of the AIA Issuer URL]({{ "/2025/09/07/whats-maximum-length-aia-issuer-url-windows-11-cryptoapi.html" | relative_url }}). The gist is that it'll give a bit over 65 KB of data. That's totally fine for Dilithium. However, other limits come into play. [OpenSSL imposes a length limit](https://docs.openssl.org/3.2/man3/SSL_CTX_set_max_cert_list/) of 100 KiB on the entire cert chain (the manual says 100 kB, but it's wrong; the OpenSSL devs apparently are illiterate about the metric system). Given that the stapled data shows up 3 times in the TLS cert chain (AIA Issuer URL, Issuer Serial Number, and Subject Serial Number), that means we have a maximum of ~33.3 KiB to work with. (We have to fit the rest of the cert chain in too!) I couldn't find any official documentation on the limits in Firefox ([this article by Tomás Gutiérrez](https://0x00.cl/blog/2024/exploring-tls-certs/) suggests Firefox is less tolerant than OpenSSL), but by manual testing, I found that stapled data of 32 KB worked OK, while 34 KB made Firefox so unhappy that it managed to show a TLS error with an *empty* error code (wat). So for practical purposes, our limits for Firefox look very close to those of OpenSSL. Microsoft Edge seems mildly more tolerant than Firefox, but I didn't try to nail down how much more tolerant.

As far as I can tell, 32 KB of stapled data will easily meet our needs. It's considerably larger than what we'd need for a Dilithium5 public key and a Dilithium5 signature, even if they were hex-encoded. In practice, we would probably use base64 encoding (more compact). TLS would probably use Dilithium2 or Dilithium3 (which yields smaller public keys), and Bitcoin might wind up using Falcon, which has even smaller signatures than Dilithium2.

It's not clear to me whether 32 KB of stapled data would be able to handle SPV proofs ([as Handshake is doing](https://github.com/handshake-org/HIPs/blob/master/HIP-0017.md)), but on the other hand I am not convinced that stapling SPV proofs into a TLS handshake is something that Namecoin needs.

![~32 kB of stapled data in the Subject Serial Number ought to be enough for anyone?]({{ "/images/memes/ought-to-be-enough.jpg" | relative_url }})

So, Namecoin's Encaya certificate format is reasonably well prepared for a PQ transition. There will probably be plentiful drama elsewhere though. No ETA, as far as I'm aware, of when mainstream browsers will support Dilithium certificates.

This work was funded by Power Up Privacy.
