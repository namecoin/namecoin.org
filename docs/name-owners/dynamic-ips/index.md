---
layout: page
title: "Configuring Dynamic IP's (for name owners)"
---

{::options parse_block_html="true" /}

## Delegate to DNS

The most straightforward way to point a `.bit` domain to a dynamic IP address is to delegate your `.bit` domain to DNS via the `ns` or `alias` field, and send your IP address updates to that nameserver or DNS domain name.  This avoids paying Namecoin transaction fees for each IP address update.  Using the `ds` field is not necessary, since IP addresses aren't cryptographic identifiers.

## Delegate to a Tor onion service

Tor onion services are an effective way to get a stable address when your IP address is dynamic.  You can point your `.bit` domain to a `.onion` domain, which will allow Tor users to access your `.bit` domain regardless of your IP (even if you're behind NAT or a firewall).  Like DNS delegation, this avoids paying Namecoin transaction fees for each IP address update.  This approach won't help if you want your `.bit` domain to be accessible by users who don't use Tor.

## DyName

If delegation to DNS or a Tor onion service doesn't meet your requirements, you can also use DyName.  DyName is a dynamic IP address update client for `.bit` domains.  DyName should only be used in combination with [delegated alteration]({{site.baseurl}}docs/name-owners/delegated-alteration).  Using DyName will incur transaction fees (and blockchain storage) for each IP address update.

To obtain DyName, [visit the GitHub project.](https://github.com/JeremyRand/DyName)
