---
layout: page
title: Namecoin
---

{::options parse_block_html="true" /}

**Namecoin** is an experimental open-source technology which improves decentralization, security, censorship resistance, privacy, and speed of certain components of the Internet infrastructure such as DNS and identities.

(For the technically minded, Namecoin is a key/value pair registration and transfer system based on the Bitcoin technology.)

*Bitcoin frees money – Namecoin frees DNS, identities, and other technologies.*

<div class="row">

<div class="col-md-6">

## What can Namecoin be used for?

* Protect free-speech rights online by making the web more resistant to censorship.
* Attach identity information such as GPG and OTR keys and email, Bitcoin, and Bitmessage addresses to an identity of your choice.
* Human-meaningful Tor .onion domains.
* Decentralized TLS (HTTPS) certificate validation, backed by blockchain consensus.
* Access websites using the .bit top-level domain.

</div>

<div class="col-md-6">

What does Namecoin do under the hood?
-------------------------------------

* Securely record and transfer arbitrary names (keys).
* Attach a value (data) to the names (up to 520 bytes).
* Transact the digital currency namecoins (NMC).
* Like bitcoins, Namecoin names are difficult to censor or seize.
* Lookups do not generate network traffic (improves privacy).

**Namecoin** was the first fork of [Bitcoin](https://bitcoin.org) and still is one of the most innovative "altcoins".  It was first to implement [merged mining](https://bitcoin.stackexchange.com/questions/273/how-does-merged-mining-work) and a [decentralized DNS]({{site.baseurl}}dot-bit/).  **Namecoin** was also the first solution to [Zooko's Triangle](https://en.wikipedia.org/wiki/Zooko%27s_triangle), the long-standing problem of producing a naming system that is simultaneously secure, decentralized, and human-meaningful.

</div>
</div>

## More Information

* [Namecoin Identities](https://nameid.org)
* [.bit DNS]({{site.baseurl}}dot-bit/)

## News

([RSS Feed]({{site.baseurl}}feed.rss))

{% for post in site.posts limit:10 %}
{% assign content_words = post.content | number_of_words %}
{% assign excerpt_words = post.excerpt | number_of_words %}
**[{{ post.date | date: "%Y-%m-%d" }}]({{site.baseurl | append: '@@@' | remove: '/@@@'}}{{ post.url }})** {{ post.excerpt | remove: '<p>' | remove: '</p>' }}  {% if content_words != excerpt_words %} [Read more...]({{site.baseurl | append: '@@@' | remove: '/@@@'}}{{ post.url }}) {% endif %}

{% endfor %}

[Earlier news]({{site.baseurl}}news/)

For the latest news go to the [Namecoin forum](https://forum.namecoin.org/) or check out [r/namecoin](https://www.reddit.com/r/namecoin).

Official anouncements will also be made on [this BitcoinTalk thread](https://bitcointalk.org/index.php?topic=236340.0).

## Donate
Help keep us **strong**.  [You can donate to the Namecoin project here.]({{site.baseurl}}donate/)

## Participate
With **Namecoin** you can make a difference.  We need your **help to free information**, especially in documentation, marketing, and [coding](https://github.com/namecoin/).  You are welcome at the [forum](https://forum.namecoin.org/).  There may be [bounties](https://forum.namecoin.org/viewforum.php?f=18), too.
