---
layout: page
title: TLS Client Compatibility
---

{::options parse_block_html="true" /}

Namecoin can be used for TLS certificate validation.  This page covers Namecoin's compatibility with various TLS implementations.

## TLS Validation Library Compatibility

|  | **Positive Overrides** | **Negative Overrides** |
---|------------------------|------------------------|
| **Chromium (all OS's)** | Not supported. | Supported via `tlsrestrict_chromium_tool`. |
| **CryptoAPI (Windows)** | Supported via ncdns's `certinject` feature. | Not supported. |
| **mozilla::pkix/NSS/sqlite (OS's with NSS `certutil`)** | Supported via ncdns's `tlsoverridefirefox` feature. | Supported via `tlsrestrict_nss_tool`. |
| **mozilla::pkix/NSS/sqlite (OS's without NSS `certutil`)** | Supported via ncdns's `tlsoverridefirefox` feature. | Not supported. |
| **mozilla::pkix/NSS/BDB** | Supported via ncdns's `tlsoverridefirefox` feature. | Not supported. |
| **NSS/sqlite (OS's with NSS `certutil`)** | Supported via ncdns's `certinject` feature. | Supported via `tlsrestrict_nss_tool`. |

## TLS Application Compatibility

|  | **Positive Overrides** | **Negative Overrides** |
---|------------------------|------------------------|
| **Chromium (GNU/Linux)**<br>[Instructions](chromium/gnu-linux/) | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. |
| **Chromium (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. |
| **Firefox (GNU/Linux)**<br>[Instructions](firefox/gnu-linux/) | Supported via mozilla::pkix/NSS/sqlite. | Supported via mozilla::pkix/NSS/sqlite. |
| **Firefox (Windows)**<br>[Instructions](firefox/windows/) | Supported via mozilla::pkix/NSS/sqlite. | Supported via mozilla::pkix/NSS/sqlite. |
| **Google Chrome (GNU/Linux)** | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. |
| **Google Chrome (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. |
| **Google Chrome Canary (GNU/Linux)** | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. |
| **Google Chrome Canary (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. |
| **Opera (GNU/Linux)** | Supported via NSS/sqlite. | Supported via Chromium.<br>Supported via NSS/sqlite. |
| **Opera (Windows)**<br>Automatically enabled by installer | Supported via CryptoAPI. | Supported via Chromium. |

