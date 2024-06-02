---
layout: page
title: ".bit.arpa Proposal: Pros/Cons"
---

{::options parse_block_html="true" /}

As is well-known, Namecoin has been trying to get the `.bit` TLD reserved as a special-use domain name (similarly to `.onion`) via IETF or ICANN for the last few years.  In November 2018, we received some indication from IETF that we might be able to get the `.bit.arpa` 2nd-level domain reserved instead.  (The `.arpa` TLD is the "Address and Routing Parameter Area" and is administered by IANA; it's where a lot of Internet infrastructure lives and is not related to the Defense Advanced Research Projects Agency that created the Internet.)  This page documents the pros and cons of accepting that proposal.

*Do you have an opinion on whether we should use `.bit.arpa`?  Have we missed an important pro or con here?  Please let us know [on the forum](https://forum.namecoin.org/) or [on Reddit](https://www.reddit.com/r/Namecoin/)!*

## Pro: It's a special-use domain name

Being recognized as a special-use domain name would mean that IETF and ICANN are formally recognizing that `.bit.arpa` belongs to Namecoin, not to the DNS.  In particular, that would mean the following:

1. ICANN would not be able to assign `.bit.arpa` to a 3rd party as a gTLD.
2. We would be able to stipulate a requirement as an IETF RFC that public DNS infrastructure (including the ICANN root and Google DNS) would be required to not forward `.bit.arpa` requests; this protects privacy (because `.bit.arpa` domains wouldn't hit as many servers) and also protects security (because public DNS infrastructure wouldn't be able to make up fraudulent `.bit.arpa` response data without being detected by DNSSEC).
3. Certificate authorities would be able to issue EV (extended validation) certificates for `.bit.arpa` domains.  While Namecoin is able to handle DV (domain validation) certificates without needing CA's, the Namecoin ecosystem doesn't have any support for EV certificates right now.

## Pro: We can get it with minimal bickering between us and IETF/ICANN

Assigning a TLD as special-use carries significant political and legal baggage, because the namespace of the ICANN root is available for purchase via the ICANN gTLD program.  As a result, if we were assigned `.bit` by IETF or ICANN, and someone later decided that they have a trademark claim or government name claim to the word "bit", IETF or ICANN could be subject to legal trouble.  In contrast, 2nd-level domains under the `.arpa` TLD are not available for purchase from ICANN, and therefore no one else will be able to make such a claim.  This means that while `.bit` is politically difficult to assign, `.bit.arpa` is politically straightforward and allows us to spend our dev time on writing code rather than lengthy and potentially-unsuccessful negotiations with IETF and ICANN.

## Con: Public perception that Namecoin is subject to the whims of IETF/IANA/ICANN

A significant subset of Namecoin's userbase is hostile to ICANN's jurisdiction over the DNS root zone.  This document does not attempt to evaluate the size of that subset, or whether that hostility is well-justified, but regardless, there is a risk that Namecoin users who are hostile to ICANN will react negatively to any action by Namecoin developers that could be perceived as subordination to ICANN.

## Con: Public perception that Namecoin is affiliated with DARPA

The `.arpa` TLD was originally set up as a compatibility bridge between ARPANET's naming system and the DNS (much like how ncdns is a compatibility bridge between DNS and Namecoin); `arpa` was an abbreviation for ARPANET.  After this role was obsoleted (due to DNS fully replacing ARPANET's naming system), `.arpa`'s acronym expansion was renamed to the "Address and Routing Parameter Area", a name consistent with its current usage (storing Internet infrastructure).  Although `.arpa` has never been used for DARPA purposes (beyond being a TLD that had a significant fraction of subdomains pointing to servers run by the ARPANET researchers at DARPA), there is a risk that end users who encounter a link to a `.arpa` website will erroneously assume that `.arpa` stands for the Defense Advanced Research Projects Agency and that the website in question is affiliated with the U.S. military.  This assumption is made more likely by the fact that most users have never encountered the Internet infrastructure that lives under the `.arpa` TLD today (that infrastructure is generally not user-facing).  Given that Namecoin targets audiences such as political dissidents (in countries such as the U.S. and Iran), many members of this audience may be reluctant to visit a website that they perceive is affiliated with the U.S. military (because U.S. dissidents expect the U.S. military to want to spy on them, and Iranian dissidents expect risk of arrest if they are identified as collaborating with the U.S. military).  We don't have much ability to explain this to end users when all they see is a link to a website.  There is further risk that governments would try to infiltrate dissident groups in order to spread rumors that Namecoin is affiliated with the U.S. military, similar to FUD campaigns about Tor being based on technology created by the Naval Research Laboratory.

## Pro: `.home.arpa` now exists

The `.home.arpa` domain was approved as a special-use domain name in May 2018, and is intended for use by devices on home networks.  There is therefore a significant probability that average users who currently don't know what `.arpa` is will come to associate `.arpa` with their home network's devices rather than DARPA.  It is, however, unclear to what extent `.home.arpa` will actually be adopted.

## Pro: Relatively easy for Namecoin software to make the migration

ncdns already supports arbitrary domain suffixes; making it use `.bit.arpa` instead of `.bit` would be a simple matter of changing one line in a config file.

## Pro: Relatively easy for website owners to make the migration

Website owners would simply need to change the `VirtualHost` line in their config file to use `.bit.arpa` rather than `.bit`.

## Con: Takes longer to type and pronounce

`.bit` is short, easy to remember, easy to type, and easy to pronounce.  `.bit.arpa` is less so.

## Con: Existing web links would need to be updated

Website hyperlinks pointing to `.bit` websites would need to be updated to point to `.bit.arpa`.  This may not be a big problem right now, since `.bit` links aren't very common yet.

## Con: Unclear whether using `.bit.arpa` would preclude us from getting `.bit`

If we accept `.bit.arpa`, it is unclear whether this would hamper us from subsequently lobbying IETF and/or ICANN for `.bit`.

## Pro: 2nd-level domains work better for certificate pins in many TLS implementations

Some certificate pinning implementations (in particular, Firefox's mozilla::pkix and Windows's Enterprise Certificate Pinning) don't allow certificate pins to be placed on TLD's like `.bit`, but are fine with 2nd-level domains like `.bit.arpa`.  Using `.bit.arpa` would therefore be an interesting way to work around that restriction as a Namecoin TLS interoperability system.
