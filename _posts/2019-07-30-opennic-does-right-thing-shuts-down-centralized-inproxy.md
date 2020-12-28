---
layout: post
title: "OpenNIC does the right thing: listens to security concerns and shuts down its centralized Namecoin inproxy"
author: Jeremy Rand
tags: [News]
---

In September 2018, I published [a case study]({{site.baseurl}}2018/09/24/how-centralized-inproxies-make-everyone-less-safe-case-study.html) about centralized inproxies and how they can cause security dangers even to competent users who think they're using a decentralized system.  Although my article wasn't targeted at any particular entity (like all case studies, it uses a specific entity to make generalizations about a wider field), the case study used OpenNIC's inproxy as an example.  (The fact that OpenNIC ended up as the example isn't due to any fault of OpenNIC, it's simply that the sysadmin mentioned in the case study happened to be an OpenNIC user.)  In December 2018, [PRISM Break](https://prism-break.org/) maintainer Yegor Timoshenko (who is a friend of Namecoin) independently raised similar security concerns about OpenNIC's Namecoin inproxy, commenting in PRISM Break's Matrix channel "i'm not too happy we recommend dns servers that resolve .bit for users, it seems to be nearly as much helpful as resolving .onion" and subsequently proposing that PRISM Break avoid recommending DNS services that include that kind of functionality.

Guess what?  OpenNIC listened to the concerns of Yegor and myself, and has decided to shut down their centralized Namecoin inproxy.  This was probably not an easy decision, as OpenNIC's Namecoin inproxy had been a significant usage draw for OpenNIC, and it is likely that a significant portion of OpenNIC users (who were using OpenNIC solely for its Namecoin inproxy) will move to decentralized methods and leave OpenNIC's other TLD's behind.  Most corporate actors probably wouldn't have done this.  But it was the right decision.

I'd like to thank OpenNIC for taking Yegor's and my concerns seriously.  I regularly recommend OpenNIC (the non-`.bit` TLD's) to users who don't need Namecoin's security model but who want a regulatory environment that isn't subject to ICANN policies; I will continue to do so.  If you happen to hang around the OpenNIC community, I encourage you to thank OpenNIC for this decision as well.

*This news post was intended to be posted near the beginning of July 2019, but was delayed because I was busy attending the Tor developer meeting in Stockholm.  I apologize for the delay.*
