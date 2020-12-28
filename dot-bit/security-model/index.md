---
layout: page
title: Dot-Bit Security / Threat Model
redirect_from:
  - /dot-bit/security.html
---

{::options parse_block_html="true" /}

As with all security systems, Dot-Bit's security is dependent on a set of assumptions, outlined below.


### 51% Attacks

Like Bitcoin, Namecoin's main vulnerability is the 51% attack. If a malicious miner is able to obtain at least 51% of the mining power of the Namecoin network for an extended time, they will have the ability to reverse or block transactions. Given enough time in this position, the attacker would be able to permanently steal any Dot-Bit domain name by either forcing it to expire or by reversing its registration transactions.

How difficult is this attack to pull off? Namecoin uses merged mining (most Bitcoin miners are also mining Namecoin), so the attack is almost as difficult as attacking Bitcoin. As of this writing (March 2, 2014), the Namecoin network's hashrate is 16.334 Phash/s. If we assume that all of the current network is honest, then the attacker must purchase 16.334 Phash/s of hashpower. A 5 Ghash/s miner from Butterfly Labs costs $274 USD. So, purchasing the necessary equipment to perform a 51% attack would cost:

16.334 Phash/s * 1,000,000 Ghash/Phash * $274 / 5 Ghash = $895,103,200 USD

Performing the 51% attack would also require paying for electricity. Butterfly Labs' miners are rated for between 4 and 5 W/Ghash/s. Assuming the cheaper value of 4 W/Ghash/s, a 51% attack would require:

16.334 Phash/s * 1,000,000 Ghash/Phash * 4 W/Ghash/s * 1 MW / 1,000,000 W = 65.336 megawatts of sustained power.

According to Wikipedia, power in the U.S. (outside of Hawaii) costs 8 to 17 cents per kWH. Assuming 8, sustaining a 51% attack would cost:

65.336 MW * 1000 kW/MW * $0.08 / kWh = $5,226.88 per hour that the attack is sustained.

In other words, Namecoin is insecure against any attacker who has sufficient resources and motivation to expend a one-time investment of $895,103,200 USD plus a continuing expense of $5,226.88 USD per hour (or 45,787,468.80 USD/year). We won't speculate about which attackers have sufficient resources and motivation, but if your personal safety depends on Namecoin not being 51% attacked, you should consider your enemies' resources and motivation seriously.

It should be noted that the above numbers are very rough approximations. Some examples of factors excluded from the above:

* An attacker might find it easier to blackmail or legally pressure a large existing mining pool into participating in an attack.

* An attacker might design and build large quantities of ASIC mining hardware using their own facilities, which might be cheaper than buying commercial mining hardware, particularly at large volumes.

* Difficulty could rise (or fall) over time, which would affect the amount of necessary mining hardware to maintain the attack. As Namecoin becomes more widely adopted, demand will increase, which will increase price, which will increase mining hashrate.

* If news broke out of an attempted 51% attack on Namecoin, it is plausible that more Bitcoin miners would switch to merged mining as a way of expressing opposition to the attack on free speech. (Basically the Streisand Effect.)

Apart from that, an attack would be noticed if the chain is reorganised more than a few blocks or if names are prevented from updating for more than a few days. In that case, one could trivially implement an emergency hardfork or some other measures. Thus it is plausible that even if an attacker has enough hashing power, only names registered just a few blocks before or names expiring very soon would be affected (if any at all). Of course, the attack could be timed just right to steal a high-value name, for instance. But that would "only" give the attacker ways to redirect the site users for a few days until the emergency fix is in place. Also, it should be easy to avoid stealing a name like this by simply updating it a few weeks before it runs out (so that an attack will be noticed in time).

### Lite and Web Clients

Like Bitcoin, Namecoin's security depends on each user being in sole possession of their keys, and each user being able to verify the contents of the blockchain. Web clients (such as domain registrars) possess the keys to your domain, and therefore have the ability to compromise your domain if they are broken into, compelled by government order, offered money, decide they don't like you, or otherwise do not act in your interests. For this reason, we recommend running your own full client and registering names locally. Similarly, so-called "lite clients" as found in Bitcoin do not fully verify the blockchain, and therefore users of these clients in Namecoin may receive falsified name data. For this reason, we recommend running full clients and not lite clients.

There are proposals for lite clients which are secure (called "SPV+UTXO clients"). There are also proposals for automatic name renewal without having your full client open. These are NOT implemented yet.

### Loss of Private Keys

Like Bitcoin, Namecoin's security relies on users not losing their private keys, either via malware or accidental deletion. Namecoin-Qt includes wallet encryption; you should use it with a strong passphrase. Any use case which requires that a wallet be automatically decrypted should be handled using the "name importation" feature, so that if the keys to the decrypted wallet are stolen, the security implications are reduced to a temporary denial-of-service rather than a permanent theft of the domain. (DyName and NMControl both have support for this feature.) Take standard steps to secure your computer against malware which may try to steal your keys. Backup your wallet regularly to prevent loss of keys if your hard drive fails. There is a proposal to port Armory to Namecoin to enable cold storage, but this is not implemented yet.

### Blockchain Data and History Is Unencrypted

All names and their values are unencrypted in the Namecoin blockchain, which could impact privacy of name owners. Don't place data in the blockchain that you don't want the world to see, and remember that once it's in the blockchain, it can't be removed. There are proposals to encrypt blockchain data and remove expired name data, but they are not implemented yet.

### Namecoin Is Not Anonymous

Like Bitcoin, Namecoin's blockchain provides easily linkable pseudonymity, NOT anonymity. This means that name owners are easily linkable to their other Namecoin transactions. If one of your transactions is with an exchange who knows your real name or IP address, you should assume that the exchange knows the real name or IP address associated with all of your names. There are proposals for improving this, e.g. CoinJoin and Zerocoin, but they are not implemented yet. If any of your transactions were not made via Tor, you can further assume that an attacker knows the IP address associated with all of your Namecoin transactions.

While looking up data from the Namecoin blockchain is relatively private since you do not generate any network traffic indicating which names you are looking up, viewing Dot-Bit websites is not anonymous for the following reasons:

* Dot-Bit websites are not compatible with TorBrowser. Browsers other than TorBrowser will leak a lot of fingerprintable data, which will probably identify you specifically, even if your IP is masked by Tor.

* NMControl will generate traffic that isn't routed through Tor. There is a configuration option for NMControl which will disable retrieving data which is external to the blockchain, but this will break a lot of Dot-Bit websites.

* Even if TorBrowser support were added, it would be trivially easy for a website you visit to fingerprint you as one of the very few users capable of resolving Dot-Bit URL's. The ONLY way that this could be resolved would be for The Tor Project to include Namecoin in the Tor Browser Bundle by default, which is almost certainly not going to happen in the foreseeable future.

As a side note, be aware that downloading the Namecoin blockchain via Tor might put too much strain on the Tor network. SPV+UTXO will improve this situation when it is implemented.

