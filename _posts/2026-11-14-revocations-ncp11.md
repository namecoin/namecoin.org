---
layout: post
title: "Revocations in ncp11"
author: Jeremy Rand
tags: [News]
---

Currently, if a TLS private key on a Namecoin domain gets compromised, you need to delete the TLSA record and recreate all certificates. This is an operational nightmare. Can it be made better?

Most TLS libraries allow specific certificates to be blacklisted. The exact mechanism varies by TLS library. Windows CryptoAPI uses the `Disallowed` logical store for this. NSS uses the `p` ("prohibited") trust bit in `certutil`. And, most relevant for us, PKCS#11 allows the trust level to be set to `CKT_NSS_NOT_TRUSTED`.

A problem I expected to run into was that PKCS#11 trust objects are tied to a fingerprint of the certificate, and we can't know the fingerprint in advance. However, I turned up an unexpected lead: some old Netscape (!) documentation states that a fingerprint is only needed on a trust object if it's marking the certificate as trusted. If it's marking the certificate as prohibited, the fingerprint is optional. In the decades since Netscape was a thing, that note got removed from the NSS documentation. But I gave it a try anyway, and... it worked exactly as the Netscape docs said it did.

From there, I set up an Encaya endpoint that returns `true` if a given certificate is revoked, and `false` otherwise. PKCS#11 passes two attributes to our module when doing this lookup: the issuer name, and the serial number. Since stuffing a full issuer name and serial number into the blockchain would be rather wasteful, I set it up so that you can revoke certificates by putting on-chain a *prefix* of the SHA256 hash of the issuer common name, and a prefix of the serial number. In most cases, you'll only have a few certificates, so this allows a very compact on-chain revocation list.

Can we move the revocation list completely off-chain, like we've done for TLS and SSH certificates? Unfortunately not. Revocation lists require a guarantee of freshness, which we can only get by committing to the list on-chain. We can't assume that the attacker trying to MITM us will be kind enough to supply us with a fresh revocation list!

Revocation checks use the ncdns PKI cache (see my previous post), so they're latency-efficient and have good anonymity. Having revocation working solves a long-standing security complaint about Namecoin that browser vendors frequently cited.

And here, have a screenshot of Firefox with ncp11, loading a web page with a revoked TLS certificate:

![What makes the site look dangerous? Firefox is warning you about this site because the certificate provided for encaya.bit was issued for a certificate authority that isn't trusted anymore.]({{ "/images/screenshots/tls/tls-revoked-firefox-linux-2026-11-14.png" | relative_url }})

This work was funded by NLnet Foundation's NGI0 Core Fund.
