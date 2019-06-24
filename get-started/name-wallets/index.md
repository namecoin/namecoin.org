---
layout: page
title: Name Wallets
---

{::options parse_block_html="true" /}

To register a Namecoin name, you need a Namecoin wallet that supports name operations.

Your options are:

* **Namecoin Core**<br>
   Namecoin Core is the port of Bitcoin Core to Namecoin.  Namecoin Core is a fully validating node, is reproducibly built, and supports Tor.  Namecoin Core includes both a Qt GUI and a command-line version.  You can download Namecoin Core at the [Downloads]({{site.baseurl}}download/) page.
* **Electrum-NMC**<br>
   Electrum-NMC is the port of Electrum to Namecoin.  Electrum-NMC is written in a memory-safe language (Python), which is more secure than Namecoin Core.  Electrum-NMC isn't a full node, which is less secure than Namecoin Core but allows it to synchronize faster and use less storage than Namecoin Core.  Electrum-NMC is not reproducibly built.  Electrum-NMC supports Tor.  Electrum-NMC includes both a PyQt GUI and a command-line version.  See the [Electrum-NMC documentation]({{site.baseurl}}docs/electrum-nmc/).

After you've installed a name wallet, you'll need to [obtain some NMC]({{site.baseurl}}get-started/get-namecoins) (the digital currency used by Namecoin).
