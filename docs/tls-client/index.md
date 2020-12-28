---
layout: page
title: TLS Client Compatibility
---

{::options parse_block_html="true" /}

Namecoin can be used for TLS certificate validation.  This page covers Namecoin's compatibility with various TLS implementations.

## TLS Validation Library Compatibility

|  | **Positive Overrides** | **Negative Overrides** | **Strict Transport Security** |
---|------------------------|------------------------|-------------------------------|
| **Chromium (all OS's)** | Not supported. | Supported via `tlsrestrict_chromium_tool`. | Not supported. |
| **CryptoAPI (Windows)** | Supported via ncdns's `certinject` feature. | Not supported. | Not supported. |
| **mozilla::pkix/NSS/sqlite (OS's with NSS `certutil`)** | Supported via ncdns's `tlsoverridefirefox` feature. | Supported via `tlsrestrict_nss_tool`. | Not supported. |
| **mozilla::pkix/NSS/sqlite (OS's without NSS `certutil`)** | Supported via ncdns's `tlsoverridefirefox` feature. | Not supported. | Not supported. |
| **mozilla::pkix/NSS/BDB** | Supported via ncdns's `tlsoverridefirefox` feature. | Not supported. | Not supported. |
| **mozilla::pkix/NSS/PKCS#11** | Supported via ncp11. | Supported via ncp11. | Not supported. |
| **NSS/sqlite (OS's with NSS `certutil`)** | Supported via ncdns's `certinject` feature. | Supported via `tlsrestrict_nss_tool`. | Not supported. |
| **WebExtensions (Asynchronous WebRequest)** | Not supported. | Not supported. | Supported via DNSSEC-HSTS with Native Messaging. |
| **WebExtensions (Synchronous WebRequest)** | Not supported. | Not supported. | Supported via DNSSEC-HSTS with HTTP API. |

## TLS Application Compatibility

|  | **Positive Overrides** | **Negative Overrides** | **Strict Transport Security** |
---|------------------------|------------------------|-------------------------------|
| **Chromium (GNU/Linux)**<br>[Instructions](chromium/gnu-linux/) | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. | Supported via WebExtensions (Synchronous WebRequest). |
| **Chromium (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. | Not supported. |
| **Firefox (GNU/Linux)**<br>[Instructions](firefox/gnu-linux/) | Supported via mozilla::pkix/NSS/sqlite. | Supported via mozilla::pkix/NSS/sqlite. | Supported via WebExtensions (Asynchronous WebRequest). |
| **Firefox (Windows)**<br>[Instructions](firefox/windows/) | Supported via mozilla::pkix/NSS/sqlite. | Supported via mozilla::pkix/NSS/sqlite. | Not supported. |
| **Google Chrome (GNU/Linux)**<br>[Instructions](chrome/gnu-linux/) | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. | Not supported. |
| **Google Chrome (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. | Not supported. |
| **Google Chrome Canary (GNU/Linux)** | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. | Not supported. |
| **Google Chrome Canary (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. | Not supported. |
| **Opera (GNU/Linux)** | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. | Not supported. |
| **Opera (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. | Not supported. |
| **Tor Browser (GNU/Linux)** <br> [Instructions](tor-browser/gnu-linux/) | Supported via mozilla::pkix/NSS/PKCS#11. | Supported via mozilla::pkix/NSS/PKCS#11. | Supported via WebExtensions (Asynchronous WebRequest). |
| **Tor Browser (macOS)** <br> [Instructions](tor-browser/macos/) | Supported via mozilla::pkix/NSS/PKCS#11.<br> **Untested** | Supported via mozilla::pkix/NSS/PKCS#11.<br> **Untested** | Not supported. |
| **Tor Browser (Windows)** <br> [Instructions](tor-browser/windows/) | Supported via mozilla::pkix/NSS/PKCS#11. | Supported via mozilla::pkix/NSS/PKCS#11. | Not supported. |

