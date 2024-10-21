---
layout: post
title: "Namecoin's SocksTrace Receives Funding from NLnet Foundation’s NGI0 Core Fund"
author: "Robert Nganga"
tags: [News]
---

We're happy to announce that Namecoin is [receiving](https://nlnet.nl/news/2024/20241003-announcing-Core-call.html) additional funding from NLnet Foundation's NGI0 Core (Next Generation Internet: Zero Core) Fund. If you're unfamiliar with NLnet, you might want to read [about NLnet Foundation](https://nlnet.nl/foundation/), or just take a look at [the projects they've funded over the years](https://nlnet.nl/thema/index.html) (you might see some familiar names). 

This new funding is focused on SocksTrace. You might know SocksTrace by its former (and truly magical) name, Heteronculous-Horklump. While the former name was hilarious for Harry Potter geeks, we got feedback at 37C3 that it was too... let's say, "unmemorable" for the rest of the world (especially for non-native English speakers); thus, we’ve seized the chance to simplify things with a name that’s easier on the brain. Don't worry, though—the new name is still meme-worthy!

SocksTrace is a proxy leak detection tool designed for both CI testing and manual QA testing. It leverages the Linux `ptrace` feature to monitor socket syscalls that could potentially bypass a proxy.
Specifically, the following areas of development will be funded:

* Improved speed by whitelisting specific syscalls.
* Handling incoming TCP (Transmission Control Protocol) connections.
* Improved test coverage.
* Enforce stream isolation
* Provide support for POWER systems.
* SOCKSify DNS traffic

This work will principally be done by developers Jeremy Rand and Robert Nganga (who is the author of this post).

We’d like to thank the awesome people at NLnet Foundation for the continued vote of confidence, as well as the European Commision for their support of the Next Generation Internet.

We'll be posting updates regularly as development proceeds.
