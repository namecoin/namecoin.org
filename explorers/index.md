---
layout: page
title: Blockchain Explorers
---

{::options parse_block_html="true" /}

### With support for name and currency operations

[Cyphrs Namecoin Explorer](https://namecoin.cyphrs.com/) (free software; consensus-safe)<br>
{% assign shuffled_explorers_name_nonfree = site.data.explorers_name_nonfree | sample: 1 %}{% for i in shuffled_explorers_name_nonfree %}{{ i }}<br>{% endfor %}

### Currency operations only

{% assign shuffled_explorers_currency = site.data.explorers_currency | sample: 2 %}{% for i in shuffled_explorers_currency %}{{ i }}<br>{% endfor %}

To get on the list please post on the [forum](https://forum.namecoin.org).
