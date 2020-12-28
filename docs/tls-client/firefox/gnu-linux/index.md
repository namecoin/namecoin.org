---
layout: page
title: "TLS for Firefox on GNU/Linux"
application: "Firefox"
webextsystem: "/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
---

{% assign nssdbdir = "$HOME/.mozilla/firefox" %}
{% assign nativemessagingdir = "/usr/lib64/mozilla/native-messaging-hosts" %}
{% assign os = "GNU/Linux" %}

{% include tls_mozilla_pkix.md %}

{% include tls_dnssec_hsts_webext_system.md %}
