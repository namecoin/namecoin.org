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

* Protecting free-speech rights online by making the web more resistant to censorship.
* Attaching identity information such as GPG and OTR keys and email, Bitcoin, and Bitmessage addresses to an identity of your choice.
* Human-meaningful Tor .onion domains.
* Decentralized TLS (HTTPS) certificate validation, backed by blockchain consensus.
* Accessing websites using the .bit top-level domain.

</div>

<div class="col-md-6">

What does Namecoin do under the hood?
-------------------------------------

* Securely record and transfer arbitrary names (keys).
* Attach a value (data) to the names (up to 520 bytes).
* Transact the digital currency namecoins (NMC).
* Like bitcoins, Namecoin names are difficult to censor or seize.
* Lookups do not generate network traffic (improves privacy).

**Namecoin** was the first fork of [Bitcoin](https://bitcoin.org) and still is one of the most innovative "altcoins".  It was first to implement [merged mining](https://bitcoin.stackexchange.com/questions/273/how-does-merged-mining-work) and a [decentralized DNS]({{ "/dot-bit/" | relative_url }}).  **Namecoin** was also the first solution to [Zooko's Triangle](https://en.wikipedia.org/wiki/Zooko%27s_triangle), the long-standing problem of producing a naming system that is simultaneously secure, decentralized, and human-meaningful.

</div>
</div>

## More Information

* [Namecoin Identities](https://nameid.org)
* [.bit DNS]({{ "/dot-bit/" | relative_url }})

## News

([RSS Feed]({{ "/feed.rss" | relative_url }}))

{% for post in site.posts limit:10 %}
{% assign content_words = post.content | number_of_words %}
{% assign excerpt_words = post.excerpt | number_of_words %}

### [{{ post.title }}]({{ post.url | relative_url }})

**[{{ post.date | date: "%Y-%m-%d" }}]({{ post.url | relative_url }})** {{ post.excerpt | remove: '<p>' | remove: '</p>' }}  {% if content_words != excerpt_words %} [Read more...]({{ post.url | relative_url }}) {% endif %}

{% endfor %}

[Earlier news]({{ "/news/" | relative_url }})

For the latest news go to the [Namecoin forum]({{ site.forum_url }}/) or check out [r/namecoin](https://www.reddit.com/r/namecoin).

Official anouncements will also be made on [this BitcoinTalk thread](https://bitcointalk.org/index.php?topic=236340.0).

## Donate
Help keep us **strong**.  [You can donate to the Namecoin project here.]({{ "/donate/" | relative_url }})

## Participate
With **Namecoin** you can make a difference.  We need your **help to free information**, especially in documentation, marketing, and [coding](https://github.com/namecoin/).  You are welcome at the [forum]({{ site.forum_url }}/).  There may be [bounties]({{ site.forum_url }}/viewforum.php?f=18), too.
