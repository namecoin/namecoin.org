---
layout: page
title: Registering Names Anonymously
---

{::options parse_block_html="true" /}

To register names anonymously, you need to hide information from several attackers:

* IP logging. Configure Namecoin Core or Electrum-NMC to use Tor.
* Blockchain graph analysis. If you're using Namecoin Core, use a different wallet for each name. If you're using Electrum-NMC, enable anonymous coin selection in settings (it's disabled by default).
* ElectrumX server operators. If you're using Namecoin Core, no action is necessary. If you're using Electrum-NMC, you should run your own ElectrumX server.
* Exchanges. Only purchase NMC from exchanges that allow access over Tor, do not collect personally identifiable information, and allow trading an anonymous cryptocurrency (e.g. Monero or Zcash) for NMC.
