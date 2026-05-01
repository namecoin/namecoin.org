---
layout: page
title: Blockchain Explorers
---

{::options parse_block_html="true" /}

### With support for name and currency operations

[Cyphrs Namecoin Explorer](https://namecoin.cyphrs.com/) (free software; consensus-safe)<br>
[mstrofnone nmc-rpc-explorer](http://23.158.233.10:3002/) ([Tor](http://6cbn4rskfdr647otej7gpqlmpqcmj723vg2eoeuu7ljbwu6cpdebozyd.onion:8080/)) (free software; consensus-safe; merge-mining-aware mining summary; full name-op aware mempool view)<br>
{% assign shuffled_explorers_name_nonfree = site.data.explorers_name_nonfree | sample: 1 %}{% for i in shuffled_explorers_name_nonfree %}{{ i }}<br>{% endfor %}
[Tokenview](https://nmc.tokenview.com/) (non-free software; requires JavaScript)<br>

### Currency operations only

{% assign shuffled_explorers_currency = site.data.explorers_currency | sample: 1 %}{% for i in shuffled_explorers_currency %}{{ i }}<br>{% endfor %}

To get on the list please post on the [forum]({{ site.forum_url }}).
