---
layout: page
title: Exchanges
---

{::options parse_block_html="true" /}

<span class="exchanges-gold">&#8644;</span> You can buy and sell **Namecoins** here:

<span id="decentralized-exchanges" class="exchanges-gold">
**Decentralized exchanges**<br>
{% assign shuffled_exchanges_decentralized = site.data.exchanges_decentralized | sample: 2 %}{% for i in shuffled_exchanges_decentralized %}{{ i }}<br>{% endfor %}
</span>

<span class="exchanges-gold">
**Gold level exchanges**<br>
...<br>
</span>

<span class="exchanges-silver">
**Silver level exchanges**<br>
...<br>
</span>

<span class="exchanges-bronze">
**Bronze level exchanges**<br>
{% assign shuffled_exchanges_bronze = site.data.exchanges_bronze | sample: 1 %}{% for i in shuffled_exchanges_bronze %}{{ i }}<br>{% endfor %}
</span>

<span class="exchanges-basic">
**Basic level exchanges**<br>
{% assign shuffled_exchanges_basic = site.data.exchanges_basic | sample: 12 %}{% for i in shuffled_exchanges_basic %}{{ i }}<br>{% endfor %}
</span>

Gold, silver and bronze level exchanges donate to the Namecoin project. The higher the donation the higher the level. Note that the exchanges are not verified in any way.
The current fees are 1000/300/100NMC per year. To get on the list contact exchanges a|t namecoin.org
