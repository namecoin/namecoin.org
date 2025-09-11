---
layout: post
title: "Hashed TLSA Records in Encaya"
author: Jeremy Rand
tags: [News]
---

As long-time readers will be aware, probably the biggest innovation of Namecoin's TLS functionality is that it uses a special form of TLS certificates that happens to work well in mainstream web browsers, via the interoperability magic of AIA and PKCS#11. This avoids having to patch web browsers or intercept TLS connections (either of which would introduce nontrivial security liabilities).

One of the consequences of this benefit has been that Namecoin domains must embed an ECDSA public key on-chain. ECDSA public keys, alas, are somewhat big. We worked around this, sort of, by using compressed public keys on-chain, and decompressing them on-the-fly before passing them to web browsers via AIA. This was still suboptimal for a few reasons:

1. Compressed ECDSA public keys are still kind of big. Much bigger than a SHA-256 hash.
2. Compressed ECDSA public keys aren't supported by the Go standard library, so we had to maintain a fork of the standard library.
3. Whatever escape hatch we get from using compressed ECDSA public keys won't help us when TLS eventually moves to PQ signatures. (More on this in a future post.)

So, why did we need full public keys in the blockchain (as opposed to a public key hash) anyway? The constraints are as follows:

1. Encaya needs to synthesize a CA certificate when the browser asks for it.
2. This synthesized CA certificate needs to contain the public key that the domain owner picked.
3. The browser will *not* provide any public keys that the TLS server presented in the certificate chain.
4. THEREFORE, Encaya needs to get the public key from the blockchain, since there's no other way to get it given the API constraints. QED. Right...?

Um, about that last assumption. Is there really no other way to get the public key given the API constraints?

Moreover, how does Encaya even know what domain name to look up in the blockchain? Could we get the public key that way?

Hmm...

Encaya gets the domain name from an AIA request (for Chromium-like browsers) or from a PKCS#11 request (for Firefox-like browsers). Why do these requests contain the domain name? Uh. Because we put the domain name there?

The AIA request contains whatever data is in the AIA Issuer URL field of a certificate sent by the TLS server. The PKCS#11 request contains whatever data is in the Issuer Distinguished Name (DN) field of that certificate. There's no requirement that either of those fields contain the domain name. The DN does *sometimes* contain a domain name in the Common Name field, but that's normally only a thing for end-entity certificates, not CA certificates. The AIA Issuer URL field definitely doesn't normally have anything like that under any circumstances. In both fields, we *deliberately* put the domain name there so that Encaya would see it.

You probably see where this is going. Could we stuff a public key into the AIA Issuer URL and the Subject DN? It'd look pretty weird, but if you're averse to looking weird, you're probably not a hacker.

So here's the new workflow:

1. The AIA Issuer URL field of the CA certificate sent by the TLS server adds a new GET query parameter, containing a base64-encoded public key.
2. The Subject DN field of that CA certificate's parent CA adds a base64-encoded public key in the Subject Serial Number subfield.
3. The Issuer DN field of the CA certificate matches the Subject DN of its parent, thus also including an Issuer Serial Number with a base64-encoded public  key in it.
4. When Chromium sees this certificate chain, it sends an AIA request to Encaya that includes the public key as part of the AIA Issuer URL.
5. When Firefox sees this certificate chain, it sends a PKCS#11 request to ncp11 that includes the public key as part of the Subject DN or Issuer DN.
6. Encaya can then compare this public key to the hashed TLSA record in the blockchain. It if matches, Encaya uses the public key in its synthesized CA.
7. Chromium and Firefox don't know that anything funky has happened. Sure, there's an intermediate CA with a really long AIA Issuer URL and Issuer Serial Number. But Chromium and Firefox don't care about that.
8. On-chain savings achieved. We win!

I've implemented the above in Encaya, ncp11, and generate_nmc_cert. What do the savings look like?

* Before: 90 bytes of JSON per TLSA record
* After: 54 bytes of JSON per TLSA record

The TLS handshake, of course, contains a bit more data, but TLS handshake bytes are cheap compared to on-chain bytes.

Once this feature gets into a release, we will contact Namecoin HTTPS website operators in the wild (where feasible) to nudge them to upgrade their setup. Support for the previous certificate format will probably be dropped soon, because the maintenance burden of a standard Go crypto library fork is not a good use of my time.

This work was funded by Power Up Privacy.
