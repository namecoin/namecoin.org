---
layout: page
title: DNSSEC delegation (for name owners)
---

{::options parse_block_html="true" /}

`.bit` domains can delegate to an external DNSSEC nameserver via the `ns` and `ds` JSON fields (which correspond to the `NS` and `DS` DNS record types).  The `ns` record is used to find the nameserver; the `ds` record is used to authenticate the records returned by the nameserver.

## Downsides of using `ns` and `ds`

* Lookups will be slightly slower, since the latency of contacting the authoritative nameserver is added, whereas if the full zone is in the blockchain you'll only need to look things up from localhost.
* Currently incompatible with Tor (unless you run a recursive resolver inside a Whonix VM, which is a bad idea since you'll deanonymize yourself via stream isolation leaks). This might be fixable by implementing stream isolation support in a DNS recursive resolver (e.g. a Go-based recursive resolver), but it's probably not going to happen anytime soon (unless someone decides they want to sponsor that development work).
* Currently incompatible with ncdns's `certinject` feature, which means that TLS will only work if your applications natively support DANE (with ncdns's DNSSEC trust anchor).  This is probably fixable in the future.
* If all of the authoritative nameservers that you specify are DoSed, or decide they want to censor your domain, your domain will be inaccessible until one of the nameservers restores service. You can use multiple authoritative nameservers to attempt to mitigate this, but it's not going to be as good as keeping your zone in the blockchain.  (You *could* mitigate this by switching away from `ns`/`ds` in favor of storing your zone on the blockchain in the event that you actually encounter such DoS/censorship.  This allows you to benefit from DNSSEC's improved scalability as long as you're not being DoSed/censored, but it will mean a brief service interruption between the beginning of a DoS/censorship attack and when you notice and submit a `name_update` transaction.)
* You're more vulnerable to replay attacks, because DNSSEC signatures expire much more slowly than the DMMS signatures in the blockchain. If you urgently need to revoke your DNSSEC signatures without waiting for them to expire, you can replace your `ds` field in the blockchain, which isn't really any worse than replacing a `tls` field in the blockchain (both will take effect equally fast).
* Most DNSSEC software accepts weak signatures, e.g. RSA-1024 and SHA-1.
* Authoritative nameserver hosting services might cost money (but note that you'll save money on NMC fees, see below).
* Authoritative nameserver hosting services might not respect your anonymity when you sign up for service (but note that right now Namecoin doesn't yet respect your anonymity either).
* Signatures are less flexible.  It might be possible to do multisig via threshold signatures (we're not sure how feasible this is), but you definitely won't have the expressiveness of Bitcoin Script.

## Benefits of using `ns` and `ds`

* Your name's value will probably be smaller, which saves you fees and decreases blockchain bloat.
* Your name's value can probably be updated less often, which saves you fees and decreases blockchain bloat.
* You can more effectively hide the contents of your zone, since someone who wants to map out your zone will need to brute-force your authoritative nameserver instead of just reading your Namecoin value.
* You can use contextual rules for returning records to users, e.g. you can use geolocation of the source IP in order to point your users to an IP that minimizes latency. (Technically this could be added to the Namecoin JSON data format, but this is probably not going to happen anytime soon.)

## Aspects in which both approaches work equally well

* No one can forge records unless they have your private key.
* No one can forge nonexistence of your domain unless they have your private key.
* No one can steal your domain unless they have your private key.

## Using `ns` *without* `ds`

Using `ns` *without* `ds` is probably a bad idea, *unless* your zone is deliberately set up in a way that distrusts the nameserver.  For example, you could store a `tls` record in Namecoin, and use a nameserver exclusively for a dynamic IP address, in which case there's not much need for DNSSEC since IP addresses aren't a cryptographic identifier anyway.

## Private Keys

If you use a `ds` record for which someone else (e.g. your DNS hosting provider) has the private key, that party can forge both records and nonexistence for your zone.  You can avoid this circumstance by using a DNS hosting service that allows you to keep your DNSSEC private keys under your sole control; the key thing to look for is "secondary DNS with hidden master".

## DNS delegation is required (in some cases) for Namecoin's scalability

Generally speaking, if Namecoin achieved usage levels anywhere near what the DNS has, Namecoin would collapse if all the zones were stored in the blockchain. That doesn't imply that *all* Namecoin domains need to only have `ns` and `ds` fields set -- the choice of what's right for you is likely to depend on your security needs, how large your zone is, and how often you update it. (An extreme example is a CDN that has an incredibly complex configuration that changes every few seconds.)
