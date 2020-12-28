---
layout: post
title: "DNS Builder GUI for Electrum-NMC"
author: Jeremy Rand
tags: [News]
---

In November 2017, Brandon posted some WIP code for adding a DNS Builder GUI to Namecoin-Qt.  To refresh your memory, it looked like this:

![A screenshot of the DNS builder for Namecoin-Qt.]({{site.baseurl}}images/screenshots/namecoin-core/dns-builder-2017-11-19.gif)

Unfortunately, merging that code to Namecoin Core is blocked by several other tasks, so it may be a while before it makes its way into a Namecoin Core release.  However, in the meantime, all is not lost.  Thanks to the magic of Qt GUI's being in XML format, and therefore easy to port between C++ and Python, I've been spending some time porting Brandon's DNS Builder GUI to Electrum-NMC.

Things are still a bit rough around the edges, but it's beginning to take shape.  Check out the below screenshot:

![A screenshot of the DNS builder for Electrum-NMC.]({{site.baseurl}}images/screenshots/electrum-nmc/2019-12-02-DNS-Builder.png)

So far, the following features work:

* Creating and parsing the following record types:
    * IPv4 addresses
    * IPv6 addresses
    * Tor onion services
    * I2P eepsites
    * Freenet freesites
    * ZeroNet zites
    * NS delegations
    * DS fingerprints
    * CNAME aliases
    * TLS fingerprints
    * SSH fingerprints
    * TXT records
    * SRV records
    * Domain data imports
* Parsing subdomains (recursively)
* Creating and sorting subdomains
* Input validation (only verifying that integer fields are valid integers, and no real-time feedback)
* Repairing the deprecated forms of Tor and ZeroNet records
* Size optimizations, e.g. setting `"ip6"` to a string instead of an array containing one string

The following features still need implementation:

* Creating and parsing the following record types:
    * WHOIS info
    * DNAME subtree aliases (not particularly high priority because it's a footgun)
* Editing existing records (this is partially implemented)
* Deleting existing records
* More input validation (the sharp-eyed among you probably noticed that it allowed me to enter `blah.onion` as a Tor onion service despite that string being invalid), with real-time feedback
* More friendly guidance for some parameters (e.g. the "Cert. usage", "Selector", and "Matching Type" parameters in the TLS tab would probably be more suitable as a drop-down list or combo box)

Hopefully this work will improve the UX so that Namecoin domain owners aren't expected to handle JSON manually.

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.
