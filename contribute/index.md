---
layout: page
title: Contribute
---

{::options parse_block_html="true" /}

So you'd like to support Namecoin?  Great!  There are several ways you can help keep Namecoin strong.

## Donate

Donations help our developers pay the bills, and sometimes can even enable new developers to join the project.  [You can donate to the Namecoin project here.]({{ "/donate/" | relative_url }})

## Buy (and wear) merchandise

You can buy Namecoin-branded merchandise (e.g. T-shirts and stickers) from our friends at [Cypher Market](https://www.cyphermarket.com/namecoin/) and [Teespring](https://namecoin.creator-spring.com/).  Not only is this a great way to spread the word, but a cut of the profits supports Namecoin development.

## Run a full node

Full nodes (Namecoin Core nodes) are the core of the Namecoin P2P network.  The more people run full nodes, and the more geographically and jurisdictionally diverse those full nodes are, the stronger the Namecoin P2P network becomes.  See our [Debian deployment guide for Namecoin Core + ElectrumX]({{ "/docs/namecoin-core-electrumx/" | relative_url }}) for automated server setup instructions.  Please consider running [Namecoin Core]({{ "/download/#namecoin-core-client-with-qt-name-tab" | relative_url }}) on as many of the following networks as you can:

* IPv4 (preferably allowing incoming connections)
* IPv6 (preferably allowing incoming connections)
* Ephemeral Tor onion service ([docs](https://github.com/namecoin/namecoin-core/blob/master/doc/tor.md))
* Stable Tor onion service ([docs](https://github.com/namecoin/namecoin-core/blob/master/doc/tor.md))

## Test betas

Do you enjoy living on the cutting edge?  Are you highly skilled at breaking things?  You can help us by testing [beta releases of Namecoin software]({{ "/download/betas/" | relative_url }}), and letting us know what we can improve.

## Run a `.bit` website

Do you have a website?  Register a `.bit` domain for it with Namecoin, enable TLS on it, and tell your website's visitors that they can optionally access your site via Namecoin.

Don't have a website?  Ask your favorite websites' operators to get a `.bit` domain.

## Improve decentralized exchange liquidity

Decentralized exchanges offer better security and privacy than centralized exchanges.  You can help make decentralized exchanges easier to use by posting buy and sell offers on them.  [See the list of decentralized exchanges here.]({{ "/exchanges/#decentralized-exchanges" | relative_url }})

## Run a DNS seed

DNS seeds help Namecoin users find peers.  You can run a DNS seed via [dnsseeder](https://github.com/gombadi/dnsseeder) (use the `namecoin.json` config file).  Typical bandwidth usage is approximately 2.5 MB per day.  Please consider running a DNS seed on both IPv4 and IPv6.  If you've set up a DNS seed, [let us know](https://github.com/namecoin/namecoin-core/issues/new/choose) so we can add it to the client.

## Run an ElectrumX server

ElectrumX servers help Electrum-NMC users synchronize the blockchain more quickly and securely.  You can run one by installing [ElectrumX](https://github.com/spesmilo/electrumx) (set `COIN=Namecoin`).  Our [Debian deployment guide]({{ "/docs/namecoin-core-electrumx/" | relative_url }}) covers automated setup of both Namecoin Core and ElectrumX together.  Please consider running ElectrumX on as many of the following networks as you can, for both mainnet and testnet:

* Raw IPv4 address
* Raw IPv6 address
* Domain name pointing to IPv4 address
* Domain name pointing to IPv6 address
* Tor onion service

If you've set up an ElectrumX server, [let us know](https://github.com/namecoin/electrum-nmc/issues/new/choose) so we can add it to the client.

## Merge-mine Namecoin

Do you mine Bitcoin at a mining pool?  Consider using a Bitcoin mining pool that [also merge-mines Namecoin]({{ site.metrics_url }}/namecoin/period-timestamps-14-days/pool/charts/latest.txt).  You can help keep Namecoin mining decentralized by using the lowest-hashrate pool available that still meets your requirements, or by using [P2Pool](https://github.com/p2pool/p2pool) or solo-mining.

## Write documentation

Is our documentation not clear about (or just plain missing) something?  Are you good at creating text, image, or video tutorials?  You can help us by improving our documentation.  Talk to us (Matrix or IRC preferred) and we'll be happy to assist.

## Write code

Are you a coder?  We'd love some help coding Namecoin!  Talk to us (Matrix or IRC preferred) and we'll find some tasks that are well-suited to your interests and skill set.

## Tell your friends

Are you a journalist?  Do you have a social media platform?  Heck, do you just have a few like-minded friends?  Spread the word about Namecoin and why it matters to you.
