---
layout: post
title: "Porting DNSSEC-HSTS to Chrome"
author: Jeremy Rand
tags: [News]
---

As was discussed in my 35C3 slides, DNSSEC-HSTS is a WebExtension that prevents sslstrip attacks by using DNSSEC.  DNSSEC-HSTS is already available for Firefox, but (as a WebExtension) it should be easily portable to Chrome.  Not so fast: Chrome has a number of quirks that make this nontrivial.

First off, Chrome doesn't support asynchronous blocking WebRequest, which is a feature that DNSSEC-HSTS uses in order to retrieve DNS data from a native application.  I was able to work around this by converting the native messaging code used in the Firefox version into a standard HTTP request for Chrome.  HTTP is substantially less secure than native messaging, but since the Chrome developers don't seem to have any interest in security, we have to accept the reality that Chrome users will have less security than Firefox users.

Second, Chrome doesn't support SVG images as extension logos, which was causing Chrome to reject the DNSSEC-HSTS extension.  This was quite trivial to work around, since the Namecoin logo is also available as a PNG image.

Third, Chrome doesn't support loading unpacked extensions from the system.  (Chromium, as packaged by many GNU/Linux distros, does support this, but Google's binaries do not.)  I was able to work around this by packaging DNSSEC-HSTS as a CRX file.  Unfortunately, I'm not aware of any existing tools for supporting detached signatures for CRX files, which means that the CRX version of DNSSEC-HSTS will probably not be possible to build reproducibly.  This is unfortunate, but again, we have to accept the reality that the Chrome developers simply don't care about security, so Chrome users are going to have less security than Firefox users.

With these changes, DNSSEC-HSTS appears to work on Chrome; the changes will be included in the next release.

This work was funded by NLnet Foundation's Internet Hardening Fund.
