---
layout: page
title: News
---

{::options parse_block_html="true" /}

{% include post_tags.html %}

{% assign permalinks = "1" %}

([RSS Feed]({{site.baseurl}}feed.rss))

{% for post in site.posts %}

{% include single_post.md %}

{% endfor %}
