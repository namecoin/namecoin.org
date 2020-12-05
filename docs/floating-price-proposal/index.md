---
layout: page
title: Floating Price Proposal
---

{::options parse_block_html="true" /}

Price is set based on a special data structure embedded by miners specifying their desired name fee in their mined blocks. The voting time window and the price consensus mechanism is open to debate, however, changing the implementation would require at most a soft-fork, allowing for changes informed by research. 

## Voting Incentives

Previous proposals for price discovery mechanisms have determined prices based on domain purchasers. These suffer from two problems: 

* Voting systems suffer from purchasers always selecting a lower lower price.
* Auction-style systems require a significant delay before the domain can be secured.

Miners primary income is through transaction fees and block rewards and miners do not collect name_new fees. This leads to their desirable voting incentives:

* Names with too high of a cost will reduce overall purchasing leading to fewer transactions fees and devalued block rewards.
* Names with too low of a cost devalues Namecoin's exchange rate due to squatting, which devalues collected tx fees and block rewards.

A specific price must be enforced across the network. Allowing miners to decide their own price would lead to registrants choosing the miner with the lowest name fee, rendering the system worthless. 

## Voting Mechanics

Miners can override the default configuration, similar to tx fees in Bitcoin and Namecoin. If the Namecoin dev team does something unpopular with tx fees, the community of miners can choose not to honor it, which acts as a check on the power of the Namecoin dev team. 

### Default Price

In it's simplest form, the default price would be a constant that is adjusted by the developers at release time. However, miners can override this constant with their own constant or even calculate their vote at every block using external factors. 

### Consensus Algorithm

Median pricing would be the voting mechanism most resistant to price manipulation and drama as minority miners voting for the maximum price would not directly alter the consensus price, as would be the case with a average pricing scheme. However, changing the mechanism would _not_ require a hard fork, enabling developers and researchers to introduce better voting mechanisms. 

### Voting Window

The current proposal calls for a window of 2048 votes. However, it is unclear what window size would provide the best balance of price stability and avoidance of temporary extremes for the price of a domain.

The need for clients to avoiding pricing based on orphaned blocks suggests a 10 block delay in the window. Clients purchasing new domains would need to include additional Namecoin equal to the amount of either the max rate increase or the maximum price as calculated by the block delay. 

### Caps

Limits on the maximum and minimum prices would defending against both a 51% attack and collusion by malicious miners. These can be hardcoded or set using a higher threshold vote. Hardcoded caps would require a soft-fork to update but provide security guarantees clost to that of hardcoded prices (see default values for non-DNS names). 

#### Thresholds

Historical pool mining ratios from Bitcoin suggest that a 75%-85% threshold would be enough to prevent the three largest pools from colluding to alter caps. The following are weekly cumulative networking hashing power starting in 2011-2-20 and ending in 2014-10-5. 


* Top 2 starting 2011: 0.6095
* Top 3 starting 2011: 0.7658

* Top 2 starting 2012: 0.5772
* Top 3 starting 2012: 0.7111

Prices are broken out by year because the data becomes more complete after 2012. Data was provided by from Organ of Corti, who runs [Neighborhood Pool Watch](http://organofcorti.blogspot.com/), the most complete record of pool mining ratios available. [Google Doc](https://docs.google.com/spreadsheets/d/19WUAJm3wGzIsCm1Bz2B-Xjg__E9WQy4dszW2e_LsRFU/edit?usp=sharing) can be used to explore data and export to CSV. 

#### Default Values

Non-DNS namespaces should have a lower cap values, given an exchange rate between $1-$100: 

* Minimum of .01 NMC: $0.01-$1.00
* Maximum of .1 NMC: $0.10-$10

##### .bit Domains

A lower cap between [$0.20 and $10](http://arstechnica.com/business/2009/08/escalating-penalties-bring-domain-tasting-to-a-crashing-halt/) should be enough to create negative ROI for the vast majority of domain name squatters. A minimum of .1 NMC would produce a minimum price of $.10-$10 with an NMC exchange rate between $1-$100.

A good default upper limit is much harder to set as a 10x increase in the exchange rate (which happens) will throw a reasonably priced $10 domain to $100, the ceiling of standard domain prices. A maximum of 5 NMC would produce a maximum price range of $5-$75 with an NMC exchange rate between $1-$15 (current and peak NMC pricing).

Developers always have the ability to post a new version to alter the default maximum price and developers could use the rate of name_new 'd/' operations or use live exchange rate posted to to the blockchain (see research section below) to adjust the max price downward if an attacker manages to hike prices too high.

You can see a visualization of these numbers [here](http://imgur.com/a/FyWEH#BcLTlcc) or fetch the Excel document from [here](https://mega.co.nz/#!1oBXXZhD!vTjIq9P7d39BKWmwEiMlXtCJ-WzS84X-whuSdqcxoqE) (NoScript users: the JS is used for a second layer of crypto, it's safe). 

## Features

### Soft-fork

This does not require a blockchain hardfork, now or ever. The enforcement is on the nameindex level, not the block validation level, similar to the temporary fix for the name-stealing exploit. The data structure embedding is already supported, since miners can embed arbitrary data in blocks. Furthermore, the fees can be dynamically adjusted (based on exchange rates or whatever real-life factors are deemed relevant) as the miners wish. 

### Per-Domain Pricing

The data structure could support varying fees for different names, in terms of namespace, name length, and/or value length. This is not a requirement of the proposal. 

### Renewal Fees

The data structure could support name fees on renewals. This makes things harder for squatters, since holding onto a name would have a recurring fee. This is __not__ a requirement of the proposal, but I think it could potentially be useful. (If we started requiring name fees on renewals, I'm not sure if that would require an initial hardfork ... my guess is that it could be done without a hardfork, but I don't know enough to be sure. 

## Research Questions

### Rate Limits

Both the voted price and the caps could be subject to a maximum rate of change.

It would also be possible to tie such rates to an inverse of the projected difficulty level, as a drop in difficulty would indicate a DOS or similar attack.

If miners begin using real-time pricing data to calculate their vote, determining the best limits will require research on the interaction between the voting window, the consensus algorithm, and market volatility. 

### Exchanges

Eventually, the voting mechanism could be informed by live exchange rates with a fall back to either a hardcoded value or the current network consensus price.

Using a peer-to-peer exchange would require including a client of the chosen P2P exchange. Namecoin volumes on Ripple and other P2P exchanges are fairly low, making them vulnerable to price manipulations. There does not seem to be a viable P2P exchange at this time.

Miners could use either a median or a trimmed mean of the posted VWAP from a set of exchanges. Simply polling APIs poses problems with rate limiting, DDoS attacks, and mining daemons being isolated for security reasons. These problems could be overcome, but a better solution would be to have exchanges post their data in a Namecoin record. Bot Kraken and Cryptonit have shown interest in posting __signed__ VWAP to a Namecoin record, possibly at 'exchange/name'.

A default set of exchanges could be chosen by the Namecoin developers based volume, stability, and security. The set could be hardcoded into the client or listed in a Namecoin record at 'exchanges' or 'exchange/exchanges'. The voting algorithm should also have inclusion/exclusion criteria so as to remove exchanges suffering from instability, such as the period before MTGox shut down. 

### Proof-of-Stake

It is unclear if a Proof-of-Stake system would be more stable/secure than a Proof-of-Work system. 

## See Also

* [Coinometrics](http://www.coinometrics.com/indices) rational for including exchanges in their Bitcoin price index (click on "methods and assumptions").
* [Pricing]({{site.baseurl}}docs/pricing) – Design notes on various pricing schemes.

