---
layout: post
title: "Transproxy Support in ZeroNet"
author: Jeremy Rand
tags: [News]
---

[ZeroNet](https://zeronet.io/) supports Namecoin as a naming layer.  Unfortunately, the UX for this feature isn't quite optimal.  Specifically, the `.bit` domain shows up in the path of the URL rather than the hostname; the hostname is the hostname of the machine running ZeroNet (typically `127.0.0.1`).  Can this be improved?

In a word, yes.  I've added *transproxy* support to ZeroNet, which facilitates a much better UX.  This feature uses the HTTP Host header to determine which `.bit` site is being accessed.  So if the `.bit` site points to `127.0.0.1`, you can type in the domain into your web browser, and your browser will automagically tell ZeroNet which website to display.

As an example, here's ZeroTalk displayed in Firefox in transproxy mode:

![A screenshot of ZeroTalk; the URL bar shows "talk.zeronetwork.bit".]({{site.baseurl}}images/screenshots/zeronet/zeronet-trans-proxy-2018-08-01.png)

This screenshot was obtained by fiddling with the OS's `hosts` file, but automatic ZeroNet integration could be added to ncdns in the future.
