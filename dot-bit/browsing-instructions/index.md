---
layout: page
title: Browsing Dot-Bit Websites
redirect_from:
  - /dot-bit/browse.html
---

{::options parse_block_html="true" /}

### Browsing Dot-Bit Websites

So you're interested in browsing Dot-Bit websites? Excellent, we're here to help. To learn about browsing Dot-Bit websites, check out the information below.

### NMControl

NMControl allows viewing of Dot-Bit websites by acting as a local DNS server. NMControl's main advantages are compatibility with all Internet applications (not just a web browser), and caching of data for extra speed. NMControl requires Python, which makes it easy to install on Linux, but harder to install on Windows. It also requires a namecoind or namecoin-qt client (see below) to be running, and you must manually change DNS settings to use it.

NMControl does not require trusting any third-party; all data is verified against the Namecoin blockchain. NMControl therefore has good security. NMControl also supports the DANE protocol which allows DNSSEC-compliant applications to securely use HTTPS without trusting any CA's. NMControl has good, but not perfect, compatibility.

NMControl is primarily authored by khal and is an official Namecoin project.

To obtain NMControl, visit the [GitHub project.](https://github.com/namecoin/nmcontrol)

### Namecoin Client

While the Namecoin Client (namecoind or namecoin-qt) doesn't let you browse Dot-Bit websites by itself, it is necessary for several of the above programs.

Namecoin is primarily authored by vinced and khal and is an official Namecoin project.

To download the Namecoin Client, [visit Namecoin.org]({{site.baseurl}}) and [download the wallet.]({{site.baseurl}}download/)
