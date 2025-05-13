---
layout: post
title: "Code Quality Improvements in ncp11"
author: Jeremy Rand
tags: [News]
---

As you may recall, ncp11 is Namecoin's PKCS#11 module that enables TLS to work for Namecoin domains with standard TLS clients that use NSS or GnuTLS. I've recently made several improvements to ncp11:

## Add additional tracing

Namecoin's PKCS#11 modules can log traces of their internal state, which can be helpful for debugging. I've expanded ncp11's tracing to cover some additional state.

## Disable Certificate Transparency

Modern versions of Firefox and Chromium mandate Certificate Transparency for all certificates by default. Namecoin, of course, cannot comply with this requirement, since the public CT logs don't accept Namecoin certificates. (To some Namecoin users, this is a feature, not a bug.) This was causing CT errors to show up for Namecoin certificate chains.

I've changed ncp11's trust bits to opt out of the CT requirement for all Namecoin certificates. This gets ncp11 working again in modern browsers.

## Work around NSS blacklisting bug

NSS allows PKCS#11 modules to mark a CA as explicitly distrusted for root CA purposes, while still trusting them if they are issued by a trusted CA. ncp11 had been using this for all intermediate CA's that it signed, but testing showed that NSS's behavior doesn't match the documentation, and this feature seems to be broken -- marking a CA in this way will result in it being distrusted regardless of its issuer.

I've worked around this by making trust objects optional in p11trustmod, and making ncp11 not return trust objects for intermediate CA's. This makes ncp11's generated certificate chains substantially more reliable.

## Set media type correctly on PEM responses

Encaya's API endpoint for ncp11's usage was returning PEM certificate bundles with the default `text/plain` media type. This is not really spec-compliant. I've made it return a proper `application/x-pem-file` media type. ncp11 itself didn't care, but this does mean that using the Encaya web interface to download the Encaya root CA certificate will now produce a download dialog as expected, instead of showing a bunch of text in the web browser.

## Unify AIA and PKCS#11 implementations

Encaya has two API endpoints: one for AIA usage, and one for PKCS#11 usage. There are a number of differences, mostly related to differences in how AIA clients and PKCS#11 clients query and cache things. These endpoints had substantial code duplication, which was not great for maintainability. I've factored out the common code into a `lookupCert` function. The result:

|              | Lines of Code (Before) | Lines of Code (After) |
---------------|------------------------|-----------------------|
| AIA          | 157                    | 33                    |
| PKCS#11      | 153                    | 47                    |
| Server Total | 902                    | 802                   |

The refactored code is much cleaner, easier to follow, and will facilitate decreased effort for future improvements.

This work was funded by Power Up Privacy.
