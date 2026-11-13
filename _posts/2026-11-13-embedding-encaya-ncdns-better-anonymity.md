---
layout: post
title: "Embedding Encaya in ncdns for Better Anonymity"
author: Jeremy Rand
tags: [News]
---

Anonymity-focused web browsers (e.g. Tor Browser) rely on *first-party isolation (FPI)* to prevent third-party ads from tracking you across websites. FPI partitions observable state based on the first-party domain (i.e. the domain in the URL bar of your web browser). Unfortunately, neither PKCS#11 nor AIA have any mechanism to convey the first-party origin to ncp11 or Encaya. This poses a problem, because ncp11 and Encaya can induce network traffic in the form of requests to an ElectrumX server. We wouldn't want TLS to be a deanonymization vector. What to do?

An obvious approach would be to update the APIs to support conveying first-party origin information. Unfortunately, this is a very niche request, and we don't expect that the browser vendors would be cooperative. So this idea was discarded.

Another approach would be to pick a completely random origin, and cycle it every time ncp11 or Encaya gets a request. While this *does* ensure FPI, it has two highly problematic side effects:

1. A single web page load can produce a quite large number of PKCS#11 queries, and making each of those induce its own ElectrumX round-trip would yield a major latency cost.
2. This would *also* allow malicious websites to induce unbounded Tor circuit creation. Tor Project recently updated its threat model documentation to advise against allowing this, because unbounded circuit creation can be used for traffic analysis attacks.

Is there another way? Consider the following:

1. PKCS#11 and AIA queries only happen while a TLS handshake is underway.
2. TLS handshakes for `.bit` domains only happen right after a query to ncdns about that `.bit` domain.
3. When ncdns retrieves the information needed to resolve the `.bit` domain to an IP address or onion service, it *also* obtains the information necessary to validate TLS certificates for that `.bit` domain.

So, Robert and I have implemented the following:

1. Encaya is refactored to be a library that ncdns can embed.
2. When ncdns resolves a `.bit` domain, it adds the relevant `TLSA` records to a local "PKI cache".
3. When Encaya receives an AIA query, it doesn't generate any network traffic. It instead only queries the local PKI cache.

While the PKI cache does constitute some state, this state doesn't need to be partitioned by first-party origin, because websites can't observe this state, except in the form of a boolean "does this website's TLS cert load correctly?", and this boolean observation will always only be dependent on the contents of the blockchain. Anything else would be a certificate validation bug!

A nice side benefit of embedding Encaya into ncdns is that it decreases the total binary size. ncdns with embedded Encaya is only around 200 kB larger than ncdns prior to this change -- much smaller than ncdns plus Encaya as two separate executables. This makes it much easier to bundle Encaya with Tor Browser, which has heavy binary size constraints.

Sometimes you don't need to deal with tradeoffs between latency and anonymity: in this case, a win for one is a win for the other.

This work was funded by NLnet Foundation's NGI0 Core Fund.
