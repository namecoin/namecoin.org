---
layout: page
title: Namecoin Resolution with Tor
---

{::options parse_block_html="true" /}

Namecoin can be used for name resolution with Tor.  Several guides are available for setting this up, depending on your choice of software.

## Guides

* [ncprop279 with StemNS **(Use this if you're not sure)**](ncprop279/stemns/)
* [ncprop279 with TorNS](ncprop279/torns/)
* [dns-prop279 with StemNS](dns-prop279/stemns/)
* [dns-prop279 with TorNS](dns-prop279/torns/)

Want to decide for yourself?  Read on:

## Should I use ncprop279 or dns-prop279?

*Average users are probably better off with ncprop279.*

dns-prop279 is more flexible, since it can access `.bit` domains that delegate to nameservers or otherwise require a recursive resolver.  However, that flexibility can be a footgun since recursive resolvers will typically cause proxy leaks.  dns-prop279 also requires a DNS server (e.g. ncdns or Unbound), whereas ncprop279 operates without a DNS server.  ncprop279 is substantially smaller in binary size than dns-prop279 combined with ncdns.

## Should I use StemNS or TorNS?

*Average users are probably better off with StemNS.*

TorNS uses the `txtorcon` library, while StemNS uses the `stem` library.  `stem` is a substantially smaller download.  StemNS focuses on security, while TorNS focuses on facilitating experimentation/development.

