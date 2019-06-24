---
layout: page
title: Name Lookup Clients
---

{::options parse_block_html="true" /}

To look up Namecoin names (e.g. in conjunction with ncdns), you need a Namecoin name lookup client.

Your options are:

* **Namecoin Core**<br>
   Namecoin Core is the port of Bitcoin Core to Namecoin.  Namecoin Core is a fully validating node, is reproducibly built, and supports Tor.  You can download Namecoin Core at the [Downloads]({{site.baseurl}}download/) page.
* **ConsensusJ-Namecoin**<br>
   ConsensusJ-Namecoin is a lightweight SPV name lookup client, based on ConsensusJ, libdohj, and BitcoinJ (also used in the Schildbach Android Bitcoin Wallet).  ConsensusJ-Namecoin is written in a memory-safe language (Java), which is more secure than Namecoin Core, but it isn't a fully validating node, which is less secure than Namecoin Core.  ConsensusJ-Namecoin is not reproducibly built and does not support Tor.  [ConsensusJ-Namecoin documentation is here.]({{site.baseurl}}docs/bitcoinj-name-lookups/)
* **Electrum-NMC**<br>
   Electrum-NMC is the port of Electrum to Namecoin.  Electrum-NMC is written in a memory-safe language (Python), which is more secure than Namecoin Core, but it doesn't verify completeness of blocks, which is less secure than Namecoin Core and ConsensusJ-Namecoin.  Electrum-NMC is not reproducibly built.  Electrum-NMC supports Tor.  <!-- TODO: link to Electrum-NMC docs. -->

After you've installed a Namecoin name lookup client, if your goal is to access `.bit` domain names, your next step will be installing [ncdns]({{site.baseurl}}docs/ncdns/).
