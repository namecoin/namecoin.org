<div class="post">

<header class="post-header">
<h1 class="post-title">{% if permalinks %}<a href="{{site.baseurl | append: '@@@' | remove: '/@@@'}}{{ post.url }}">{% endif %}{{ post.title }}{% if permalinks %}</a>{% endif %}</h1>
<p class="post-meta">{{ post.date | date: "%b %-d, %Y" }}{% if post.author %} • {{ post.author }}{% endif %}{% if post.meta %} • {{ post.meta }}{% endif %} {{tags_content}}</p>
</header>

<article class="post-content">
{{ post.content }}
</article>

</div>
