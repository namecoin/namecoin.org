---
layout: post
title: "Anonymity Improvements in Electrum-NMC v4.0.6"
author: Jeremy Rand
date:   2022-10-28 02:00:00 +0000
tags: [News]
---

Electrum-NMC v4.0.6 (soon to be released) brings some long-awaited anonymity improvements.

## Automatic Coin Control for Names

I first described this feature in [my 34C3 presentation on anonymity]({{ "/2018/03/19/34c3-slides-videos.html" | relative_url }}).  There's not much else to say here; my presentation covers how the feature works and why that design was chosen.  The delay between 34C3 and implementation is due to the preferences expressed by the Tor developers, hopefully it was worth the wait.

## Whonix/Tails Support

Various anonymous OS's such as [Whonix]({{ whonix_url }}) and [Tails](https://tails.boum.org/) come with Tor preconfigured.  A major component of how these OS's handle preconfiguration is via environment variables that tell Tor-friendly applications such as Tor Browser and OnionShare where Tor's SOCKS port is.  Electrum-NMC now supports these environment variables, so it will automatically use the correct SOCKS port (with stream isolation) on Whonix and Tails instead of relying on transproxying.

As part of this work, I engaged with the Tor Applications Team on improving the specifications for Tor-friendly applications.  This work has been slower than hoped, but some major improvements have already worked their way through the review process, and I expect to deliver more improvements to these specifications in the coming months.

## AppArmor Sandboxing Support

Besides environment variables, another trick that Whonix uses to Torify applications is usage of AppArmor to blacklist traffic that doesn't go through Tor's SOCKS port.  This works by having Tor listen on a Unix domain socket, and then blacklisting IP sockets via AppArmor; standard filesystem ACL's take care of the rest.  Electrum-NMC now supports connecting to a SOCKS proxy via a Unix domain socket, so it should now be possible to enforce Torification via AppArmor.

So far, no one has written such an AppArmor policy for Electrum-NMC; this will be the subject of future work.

This work was funded by NLnet Foundation's NGI0 Discovery Fund.
