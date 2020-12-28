---
layout: post
title: 'We oppose the takeover of Open Technology Fund -- closed-source projects are scams and must not receive "Internet Freedom" funding'
author: 'Jeremy Rand, Daniel Kraft, Andy Colosimo, Ahmed Bodiwala, Somewhat, and Anonymous Namecoin Developer(s)'
tags: [News]
---

We are watching with alarm the currently-ongoing takeover of the Open Technology Fund (OTF) by the Trump Administration's newly appointed CEO of the US Agency for Global Media (USAGM, formerly known as BBG), Michael Pack.  In the first week of the new USAGM leadership, Michael has fired OTF CEO Libby Liu and OTF President Laura Cunningham, and (according to a document released by Libby) is apparently preparing to redirect OTF funding away from the current diverse set of open-source tools in favor of a small set of tools, narrowly focused on censorship circumvention, including the closed-source scam projects "Freegate" and "Ultrasurf".

Developers of Internet Freedom software, including but not limited to Namecoin, are on the known target lists of intelligence agencies of repressive governments.  The open-source nature of our tools is a prerequisite for users to verify that we have not backdoored the software (e.g. to get dissidents killed).  Furthermore, our own safety as developers is dependent on those intelligence agencies being aware that trying to coerce us to add a backdoor would be futile due to our software's open-source nature.

For this reason, Namecoin doesn't just settle for releasing our code under an OSI/FSF-approved license; we lead by example and push forward the front lines of openness.  For example:

* We strive for reproducible builds in all software we release.
* We use computers with open-source firmware such as the Asus C201 and the Raptor Talos II for as much of our workflow as possible.
* We contribute patches to upstream software infrastructure for reproducible builds (e.g. the Gitian and rbm tools used by Tor include patches we authored).
* We contribute code to software projects improving support for platforms with open-source firmware (e.g. we contribute patches to PrawnOS, we reverse-engineered the Talos II NIC firmware, and we are in the process of porting Tor Browser to ARM and POWER).

Let us be very clear: software projects that claim to enable "Internet Freedom" but which do not share this commitment to open-source principles are scams.  They actively endanger dissidents who are unwise enough to use them.  Under no circumstances should they receive OTF funding, or any other type of taxpayer-derived funding.

In addition, the needs of dissidents are substantially more diverse than solely censorship circumvention.  Software to defend against surveillance is also critical, as are security audits, bug bounty programs, and countless other areas that OTF currently funds.  If anything, OTF's remit would benefit from expansion; narrowing their focus to solely censorship circumvention will leave critical projects in the lurch, endangering the safety of dissidents worldwide.  We are particularly concerned about the harm caused by a narrow focus on censorship circumvention functionality due to the following considerations:

* Users have empirically been demonstrated to not understand the difference between anonymity and anti-censorship functionality, and giving them software that's not safe for anonymity will result in many users using it in ways that are dangerous.
* Even in a fantasy world where 100% of the users who actually need anonymity stick with tools that are safe for that use case, an exodus of the rest of the users will leave the anonymity-requiring users with a dangerously small anonymity set.  It is well-known that the reason NRL opened onion routing to the public is that an anonymity network only used by the US Navy doesn't actually help anonymize the US Navy.  For the same reason, an anonymity network used by Chinese dissidents who require anonymity to stay safe must have a large amount of cover traffic, and users who are circumventing censorship are a major source of that cover traffic.
* Censorship circumvention software that relies on security by obscurity is more likely to be censored, potentially with catastrophic timing.
* Closed-source software, even if it is not required to preserve anonymity, is likely to be vulnerable to non-anonymity security bugs due to lack of peer review.  At this point we're not even talking about repressive governments *deanonymizing* users, we're talking about repressive governments *obtaining remote code execution* on dissidents' machines.  At that point dissidents are screwed.
* These closed-source censorship circumvention systems consider the centralized operators to be completely trusted 3rd parties.  There is nothing preventing these operators from covertly collecting logs of the activity of dissidents, and selling them to the highest bidder (which will probably be the governments of the countries in which the dissidents reside).  Even in the fictional scenario where these operators don't intend to do this, an intelligence agency who compromises the operators' infrastructure can pull off this attack without the operators' knowledge or consent.  Again, at this point dissidents are screwed.

We have signed an open letter asking Members of U.S. Congress to:

* Require USAGM to honor existing FY2019 and FY2020 spending plans to support the Open Technology Fund;
* Require all US-Government internet freedom funds to be awarded via an open, fair, competitive, and evidence-based decision process;
* Require all internet freedom technologies supported with US-Government funds to remain fully open-source in perpetuity;
* Require regular security audits for all internet freedom technologies supported with US-Government funds; and
* Pass the Open Technology Fund Authorization Act.

While it is regrettable that so much Internet Freedom infrastructure is dependent on OTF (Decentralize All The Things!), and it would be advisable for affected projects to investigate diversifying their funding sources, that cannot be done overnight.  The damage done by a successful hijacking of OTF *will* occur overnight, and will cause lasting damage that cannot be mitigated by a long-term strategy of diversification.  As such, it is critical that the decentralization community oppose the OTF takeover.

Help us save OTF from takeover.  [You can find more information on how to help here.](https://saveinternetfreedom.tech/information/how-to-help/)
