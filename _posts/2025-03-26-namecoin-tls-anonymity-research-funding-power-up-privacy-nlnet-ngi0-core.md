---
layout: post
title: "Namecoin Receives TLS and Anonymity Research Funding from Power Up Privacy and NLnet Foundation’s NGI0 Core Fund"
author: "Alice Margatroid and Jeremy Rand"
date:   2025-03-30 02:00:00 +0000
tags: [News]
---

We're happy to announce that Namecoin is receiving three new grants:

* $25,760 USD from Power Up Privacy for anonymity research and development.
    * Alice Margatroid is project lead.
    * Jeremy Rand and Brandon Roberts will assist as needed.
* $24,480 USD from Power Up Privacy for TLS research and development.
    * Jeremy Rand is project lead.
    * Robert Nganga will assist as needed.
* 20,000 EUR from NLnet Foundation's NGI0 Core (Next Generation Internet: Zero Core) Fund for TLS research and development.
    * Jeremy Rand is project lead.
    * Robert Nganga will assist as needed.

## Anonymity R&D Grant

Most anonymity-related tools focus on preventing metadata leaks, e.g. Tor (prevents leaking your IP address metadata) and Mullvad Browser (prevents leaking your browser fingerprint metadata). However, there is another class of deanonymization vectors: the content of the communication itself. For example, mentioning the weather is an easy way to severely narrow your anonymity set. Alice is developing an automated tool that warns users if they are at risk of deanonymizing themselves in this way.

Namecoin has a solid history of developing privacy/security tools that aren't strictly tied to the Namecoin blockchain, including SocksTrace, certinject, and pkcs11mod. This isn't unusual in this space; Tor Project also routinely publishes research that isn't strictly related to the Tor network. We're excited to continue this trend.

## TLS R&D Grants

Namecoin's TLS support has a solid track record on scalability, including our innovations on layer-2 TLS. These grants will cover additional Namecoin scalability improvements, including fleshing out various functionality that Robert's 38C3 talk covered. They will also cover collaboration with Tor Project on areas of TLS-related common interest, including fleshing out the onion service functionality that Jeremy's 38C3 talk covered.

Our collaboration with Tor Project goes back many years, and we're happy that this will be continuing.

## Funding Sources

You're probably familiar with NLnet Foundation by now, but if not, you might want to read [about NLnet Foundation](https://nlnet.nl/foundation/), or just take a look at [the projects they've funded over the years](https://nlnet.nl/thema/index.html) (you might see some familiar names).

[Power Up Privacy](https://powerupprivacy.com/) is a relatively new funder whom you may not have heard of, but they fund some familar names as well. Diversifying Namecoin's funding has been a goal for a while now, and we're pleased to add Power Up Privacy to our growing list of funders.

We'd like to thank the awesome people at NLnet Foundation for the continued vote of confidence, as well as the European Commision for their support of the Next Generation Internet. And a huge thank-you to Power Up Privacy for their new support!

Alice and Jeremy will be posting updates regularly as development proceeds.
