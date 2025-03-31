---
layout: page
title: FAQ
---

{::options parse_block_html="true" /}

* TOC
{:toc}

## General

### How does Namecoin work? 

The Namecoin software is used to register names and store associated values in the blockchain, a shared database distributed by a P2P network in a secure way. The software can then be used to query the database and retrieve data.

### Do I need to back up my wallet?

If you're using Namecoin to register or otherwise own names, or to transfer namecoins, then you do need to periodically back up your wallet.  Like Bitcoin, your wallet's keys are located in your `wallet.dat` file.  You should encrypt this file by going to `Settings` > `Encrypt Wallet` and making a backup thereafter. Close the Namecoin client and make a backup of your `wallet.dat` file in your Namecoin profile folder.  (On GNU/Linux, this is usually `~/.namecoin/`; on Windows, it is usually `C:\Users\<Your Username>\AppData\Roaming\Namecoin\`).  It is currently recommended to back up more often than every 100 transactions (including both currency and name transactions).

If you are only using Namecoin to look up names (e.g. browsing `.bit` domains), then you do not need to encrypt or back up your wallet.

### How much does it cost to register a domain (a.k.a. a name)? 

The cost includes a registration fee and a transaction fee. The registration fee is 0.01 NMC, and the transaction fee is determined dynamically by miners (just like in Bitcoin).  The registration fee might be made dynamic in the future, to improve economic incentives.

### How do I obtain namecoins? Can I mine them?

You can mine them alongside bitcoins or trade them, see [How to get Namecoins]({{ "/get-started/get-namecoins/" | relative_url }}).

### Who gets the registration fee?

The registration fees are destroyed by the transaction. Nobody gets them.

### Who gets the transaction fee?

The miners do, just like in Bitcoin. Paying higher fees improves the chance that the transaction will be processed quickly.  Like Bitcoin, the client will suggest a fee that is likely to be processed quickly.

### How long are names good for?

Registered names semi-expire if they are not renewed or updated for 31,968 blocks (approximately 222 days).  If your name is semi-expired, it will stop resolving for your users until you renew or update it, but you are still the sole owner of the name.  Semi-expired names that are not renewed or updated for an additional 4,032 blocks (approximately 28 days) will expire.  Expired names can be re-registered by anyone.  There are no registration fees for renewals or updates, but a transaction fee does apply.

### How do I browse a .bit domain?

See [Browsing .bit Websites]({{ "/dot-bit/browsing-instructions/" | relative_url }}).

If you have the [ZeroNet](https://zeronet.io/) software installed, you can visit ZeroNet-enabled .bit domains.

### How do I register and host a .bit domain?

See [Documentation for Name Owners]({{ "/docs/name-owners/" | relative_url }}).

### Do I need to use TLS with a .bit domain?

Yes, you need TLS (or some other transport security layer, e.g. SSH) in order to avoid vulnerability to eavesdropping and man-in-the-middle (MITM) attacks; Namecoin doesn't magically remove this requirement. The only protection that Namecoin grants you is that if you use TLS, and the certificate doesn't match the blockchain, you will get a certificate warning (even if a public CA is participating in the attack). If you do not use TLS, or bypass a certificate warning, Namecoin cannot protect you.

### Do I have to pay renewal fees? 

Other than the standard transaction fee, not at the moment.  This might change in the future, to improve economic incentives.

### What applications is Namecoin well-suited to?

Consider that Namecoin values are limited to 520 bytes, and that the block size limit is somewhere between 500 kB and 1 MB.  (It's lower than Bitcoin's.)  Given that blocks occur every 10 minutes on average (usually fluctuating between 1 and 60 minutes), and that names have to be updated or renewed at least every 31,967 blocks, try to figure out whether your application would comfortably fit into blocks if your application became widespread.  Domain names and identities are applications that are near the upper limit of the scale that Namecoin can handle.  For example, misusing the Namecoin blockchain as a decentralized file storage is not feasible.  There are several other decentralized systems that serve this purpose way more efficiently.  In many cases, if you want to store data that is larger than 520 bytes, or that is updated very often, you may prefer to only store a content hash or a public key in the blockchain, along with information on where to get the full data.  The full data can then be authenticated using Namecoin as a trust anchor without storing the entire data in Namecoin.  See our [Layer 2]({{ "docs/layer-2/" | relative_url }}) documentation for examples of such usage.

If you're developing an application, consider doing your development on the Namecoin Testnet.  This prevents your testing from bloating the production blockchain, and also allows you to test without spending real money on names.  If more than one implementation might have the same use case, consider writing a spec so that incompatible implementations of similar ideas don't become a problem.

### Do I need to download the entire Namecoin blockchain to use Namecoin?

No, but you will get better security if you choose to do so.  A *full node* such as Namecoin Core gives you maximum security by downloading the entire blockchain and validating that all transactions comply with the Namecoin consensus rules.  However, if you don't wish to download the entire blockchain, you can instead use a *lightweight SPV node* such as Electrum-NMC, which only downloads block headers (along with transactions that are relevant to you), which are much smaller than the entire blockchain.  Namecoin also makes possible some security models that don't directly correspond to Bitcoin.  For example, the ConsensusJ-Namecoin node downloads block headers like Electrum-NMC, but also downloads the entire blocks from the past year only (i.e. all blocks that contain unexpired name transactions), which provides a security level somewhere between Electrum-NMC and Namecoin Core.

### What is the smallest currency unit of Namecoin called?

The smallest currency unit of Namecoin is called the *swartz* (similar to the *satoshi* in Bitcoin).  It is named after Aaron Swartz, the activist who was murdered by the U.S. government, and who [proposed Nakanames](https://web.archive.org/web/20170424134548/http://www.aaronsw.com/weblog/squarezooko) (which, along with BitDNS, described the concept that was later implemented as Namecoin).

### What do Namecoin addresses look like?

Namecoin addresses follow the same format as Bitcoin addresses, but with different prefixes (to avoid ambiguity about whether an address is for Bitcoin or Namecoin):

* New-style Bech32 addresses begin with `nc1`.
* Old-style P2SH addresses begin with `6`.
* Even-older-style P2PKH addresses begin with `N` or `M`.

### What abbreviations are used for Namecoin?

* For application-agnostic software (e.g. wallets) that is forked from Bitcoin-specific software, `-NMC` is typically suffixed (e.g. Electrum-NMC).
* For application-specific software (e.g. DNS or TLS tools), `nc` is typically prefixed (e.g. ncdns).
* For the currency, either `NMC` or `ℕ` (Unicode "DOUBLE-STRUCK CAPITAL N" / `U+2115`) can be used as an abbreviation.

## Design 

### What is a namespace? 

Namespaces are name prefixes used by applications to distinguish between different type of names in Namecoin.  For example, `d/example` is the domain name `example.bit`, and `id/example` is an identity.  Namespaces help prevent multiple applications from accidentally conflicting.  Namecoin itself isn't aware of namespaces, and namespaces don't have any effect on validation rules; they are only used by higher-level applications that use Namecoin.

### Why is there a separate pre-registration step?

This is to prevent others from stealing your new name by registering it quickly themselves when they see your transaction. The name is not broadcasted during the pre-registration step, only a salted hash of it. There is a mandatory minimum delay of 12 blocks before you can broadcast your name with the registration step; this means that by the time other people know what name you're registering, they would have to reverse at least 12 blocks in order to steal the name.

### How are names represented? 

Names and values are attached to special coins with a value of 0.01 NMC. Updates are performed by creating a transaction with the name's previous coin as input. Think of it like a colored coin.  As far as Namecoin's consensus layer is concerned, names and their values are arbitrary binary blobs; any semantics assigned to those binary blobs (e.g. names being ASCII and values being JSON) are solely conventions used by higher-layer applications (e.g. ncdns).

### What if I spend that special coin by mistake? 

The code prevents those coins from being used for normal payments.

### What is a sidechain?

A *sidechain* is a blockchain whose consensus rules necessarily involve validating data from another blockchain (referred to as the *parent chain*).  The concept of sidechains was first proposed by Satoshi Nakamoto in 2010, and was first deployed in production by Namecoin in October 2011.  Subsequent examples of sidechains deployed in production include P2Pool (December 2011) and Liquid (October 2018).  Note that the existence of Turing-complete scripts (e.g. on Ethereum) that can validate blockchain data does **not** make Turing-complete blockchains sidechains, because the validation logic in such cases is part of the transaction rather than the consensus rules.

### What is a merge-mined sidechain?

A *merge-mined sidechain* is a sidechain in which the data being validated from the parent chain is the parent chain's proof of work.  Merge-mined sidechains (including Namecoin and P2Pool) were the first type of sidechain, and should not be confused with other types of sidechains such as *pegged sidechains* (including Liquid).

### Why does registering a name incur a fee?

Fees on name operations are a rate-limiting mechanism to disincentivize squatting.

### Why don't name registration fees go to miners?

If name registration fees went to miners, it would enable an attack in which miners could register names at a discount compared to typical users.  This would incentivize miners to sell discounted name registration services, which would enable miners to frontrun registrations that passed through such services, bypassing the frontrunning protections enabled by the [separate pre-registration step](#why-is-there-a-separate-pre-registration-step).

### Why do names have to be renewed regularly?

Two reasons:

1. It incentivizes owners of names who no longer intend to use them to either let them expire or sell them, thereby decreasing squatting.
2. It ensures that if a name owner loses their private keys, the name will eventually be returned to the pool of available names instead of permanently being stuck in limbo.  Names being stuck in limbo would both pollute the namespace and be a security risk (since it would not be possible to revoke TLS keys for such names).

### Does Namecoin support "layer 2" technologies?

Yes.  See our [Layer 2]({{ "docs/layer-2/" | relative_url }}) documentation.

### Why focus on getting browsers and OS's to support Namecoin instead of getting ISP's or public DNS resolvers (e.g. Google DNS) to do so?

The reasons mostly fall under three categories: security concerns, usability concerns, and political concerns.

Security concerns:

* ISP's would be in a position to censor names without easy detection.
* ISP's would be in a position to serve fraudulent PKI data (e.g. TLSA records), which would enable ISP's to easily wiretap users and infect users with malware.
* Either of the above security concerns would even endanger users who are running Namecoin locally, because it would make it much more difficult to detect misconfigured systems that are accidentally leaking Namecoin queries to the ISP.  See this [case study]({{ "/2018/09/24/how-centralized-inproxies-make-everyone-less-safe-case-study.html" | relative_url }}) for a practical example of how this can happen.

Usability concerns:

* Namecoin-to-DNS bridges rely on DNS security protocols such as DNSSEC, DNS over TLS, or DNSCrypt to prevent tampering.
* Many local network firewalls break DNSSEC.
* Many ISP's don't support DNS over TLS or DNSCrypt.
* Many OS's don't support DNSSEC, DNS over TLS, or DNSCrypt.
* These compatibility issues are straightforward to solve by adding locally installed software (e.g. Dnssec-Trigger), but are not otherwise easily solvable by non-technical users.
* If a non-technical user is installing DNS security software anyway, installing Namecoin as well doesn't add any particular extra difficulty.
* In the case of non-ISP public DNS resolvers, changing DNS settings manually in mainstream OS's is not something that non-technical users are usually comfortable doing, and is significantly more difficult to walk a user through than simply running a `.exe` file or installing a package via `apt-get`.

Political concerns:

* Namecoin's `.bit` TLD isn't part of the DNS; asking public DNS infrastructure to mirror Namecoin would probably be seen as hostile by IETF and ICANN.
* Namecoin is seeking to be added to IETF's special-use names registry; the precedent set by `.onion`'s inclusion is that public DNS infrastructure should always return `NXDOMAIN` for special-use names.
* While getting Namecoin bundled with a major browser or OS certainly is a major undertaking, it's not at all clear that getting Namecoin resolution included by a major ISP or public DNS resolver would be easier.  Statistically (though exceptions certainly exist), software vendors tend to be more interested in innovating via software, security, and cryptography, whereas ISP's tend to be more interested in "innovating" via antitrust violations and net neutrality violations.  We believe that software vendors are therefore more likely to be interested in Namecoin (though we don't claim that no ISP's exist who might be persuadable).

In addition, it's not clear that there would even be any significant benefit to counterbalance these concerns.  Namecoin intentionally makes different tradeoffs from the DNS.  For example, the DNS is much more scalable than Namecoin, can protect name owners from trivial deanonymization much better than Namecoin can, and doesn't rely on comparatively weak game-theoretic security properties as Namecoin does.  Namecoin has some benefits that counterbalance these weaknesses (e.g. the non-reliance on trusted third parties), but serving Namecoin data from public DNS infrastructure would provide the **union** of Namecoin's and the DNS's weaknesses, while providing the **intersection** of Namecoin's and the DNS's strengths.  Users who require a DNS-like naming system that works without any software installation are likely to be better off simply using the DNS.

### Why focus on browser add-ons and OS packages instead of native browser and OS support?

Because browser add-ons and OS packages are the standard method by which browser and OS vendors evaluate features for future inclusion.  In our discussions with browser vendors and OS vendors (even the ones who are enthusiastic about bundling Namecoin by default), one of the first things they ask for as a prerequisite to inclusion by default is a browser add-on or an OS package.

### Why focus on getting existing browsers and OS's to support Namecoin instead of forking those browsers and OS's?

Maintaining a fork of a web browser or OS is a substantial time investment, and attempting it without the necessary resources would inevitably result in delayed security updates, which would be unethical to our users.  Examples of browser and OS forks that have suffered from delayed security updates include IceCat and Trisquel.  One of the very few cases where a web browser fork has not resulted in a security disaster is Tor Browser, which has the following advantages:

1. The Tor Project employs a dedicated team of full-time browser engineers who merge security fixes from Firefox.
2. Tor Browser is based on the ESR variant of Firefox, which results in significantly less code churn from upstream.
3. The Tor Browser developers are actively getting their patches against Firefox merged upstream by Mozilla.

These advantages do not obviously apply to us, so Tor Browser's relative success would not obviously apply to us either.

### Why does Namecoin use atomic name trades for NMC rather than BTC or some other coin?

* Namecoin atomic name trades are non-interactive, which improves UX; cross-chain trades require interactivity.
* Namecoin atomic name trades are as fast as any other transaction; cross-chain trades require substantial latency while the multiple steps of the trade smart contract confirm.
* Namecoin atomic name trades are Layer 2 except for the final step that finalizes the trade, which reduces fees and blockchain bloat; cross-chain trades are on-chain.
* Namecoin atomic name trades are *cryptographically* atomic; a successful double-spend attack cannot break the atomic property.  Cross-chain trades are only *economically* atomic; an attacker who can successfully double-spend can break the atomic property.
* Namecoin atomic name trades have built-in support for auctions (non-interactively, on Layer 2); cross-chain trades do not have any mechanism for this.

### Is it possible to hide the usage of atomic name trades?  Is that desirable?

From a fundamentalist privacy perspective, making all transactions look alike is desirable, which would seem to imply that atomic name trades should look like any other name update.  However, this is not really an accurate view of how Namecoin is used.  Namecoin names are typically used to establish a trust relationship, and in a trust relationship, the trusting party typically wants to know about events happening to the trusted party that may impact that trust relationship.  For example, if `wikileaks.bit` belongs to WikiLeaks, but that domain then gets put up for auction, whistleblowers may consider this information important when deciding whether to leak documents to the submission system hosted at that domain.  Thus, users who resolve a name probably do not want trades to look the same as other updates.

Furthermore, there are two distinct classes of name owners involved: name owners who are doing a trade, and name owners who are doing a non-trade update.  Atomic name trades use a `SIGHASH` smart contract, and removing that smart contract component from a trade transaction doesn't conceal it, it just makes the transaction invalid.  So name owners who are doing a trade cannot make their transactions look like non-trade updates.  It *is* possible for a name owner doing a non-trade update to make a `SIGHASH` smart contract with themself, thus making their non-trade update look like a trade.  However, this will typically incur higher fees, and will also incur suspicion among their users (see above paragraph), so there is no incentive for them to do this.

Theoretically, Namecoin could softfork in order to force name owners to make their non-trade updates look like trades, but this would sacrifice the integrity of Namecoin's trust relationship use case in favor of the dubious privacy needs of name owners who are covertly selling the trust relationships they've accumulated.  We do not think this would be a consensus change that would be in the public interest; thus, we have no intent to pursue such a softfork.

### Is Namecoin's support of atomic name trades a feature primarily aimed at squatters?

Short answer: No.  The Namecoin developers are strongly against trademark infringement, and we do not endorse the behavior of users who squat on domains, either in Namecoin or the DNS.

Longer answer from a high-level point of view:

In a naming system, the ability to transfer ownership of a name to a new keypair has significant security benefits.  For example, it allows a corporation to replace the employee(s) who control a name, and it also allows secure recovery of a name whose keys are believed to have been compromised but which has not yet been stolen.  As a result, Namecoin supports the ability to transfer names to a new keypair.  In a naming system that doesn't enforce legal identity verification, it is not possible to automatically disambiguate a transfer between two keypairs that belong to the same corporation or person from a transfer between two different people.  As a result, Namecoin supports the ability to transfer names to a different corporation or person.  Since it is always possible for two parties to coordinate a payment out-of-band, it is not possible for a cryptographic naming system to prevent name sales without preventing name donations.  As a result, Namecoin supports the ability to sell a name.  Given that Namecoin supports the ability to sell a name, there isn't really much benefit to not supporting atomic name sales: the only people who would benefit from not supporting atomic name sales are scammers.  There are plenty of legitimate reasons why someone might want to sell a name (which we assume is the main reason why selling DNS names isn't banned, even though in the DNS it's usually quite easy on a technical level to seize domain names that are listed for sale).  And we don't think that the legitimate users of that functionality deserve to be unnecessarily exposed to counterparty risk.

Longer answer from a low-level point of view:

Namecoin is a fork of Bitcoin, and therefore Namecoin (like Bitcoin) supports a wide variety of smart contract schemes, including the ability for a transaction to have an arbitrary number of outputs (thereby making multiple payments atomically).  Because Namecoin represents names as transaction outputs, it is naturally possible to atomically transfer a name in combination with a currency payment.  This isn't a feature that Namecoin was specifically designed to support, it's simply a feature that naturally exists, which would have required extra effort to not support.  Technically, it would be possible to softfork Namecoin to ban name outputs from coexisting in a transaction with currency outputs, but in practice this would have detrimental effects unrelated to atomic name trades, because it would also ban change outputs from single-party name transactions.  There *is* a restriction in Namecoin's consensus rules that prevents two name outputs from being created atomically.  As far as we're aware, there is no documented reason for this rule (none of us were around to ask when the rule was first created, and Vince isn't around for us to ask anymore), and this rule also has harmful side effects that are unrelated to atomic name trades, e.g. it prevents CoinJoin-style constructions for name transactions.  Because CoinJoin is useful for both scalability and privacy, we would prefer that this rule be removed, and it is possible that a future consensus fork will do so.

### Why doesn't Namecoin implement a backdoor?

A fundamental law of nature is that humans behave nondeterministically.  This nondeterministic behavior also applies to groups of humans, and to systems operated by humans or groups of humans.  The amount of nondeterminism also increases as the time scale for which predictions are being made increases.  For example, the U.S. Constitution, when read literally, states that mass surveillance and torture are off limits.  Unfortunately, the U.S. government is operated by humans, and as a result, these clauses of the U.S. Constitution are not executed deterministically.

One of the major appeals of replacing humans with cryptography is that cryptography behaves much more deterministically than humans.  As a result, you can predict with much higher certainty how a cryptosystem will behave in the future than you can do for a human-operated system.  This is why the proof of freshness in the Bitcoin genesis block references bank bailouts: financial regulators are operated by humans, and therefore behave nondeterministically; a massive bank bailout due to short-sighted political pressures is an example of nondeterministic behavior that is against the public interest and which Bitcoin is designed to prevent via deterministic behavior.

There are certainly short-term benefits to operating a backdoor for a naming system, e.g. prevention of phishing/malware sites or reversal of name thefts caused by private key compromise.  Such a backdoor might be controlled by a single key, a multisig contract, or some type of more complex "governance" smart contract.  However, any such scheme would inevitably harm the security and usefulness of Namecoin, because any such scheme would introduce nondeterministic behavior, thus returning us to the problem that cryptosystems are supposed to solve.

Free speech and private communication are fundamental human rights that must not be subject to interference by any 3rd party, even if everyone else in the world wants those rights to be violated.  An ideal cryptosystem would enforce this deterministically.  Unfortunately, the laws of nature impose constraints on how close a real-world system can get to this ideal (in particular, blockchains' reliance on economic incentives limits their ability to achieve this), but this is not an excuse to impose additional nondeterministic behavior that can violate those rights.  Any type of "governance" system that can execute name seizures, regardless of whether it's a single party, a multisig contract, or some type of more complex smart contract, is therefore unacceptable.

(This section was inspired by Greg Maxwell's philosophical writings.)

### Does Namecoin have any browser add-ons?

Yes; we have a PKCS#11 module (ncp11) for TLS certificate validation, and we have a WebExtension (DNSSEC-HSTS) for protecting against SSLStrip attacks.  However, there is no browser add-on for resolving `.bit` domains to IP addresses.

### Why doesn't Namecoin use a WebExtension to resolve `.bit` domains to IP addresses?

There is no WebExtensions API for intercepting DNS lookups; thus such a WebExtension is not possible.  It *is* possible to abuse the HTTP proxy API to simulate DNS interception (and there are various 3rd-party WebExtensions that purport to do this for Namecoin).  Unfortunately, this form of API abuse is fundamentally incompatible with HTTPS.  Since such WebExtensions cannot work with HTTPS and are therefore inherently insecure, we recommend avoiding such WebExtensions.  It also is possible to use the WebRequest API to redirect `.bit` URL's to the associated IP address.  Unfortunately, this will not work with properly configured servers, because both the HTTP `Host` header and the TLS SNI header won't match; thus we recommend against this as well.

### Why doesn't Namecoin use "proof of stake"?

We defer to the analysis of Bitcoin developer Andrew Poelstra about the [security problems with PoS](https://download.wpsoftware.net/bitcoin/pos.pdf).  For a more accessible summary, Namecoin developer [Yanmaani's article on PoS](https://yanmaani.github.io/proof-of-stake-is-a-scam-and-the-people-promoting-it-are-scammers/) may be of interest.

### Why doesn't Namecoin use a DHT?

We defer to the analysis of Bitcoin developers [Peter Todd](https://web.archive.org/web/20170319062730/https://bitcointalk.org/index.php?topic=395761.msg5970778;topicseen#msg5970778) and [Greg Maxwell](https://web.archive.org/web/20170319064612/https://bitcointalk.org/index.php?topic=662734.msg7521013;topicseen#msg7521013) about the security problems with DHT’s.

### Why isn't Namecoin implemented as an Ethereum contract?

* Ethereum did not exist when Vincent Durham founded Namecoin.
* Ethereum routinely performs contentious hardforks in order to reverse transactions that factions of the community dislikes (particularly when the Ethereum developers have money at stake, e.g. the [bailout of TheDAO](https://www.theregister.com/2016/06/17/digital_currency_ethereum/)).
* Ethereum has [no production-ready SPV client](https://ethereum.org/en/developers/docs/nodes-and-clients/light-clients/#current-state-of-development).
* Running an Ethereum full node has [extremely high requirements](https://twitter.com/ercwl/status/1159940020331040770).
    > syncing less than *two weeks of August 2019* in Ethereum takes longer than the entire 10 years of bitcoin (which took 15 hours)
    
    > doing a full Ethereum sync on a HDD is downright infeasible
* Ethereum [does not follow best practices for consensus safety](https://petertodd.org/2016/multiple-implementations-consensus-systems): they use multiple consensus implementations, which is known to be unsafe (the field of computer science does not know how to do this safely), and has already led to critical security vulnerabilities (consensus failures) in the wild.
    > I don’t believe a second, compatible implementation of Bitcoin will ever be a good idea. So much of the design depends on all nodes getting exactly identical results in lockstep that a second implementation would be a menace to the network.
    > 
    > ~Satoshi Nakamoto
* Ethereum uses "proof of stake" as a substitute for a dynamic-membership multiparty signature scheme; see [Why doesn't Namecoin use "proof of stake"?](#why-doesnt-namecoin-use-proof-of-stake)

### Why does Namecoin use the `.bit` Special-Use Top-Level Domain (suTLD) instead of overlaying the root zone?

Overlaying the root zone would produce a collision risk between domains created in Namecoin and names created in the DNS, and this collision risk would be unfeasible to contain or manage.  For example, if Namecoin allowed registration of TLD's, and a user registered the `.foo` TLD in Namecoin, ICANN would be unable to issue `.foo` as a gTLD without producing a collision in which different users see different valid data for `.foo` depending on whether they have Namecoin installed.  This collision risk would be viewed by IETF and ICANN as a threat to security and stability of the namespace (and we would agree with their assessment).  In contrast, containing Namecoin to the `.bit` suTLD makes it straightforward to easily determine whether a given domain name belongs to Namecoin or the DNS, and avoids the collision risk.  This improves security and stability of the namespace, and avoids unnecessary antagonization of IETF and ICANN.

The above collision issue is **not hypothetical**; it has [already happened](https://web.archive.org/web/20220112131103/https://github.com/handshake-org/hs-names/issues/6) to Handshake with the `.music` TLD.  The accepted solution, by Handshake developer Matthew Zipkin, was to [encourage](https://web.archive.org/web/20220112131103/https://github.com/handshake-org/hs-names/issues/6#issuecomment-626226270) individual users to choose whether the ICANN-issued TLD or the Handshake-issued TLD should be accepted at the policy layer:

> The easiest way to deal with this is to add rules in the HNS resolver, which lives in the application layer. Users can opt-in to ignore certain names from the blockchain and resolve them to the ICANN root zone instead, which is the same mechanism used when a name not found on the HNS chain.
> 
> This will not require a hard fork or a soft fork as far as the blockchain is concerned, it will only make the owner of the HNS name `music.` perhaps a little disappointed.
> 
> If the HNS `music` wins the race for better content than the ICANN `music`, Handshake users may decide individually to ignore the new ICANN TLD and proceed with the "vision" of Handshake.

When used in this manner, Handshake **ceases to be a global naming system**, which is one of the core requirements of solving Zooko's Triangle.  Another proposed solution, by Handshake co-founder Andrew "rasengan" Lee, was to [extort](https://web.archive.org/web/20220112131103/https://github.com/handshake-org/hs-names/issues/6#issuecomment-629676746) ICANN into buying all new gTLD's on Handshake, under threat of causing collisions:

> I hope ICANN will consider its impacts on community consensus based systems like Handshake and /etc/hosts before launching any new gTLDs in the future. Ideally, if ICANN purchases the name on Handshake before announcing any name, they can avoid breaking community projects in the future.

Andrew "rasengan" Lee also appears to have [libeled](https://web.archive.org/web/20220112131103/https://github.com/handshake-org/hs-names/issues/6#issuecomment-632187910) the ICANN-issued .MUSIC registry, falsely claiming that .MUSIC's "built-in HTTPS" has no advantages over Let's Encrypt (as far as we can tell, that feature is clearly marketingspeak for [TLD-level membership](https://hstspreload.org/#tld) in the HSTS Preload List, which Let's Encrypt obviously doesn't provide):

> What does built in security mean? Aren't you just going to charge to issue SSL certificates **just like Let's Encrypt does for free**? Can you guarantee another SSL provider won't issue another certificate for the same name?

Additionally, we don't see any substantive benefit to operating the root zone via a blockchain.  A major benefit of the suTLD approach is that many different naming systems can co-exist, each in their own suTLD.  These naming systems can have radically different security models, e.g. you can have public key naming systems like `.onion` and `.b32.i2p`, petname systems like `.i2p` and `.gnu`, and blockchain naming systems like `.bit` and `.eth`, all of which avoid interfering with each other (and with the DNS).  In contrast, trying to manage the root zone with a blockchain would have the effect that all other naming systems would have an implicit dependency on that root zone blockchain.  If the root zone blockchain gets compromised, every TLD under it also gets compromised.  History has shown that performing suTLD registration on an ad-hoc, informal, human-based basis works fine in practice; no one is disputing whether e.g. `.eth` belongs to Ethereum Name Service or some other special-use naming system.  Without the need for deterministic dispute resolution, there is not much for a blockchain to do here.

Part of the apparent motivation to overlay the root zone seems to be that ICANN is viewed as a centralizing force and/or a trusted third party. However, in practice, the vast majority of abusive behavior in the DNS ecosystem is coming from registries and registrars, not from ICANN. Replacing DNS registries and registrars yields substantially more practical benefit than attempting to replace ICANN, and DNS registries and registrars can be replaced without touching the root namespace. suTLD's like Namecoin's `.bit` and Tor's `.onion` are not subject to interference by the ICANN root key, so the suTLD approach does not involve ICANN acting as a centralizing force or trusted third party.

If overlaying the root zone is done by using the root zone as a public suffix (i.e. users register arbitrary TLD's instead of arbitrary 2LD's), additional breakage is likely because many browsers (e.g. Tor Browser, Firefox, Brave, and Safari) isolate state by using the eTLD+1 as a key, and those browsers do not recognize the root zone as an eTLD.  For example, `https://www.wikileaks.bit/` and `https://donate.wikileaks.bit/` will share browser state as expected, whereas `https://www.wikileaks/` and `https://donate.wikileaks/` will be unexpectedly isolated from each other.  This behavior is counterintuitive, surprising, and likely to break a variety of software in ways that may or may not be subtle.

Using the root zone as a public suffix also opens up social engineering attacks based on the fact that users are accustomed to registering 2LD's, not TLD's, i.e. scammers register a TLD and try to trick users into using that TLD as a public suffix.  This results in users thinking that they are using a trustless decentralized naming system, when in reality they are using the scammer as a trusted third party.  These kinds of social engineering attacks have been observed in the wild on Handshake; [Sci-Hub was a notable victim](https://web.archive.org/web/20210310121355/https://www.coindesk.com/sci-hub-leaves-handshake-blockchain/).  Handshake investor and developer Andrew "rasengan" Lee actively participated in this scam by [running public relations operations](https://web.archive.org/web/20210116001302/https://news.ycombinator.com/item?id=25747284) for it.

Finally, Namecoin is designed to work as a TLS PKI, and most TLS implementations support API's (e.g. name constraints) that allow sandboxing the Namecoin root CA to only be able to issue certificates for Namecoin's suTLD.  This is an extremely important tool for limiting the attack surface of Namecoin, since it means that an attack on Namecoin cannot easily escalate to an attack on non-Namecoin domains.  This is applicable regardless of whether Namecoin TLS is implemented via Encaya or an intercepting proxy.  In addition, these API's allow sandboxing the public TLS root CA's so that they cannot issue certificates for Namecoin's suTLD; this makes it feasible to avoid relying on an intercepting proxy.  These API's are designed to be applied to a specific TLD that is known at install-time; Namecoin meets this requirement by using a specific suTLD.  Overlaying the root zone would prevent these API's from being used effectively.

### Why doesn't Namecoin recommend a TLS intercepting proxy?

Allow us to defer to [Filippo Valsorda](https://blog.filippo.io/komodia-superfish-ssl-validation-is-broken/) (Cryptogopher who maintains the TLS standard library for Go):

> don't make intercepting proxies. They are impossible to write correctly, and by their very nature lower the security of the whole Internet.

While Komodia/Superfish is probably the most well-known and egregious example of how intercepting proxies can damage security compared to using a standard web browser TLS client stack, here are some additional practical examples of decreased security in Let's DANE specifically:

* Mainstream browsers [disabled SHA-1 certificate signatures](https://web.archive.org/web/20240414173057/https://blog.mozilla.org/security/2016/10/18/phasing-out-sha-1-on-the-public-web/) in 2017.  Go `crypto/x509` [did not do this until 2022](https://web.archive.org/web/20240122001422/https://tip.golang.org/doc/go1.18#sha1).  (Granted, SHA-1 is probably safe for self-signed certificates, so Let's DANE may be unaffected by this until they implement DANE-TA.)
* Mainstream browsers [disabled TLS 1.0 and TLS 1.1](https://blog.mozilla.org/security/2018/10/15/removing-old-versions-of-tls/) in 2020.  Go `crypto/tls` [did not do this until 2022](https://web.archive.org/web/20240122001422/https://tip.golang.org/doc/go1.18#tls10).  Go did allow applications to disable old TLS versions, but Let's DANE [did not do this](https://github.com/buffrr/letsdane/commit/b6bcb8d1eee87343bca96acdca39ac1ac72220f7) until 2021.
* Mainstream browsers [disabled 3DES](https://blog.mozilla.org/security/2021/10/05/securing-connections-disabling-3des-in-firefox-93/) in 2021.  Go `crypto/tls` [only plans to do this in 2024](https://github.com/golang/go/issues/66214). Go allows applications to disable 3DES, but Let's DANE [did not do this until 2022](https://github.com/buffrr/letsdane/pull/21).
* Let's DANE [permits poor key hygiene](https://github.com/buffrr/letsdane/blob/43bcbd9b70e7ebf9cb78ff240b3baaa379aa0d20/tls.go#L33-L39) by not checking the `NotBefore` and `NotAfter` fields.  They are technically correct that RFC 7671 allows them to ignore poor key hygiene, but the RFC is wrong in terms of security (see [this NCC Group](https://media.ccc.de/v/camp2015-6779-bugged_files) talk that advises secure application developers to be prepared to "light the RFC on fire"), and no mainstream browser will let you do this.

The above list is not intended to be exhaustive; it is likely that there are others.  Writing TLS clients is hard, and in general only the major browser vendors do an acceptable job at it -- hence Filippo's advice.

Additionally, TLS intercepting proxies interfere with TLS CCA (client certificate authentication). Given that TLS CCA is substantially preferable to password authentication, we don't want to harm that use case.

That said, nothing in Namecoin prevents you from using a TLS intercepting proxy such as Let's DANE -- we simply advise against it.

### Why isn't ncdns part of Namecoin Core?  What is the distinction between the two?

This is an example of [layered design](https://en.wikipedia.org/wiki/Abstraction_layer).  Namecoin Core is responsible for consensus-layer and wallet-layer functionality (i.e. the kinds of things that Bitcoin Core does), while application-layer functionality like interoperability with DNS is handled by ncdns.  There are a few reasons for this:

* Namecoin Core is necessarily a fork of Bitcoin Core, so it must be written in non-memory-safe C++; layering allows ncdns to be written in memory-safe Go.
* Layering allows either layer to be swapped out without affecting the other layer.  For example, Namecoin Core can be swapped out for Electrum-NMC without affecting ncdns.  In the past, ncdns was swapped in as a replacement for NMControl without affecting Namecoin Core.
* Layering allows additional non-DNS-related applications (e.g. identities) to be added without affecting Namecoin Core or modifying ncdns.
* Layering allows each layer to be sandboxed individually, e.g. ncdns can be prohibited from sending Internet traffic or touching the user's wallet.

Additional layers exist on top of ncdns for the same reasons, e.g. Encaya (for TLS AIA interoperability) and ncp11 (for TLS PKCS#11 interoperability).

Layering is a common practice in computer science.  While layering does complicate the procedure of manually installing Namecoin (since more than one application must be installed), this complexity is typically hidden from the user via modern package management such as `apt` (on GNU/Linux) or NSIS (on Windows).

## Comparison of Namecoin to other projects

### What is the relationship of Namecoin to Bitcoin?

The Namecoin codebase consists of the Bitcoin codebase with relatively minor changes (~400 lines) and additional functionality built on top on it. The mining procedure is identical but the block chain is separate, thus creating Namecoin. This approach was taken because Bitcoin developers wanted to focus almost exclusively on making Bitcoin a viable *currency* while the Namecoin developers were interested in building a *naming system*.  Because of the different intended use cases between the two projects, consensus and protocol rules might make sense in one but not the other.  Examples of places where it could make sense to have different protocol or consensus rules:

* Namecoin's consensus rules need to enforce uniqueness of names.  While it is possible to store data in Bitcoin (e.g. key/value pairs in `OP_RETURN` outputs), uniqueness is not enforced by Bitcoin.  It would be theoretically possible to build a layer on top of Bitcoin that discards `OP_RETURN` outputs that don't respect uniqueness (e.g. a name operation that steals someone else's name), but any such layer would not be enforced by miners.  If transaction validity rules are not enforced by miners, then they are not backed by [PoW](https://bitcoin.org/en/glossary/proof-of-work), which means that [SPV-based lightweight clients](https://bitcoin.org/en/glossary/simplified-payment-verification) will fail to enforce those validity rules.
* Since consumers expect different fees for financial transactions versus name registrations, and since the volume of financial transactions worldwide versus name registrations worldwide are different, Namecoin and Bitcoin might have different optimal block sizes.
* In a currency, inflation attacks are fatal, while in a naming system, they simply amount to a spamming or squatting attack: bad, but not anywhere near fatal.  Therefore, decisions about features such as zk-SNARK-based anonymity (which introduce a risk of inflation attacks) might come to different conclusions between Namecoin and Bitcoin.
* Some script features that make sense for Namecoin might not make sense for Bitcoin, e.g. allowing a scriptPubKey to restrict the scriptPubKeys of any spending transaction.  In a naming system, features like this could make renewing and updating names more convenient and secure, but in a currency, they could be harmful to fungibility.
* Coinbase commitments to the name database could be enforced by Namecoin consensus rules, allowing SPV proofs of a name's nonexistence to be created.

In general, the Namecoin developers attempt to minimize our patchset against Bitcoin.  If a feature makes sense to have in Bitcoin, we try to get it into Bitcoin and then merge it to Namecoin; Namecoin usually only introduces differences from Bitcoin in cases where the proposed change wouldn't make sense for Bitcoin due to the differing use cases.  Although it is theoretically possible to use Namecoin as a general-purpose currency, the Namecoin developers do not encourage this use case.  There are lots of cryptocurrency projects out there that are specifically designed for such usage (e.g. Bitcoin); if you're looking for a currency, you should use one of those projects.

### What is the difference between Namecoin and Bitcoin?

* There are additional commands for special transactions containing *names* and *data* (key/value pairs).
* The most important commands are: Pre-Registration (internally called `name_new`), Registration (internally called `name_firstupdate`), and Update (internally called `name_update`).
* The coins used to pay for a Pre-Registration operation are destroyed, i.e. every new name reduces the finally usable maximum of 21 million NMC by 0.01 NMC.
* Registration and Update contain a pair of name/value, which [require periodic renewal](#how-long-are-names-good-for).
* The `d/` prefix is used to register a domain name, without the .bit TLD: `{     "name" : "d/namecoin",     "value" : "what you want",     "expires_in" : 10227 }`
* The `id/` prefix is used to register an identity, see [NameID](https://nameid.org/).
* Energy-efficient: if you are already mining bitcoins, you can merge-mine namecoins at no extra cost for hardware and electricity.  For a list of current Namecoin mining pools, see [our Metrics data]({{ site.metrics_url }}/namecoin/period-timestamps-14-days/pool/charts/latest.txt).

### What are the similarities between Namecoin and Bitcoin?

* 21 million coins total, minus the lost coins.
* 50 coins are generated each block at the beginning; the reward halves each 210,000 blocks (around 4 years).
* Security: a large fraction of Bitcoin miners also mine Namecoin, giving it a staggering difficulty.
* Pseudonymous founder: Vince, like Satoshi, never revealed his real-world identity and disappeared around the same time, leaving Namecoin project wild in the open, to flourish only thanks to the help of enthusiasts in the FLOSS community.
* Free / libre / open-source platform: Anyone can improve the code and report issues on [GitHub](https://github.com/namecoin/) and even use it on other projects.

### Does Namecoin mandate usage of Bitcoin as a parent chain?

No.  Namecoin's merged mining can use *any* Hashcash-SHA-256d blockchain as a parent chain.  Bitcoin is the most commonly used such parent chain, but others (such as BCH) are sometimes used as parent chains as well.  Note that this implies that Namecoin's hashrate and difficulty can theoretically be higher than those of Bitcoin.  (In fact, Namecoin's 24-hour hashrate occasionally does exceed that of Bitcoin; for a historical list of such events, see [our Metrics data]({{ site.metrics_url }}/namecoin/period-timestamps-1-days/pool/charts/gt_parent.txt).)

### Does Namecoin influence Bitcoin's hashrate?

The existence of Namecoin as a merge-mined sidechain acts as a de facto increase of the Bitcoin block reward.  This incentivizes mining Bitcoin at a higher difficulty than would otherwise be profitable.  As a result, Namecoin indirectly increases Bitcoin's hashrate.  Namecoin and Bitcoin hashrate are thus in a [mutualist](https://en.wikipedia.org/wiki/Mutualism_(biology)) relationship.  That said, since the real-world value of Namecoin's block reward is much less than that of Bitcoin's, the extent to which Namecoin increases Bitcoin's hashrate is relatively small.  Specifically, as of 2022<!-- per BitInfoCharts -->, Bitcoin's block reward was $47,299,467.42 USD/day, while Namecoin's block reward was $1,429.55 USD/day.  Thus, Namecoin is responsible for a ~0.003% increase in Bitcoin hashrate.  Namecoin's contribution might increase in the future as a result of increased adoption causing the exchange rate or transaction fees to increase.  For example, in a hypothetical distant future in which all 368 million DNS second-level domains<!-- https://siteefy.com/how-many-domains-are-there/ --> moved to Namecoin and paid $10 USD/year in renewal fees, Namecoin's block reward would be $10,075,291 USD/day, which would result in Namecoin contributing a 21.3% boost to Bitcoin hashrate.

### How does Namecoin compare to Tor Onion Services?

The Tor Project's Onion Services (which have a `.onion` top-level domain) use domains which are a public key hash.  This means that their domain names are not human-meaningful, whereas Namecoin domain names are human-meaningful.  Namecoin's `.bit` domains can point to `.onion` domains, providing a human-meaningful naming layer on top of Tor Onion Services.  Blockchain-based systems like Namecoin are, at this time, unable to match the cryptographic security guarantees (against impersonation or deanonymization attacks) that systems like Onion Service names provide when used directly, but Namecoin's human-meaningful names do make Namecoin more resistant than Onion Service names to some classes of attacks that exploit human psychology rather than breaking cryptography.  For example, humans have trouble remembering a public key hash or recognizing a public key hash as the correct one; this is much better with meaningful names such as Namecoin names (or DNS names).  Attackers can exploit this property of Onion Service names in order to trick users into visiting the incorrect website.  We believe that both systems serve a useful purpose, and determining whether direct usage of Onion Service names or Namecoin naming for Onion Services is more secure for a given user requires consideration of that user's threat model.

### How does Namecoin compare to Let's Encrypt?

Let's Encrypt constitutes a trusted 3rd party, i.e. the Let's Encrypt certificate authority can issue fraudulent certificates to 3rd parties for your domain without your consent.  In contrast, using TLS with Namecoin (assuming that negative certificate overrides are supported by your TLS client) does not involve a trusted 3rd party; only certificates that chain to a `TLSA` record in your name's value will be accepted.

Let's Encrypt also has the ability to censor your ability to receive TLS certificates.  Let's Encrypt routinely uses this capacity to engage in geopolitical censorship.  For example, in response to a [support request pertaining to an error "Policy forbids issuing for name"](https://community.letsencrypt.org/t/error-policy-forbids-issuing-for-name/52233/3), Josh Aas (Executive Director of ISRG, the corporation that operates Let's Encrypt) stated on February 6, 2018:

> The People’s Republic of Donetsk is on the U.S. Treasury Department Specially Designated Nationals list. The website you are inquiring about appears to be a part of, or a state enterprise of, the People’s Republic of Donetsk, thus we cannot provide service according to U.S. law.

Let's Encrypt also routinely censors journalism websites for political purposes.  For example, on January 2, 2019, Let's Encrypt [revoked the TLS certificate for an allegedly-Russian-funded journalism website](https://www.mcclatchydc.com/news/policy/technology/cyber-security/article223832790.html) aimed at American audiences, [on the grounds](https://home.treasury.gov/news/press-releases/sm577) that the website allegedly "engaged in efforts to post content focused on divisive political issues" and "attempted to hold a political rally in the United States".

[ISRG executive director Josh Aas stated](https://community.letsencrypt.org/t/according-to-mcclatchydc-com-lets-encrypt-revoqued-and-banned-usareally-com/81517/10) on January 4, 2019, that "This happens to maybe one domain per month".

In contrast, Namecoin does not have any 3rd party who can censor your ability to receive TLS certificates.

By default, Let's Encrypt will publish all of your subdomains to Certificate Transparency logs. This has been used for deanonymization attacks in the wild. Let's Encrypt does optionally support wildcard certificates, which mitigate this deanonymization vector. However, Let's Encrypt's wildcard certificates have the following drawbacks:

1. Wildcard certificates are not enabled by default; secure defaults are important.
2. Wildcard certificates cannot be easily auto-renewed, which eliminates a major UX benefit of Let's Encrypt compared to Namecoin.
3. Wildcard certificates are only valid for one wildcarded label, e.g. `*.example.com` is valid but `*.*.example.com` is not valid.
4. Wildcard certificates must be installed onto a publicly facing TLS server. If that server gets compromised, the TLS private key can be used to impersonate all other subdomains, even ones that are not supposed to be served by the compromised TLS server.

In contrast, Namecoin TLS certificates do not leak your subdomains.

Let's Encrypt's services are entirely gratis.  For Namecoin, the pricing is more complicated.  In Namecoin, you create a private CA and place its public key into the blockchain; you can use that CA to issue as many certificates for your domain as you like without requiring additional blockchain transactions.  Issuing certificates from your private CA (e.g. to rotate your TLS server's keys) is gratis.  However, changing the set of private CA's (e.g. to immediately revoke old certificates before they expire) does require a blockchain transaction, which means you'll have to pay a transaction fee.  The extra storage used by your private CA's public key also implies that renewing your domain name will incur a higher transaction fee than if you weren't using TLS.

Let's Encrypt typically renews your certificates automatically. Namecoin certificates must be renewed manually.

TLS certificates issued by Let's Encrypt will work in most TLS clients (without security warnings) without any changes from defaults.  In contrast, Namecoin TLS certificates will only work (without security warnings) if Namecoin is installed.

### How does Namecoin compare to DANE?

* Both Namecoin and DANE protect from MITM and censorship attacks by public certificate authorities.
* Both Namecoin and DANE protect from MITM attacks by DNS resolvers.
* Namecoin additionally protects from MITM and censorship attacks by DNS registrars, DNS registries, and the ICANN root.
* In terms of compatibility with commonly-used TLS client software, Namecoin's advantages over DANE are similar to Namecoin's advantages over [Handshake](#how-does-namecoin-compare-to-handshake).

### How does Namecoin compare to Certificate Transparency (CT)?

* CT makes misissued certificates detectable after-the-fact, but does not prevent them from being accepted by TLS clients. In contrast, Namecoin prevents misissued certificates from being accepted by TLS clients in the first place.
* CT does not protect against censorship attacks by public certificate authorities; Namecoin does.

### How does Namecoin's Encaya TLS compare to Let's DANE?

In short, Namecoin's Encaya design optimizes for minimal attack surface and maximal scalability, while Let's DANE optimizes for maximal compatibility.  For more details, see this comparison table:

|  | **Namecoin Encaya** | **Let's DANE (Intercepting Proxy Used by Handshake)** |
---|---------------------|------------------------------------|
| **TLS implementation** | Not replaced by Encaya; low attack surface.  Memory safety depends on application. | Replaced by Let's DANE; high attack surface.  Memory-safe. |
| **Certificate validation implementation** | Not replaced by Encaya; low attack surface.  Memory safety depends on application. | Replaced by Let's DANE; high attack surface.  Memory-safe. |
| **Certificate database implementation** | Not replaced by Encaya (low attack surface) except for NSS-based applications e.g. Firefox.  Namecoin developers are working on removing this requirement in order to further lower attack surface.  Memory safety depends on application. | Replaced by Let's DANE; high attack surface.  Memory-safe. |
| **TLS code isolated from application process** | Isolated except for NSS-based applications e.g. Firefox, where a shim PKCS#11 module is linked into the application process; this shim module contains minimal logic, is written in memory-safe Go, and mostly just calls out to the isolated Encaya process. | Isolated regardless of application. |
| **TLS possible without installing any software on device** | Positive overrides only; works for most major applications except NSS-based applications e.g. Firefox. | Positive and negative overrides work for any application. |
| **Language** | Go (memory-safe and securely bootstrappable). | Go (memory-safe and securely bootstrappable). |
| **Layering** | Layer 2 (safe subset of DANE-TA); rotating certificates and keys does not require a blockchain transaction, paying a fee, or updating a nameserver configuration.  This improves scalability and encourages secure key hygiene practices. | Layer 1 (DANE-EE); rotating certificates and keys requires a blockchain transaction (with a fee) or updating a nameserver configuration (nontrivial; may cost money; less censorship-resistant). This can pose a scalability and key hygiene hazard. |
| **Works with applications that use a SOCKS proxy** | Yes, easy. | Yes, easy. |
| **Works with applications that don't use a SOCKS proxy** | Yes, easy. | Nontrivial. |
| **Impact of proxy leak** | Only deanonymization/censorship. | Can escalate to Man-in-the-Middle Attack; also deanonymization/censorship. |
| **Works OS-wide** | Yes, usually easy. | Yes, if you can SOCKSify your whole OS. |
| **Works per-application** | Nontrivial. | Yes, easy. |
| **Supported TLS client implementations** | Most major applications work with positive overrides (preventing certificate warnings for valid Namecoin certificates).  Most major Windows and GNU/Linux applications work with negative overrides (preventing public CA's from issuing invalid Namecoin certificates), but on macOS, only NSS-based applications e.g. Firefox support negative overrides.  Some more exotic applications are unsupported. | Any application is supported if you can SOCKSify it. |
| **Supports Ed25519 TLS keys** | Not supported (until applications support them). | Supported. |

### How does Namecoin compare to Blockstack?

Below is a comparison table of Namecoin and Blockstack (with Bitcoin added for reference).

|  | **Namecoin** | **Blockstack** | **Bitcoin** |
---|--------------|----------------|-------------|
| **Lightweight validation mode** | [SPV](https://bitcoin.org/en/glossary/simplified-payment-verification) backed by [PoW](https://bitcoin.org/en/glossary/proof-of-work) (e.g. BitcoinJ+libdohj or Electrum-NMC). | Checkpoints provided by a trusted 3rd party. Blockstack refers to this as "Consensus Hashes", "SNV" ("Simplified Name Verification"), or (confusingly) "SPV". Is not backed by PoW and has no relation to Bitcoin's SPV threat model. | SPV backed by PoW (e.g. BitcoinJ or Electrum). | 
| **Hashrate attesting to transaction ordering** | ~95% of Bitcoin as of 2020 Jan 12. | 100% of Bitcoin. | 100% of Bitcoin. | 
| **Hashrate attesting to transaction validity** | ~95% of Bitcoin as of 2020 Jan 12. | 0% of Bitcoin (miners do not attest to transaction validity). | 100% of Bitcoin. | 
| **Miners possessing a majority of hashrate** | None. | None. | None. | 
| **Mining pools influencing a majority of hashrate** | None. | None. | None. | 
| **Legal jurisdictions influencing pools with a majority of hashrate** | China. | China. | China. | 
| **Infrastructure capable of censoring all new blocks (non-selectively)** | Bitcoin Relay Network, by censoring all Bitcoin blocks that commit to Namecoin blocks. | Bitcoin Relay Network. | Bitcoin Relay Network. | 
| **Infrastructure capable of censoring new blocks based on content (e.g. targeting a name)** | None. | Bitcoin Relay Network. | Bitcoin Relay Network. | 
| **Scalability (blockchain download size, fully validating node)** | 6.06 GB as of 2020 Jan 12 ([source](https://bitinfocharts.com/namecoin/)) (includes name values). | 300.79 GB as of 2020 Jan 12 ([source](https://bitinfocharts.com/bitcoin/)), plus name values. | 300.79 GB as of 2020 Jan 12 ([source](https://bitinfocharts.com/bitcoin/)). | 
| **Scalability (maximum name updates per hour)** | ~5494 to ~10989 (~546 on-chain bytes per update, block size limit 500 kB to 1 MB per ~10 minutes) | ~4363 to ~6545 ([~275 on-chain bytes](https://blockchainbdgpzk.onion/tx/c7ec9f0312751d77591fae93f106fa086dab09f89e50159d6e4724d8c7630f16) per update, block size limit 200 kB to 300 kB per ~10 minutes) | N/A | 
| **Scalability (required incoming bandwidth for read operations, full block node)** | 500 kB to 1 MB per ~10 minutes (if blocks are full) | 1 MB per ~10 minutes for Bitcoin parent chain (blocks usually full), plus all name operation data | 1 MB per ~10 minutes (blocks usually full) | 
| **Scalability (required incoming bandwidth for read operations, headers-only node)** | ~1 kB to ~10 kB per ~10 minutes, plus a Merkle branch per read operation | Headers-only nodes not possible | 80 B per ~10 minutes | 
| **Consensus codebase** | Fork of Bitcoin Core with minimal changes (primarily merged mining and 3 new opcodes for altering a name database). | Codebase built by Blockstack developers. | Bitcoin Core. | 
| **Blockchain type** | Is a sidechain (merge-mined with Bitcoin). | Developers have [stated](https://web.archive.org/web/20160310134327/https://blockstack.org/blockstack.pdf) that "the community needs to look into side chains" because Blockstack's design won't scale well. | Bitcoin. | 
| **Parent blockchain agility** | Bitcoin is the de facto parent chain.  If Bitcoin is attacked, dies out, or has other issues, miners can use a different Hashcash-SHA-256d parent chain without requiring any changes in Namecoin's consensus rules (this worked in practice when BCH forked from Bitcoin).  Non-Hashcash-SHA-256d parent chains could be adopted via a hardfork. | Bitcoin is the enforced parent chain.  Using any non-Bitcoin parent chain requires a hardfork. | No parent chain. | 
| **Data storage** | Choice between blockchain (similar threat model to Bitcoin; resistance to censorship is enforced as a consensus rule) and external storage (lower transaction fees, higher scalability).  External DNS storage currently supports nameservers (threat model is DNSSEC with user-supplied keys; the DNSSEC keys have similar threat model to Bitcoin).  External identity storage currently supports OpenPGP keyservers. | Required external storage; consensus rules do not enforce resistance to censorship. | Blockchain; resistance to censorship is enforced as a consensus rule. | 
| **Namespace creation pricing** | Creating namespaces is open to all users, free of charge. | Creating a desirable namespace [costs a large amount of money](https://github.com/blockstack/blockstack-core/blob/40f3bd7ed38a7d0536b9156275e4433aec14576b/blockstack/lib/config.py#L428) (0.4 BTC minimum; 40 BTC for a 2-character namespace). | N/A. | 
| **Name pricing and name length** | All names have equal registration price. | Name registration price deterministically depends on length, character usage, and namespace. | N/A. | 
| **Name pricing and exchange rates** | Price optimality is dependent on NMC/fiat exchange rates. | Price optimality is dependent on BTC/fiat exchange rates. | N/A. | 
| **Names premined?** | Not premined. | Premined. | N/A. | 
| **Coins premined?** | Not premined. | Premined via ICO ([source](https://web.archive.org/web/20171119180710/https://www.coindesk.com/a-more-equitable-ico-why-blockstack-said-no-to-a-token-pre-sale/)).  [Falsely claimed](https://web.archive.org/web/20171120230840/https:/twitter.com/muneeb/status/867839002778492928) that there would not be an ICO. | Not premined. | 
| **Funding sources and ethics** | Crowdfunding, donations, consulting/contracting (e.g. for F2Pool and an employee of Kraken).  Has refused funding opportunities that were perceived to create conflicts of interest regarding user freedom, privacy, and security.  Frequently references WikiLeaks and Ed Snowden in specification examples and other development discussion. | Business model is not publicly disclosed.  [Seed round led](https://web.archive.org/web/20161210022027/http://venturebeat.com/2014/11/14/y-combinator-backed-onename-raises-1-5m-open-sources-its-bitcoin-identity-directory/) by an investor who has [endorsed cryptographic backdoors](https://web.archive.org/web/20160319061046/http://avc.com/2016/03/privacy-absolutism/) and who considers [ROT13](https://en.wikipedia.org/wiki/ROT13) to be a ["serious" and "intriguing" security mechanism](https://web.archive.org/web/20170831210355/https:/twitter.com/csoghoian/status/709908777038954496), and another investor who has also [endorsed cryptographic backdoors](https://web.archive.org/web/20160318165939/http://continuations.com:80/post/139510663785/key-based-device-unlocking-questionidea-re-apple). | (N/A) | 
| **Do the developers run services that hold users' private keys?** | No.  Many years ago, a former Namecoin developer did run such a service.  It has been discontinued, as the current Namecoin developer team considers such services to be harmful and a liability. | Yes, [Onename](https://onename.com/) holds users' private keys. | Not as far as we know. | 
| **Patented by developers?** | Not patented by developers. | [Patented by developers](https://www.google.com/patents/US20170236123?dq=%22Blockstack%22&hl=en&sa=X&ved=0ahUKEwj7jYbH583XAhXLTSYKHc3OBI4Q6AEILjAB).  Developers did not disclose the patent to their users.  As of 2017 Nov 20, Startpage for "patent", "patented", or Blockstack's patent number shows zero hits on blockstack.org, nor does searching the Blockstack forum for those terms yield any hits. | Not patented by developers. | 

The Blockstack developers have demonstrated a repeated, consistent history of obfuscating their security model.  Three examples:

Example 1: At launch, Blockstack used a [DHT](https://en.wikipedia.org/wiki/Distributed_hash_table) for data storage.  See the opinions of Bitcoin developers [Peter Todd](https://web.archive.org/web/20170319062730/https://bitcointalk.org/index.php?topic=395761.msg5970778;topicseen#msg5970778) and [Greg Maxwell](https://web.archive.org/web/20170319064612/https://bitcointalk.org/index.php?topic=662734.msg7521013;topicseen#msg7521013) about DHT's.  Namecoin developers publicly [warned](https://web.archive.org/web/20150930144501/http://blog.namecoin.org/post/130158040415/onenames-blockstore-is-much-less-secure-than) when Blockstack launched that DHT's were likely to be unsafe in Blockstack.  Quoting the Namecoin blogpost from 2015 Sept. 29:
  
> Additionally, DHT-based discovery of storage nodes is one of the classic suggestions of new users as an alternative to DNS seeds, and, originally, IRC-based discovery: it has never been committed because it is trivial to attack DHT-based networks, and partly because once a node is connected, Bitcoin (and thus Namecoin) peer nodes are solicitous with peer-sharing.
  
> As an actual data store, DHT as it is classically described runs into issues with non-global or non-contiguous storage, with little to no way to verify the completeness of the data stored therein. With the decoupled headers in OP_RETURN-using transactions in Bitcoin and the data storage in a DHT (or DHT-like) separate network, there is the likelihood of some little-used data simply disappearing entirely from the network. There is no indication of how Blockstore intends to handle this highly-likely failure condition.
  
In response to this criticism, Ryan Shea (Blockstack CEO) [stated](https://web.archive.org/web/20151004130708/https://www.reddit.com/r/Bitcoin/comments/3mwtw8/onenames_blockstore_is_much_less_secure_than/) on 2015 Sept. 30:
  
> > Using a DHT could mean that data could become inaccessible
> 
> The information one gets from the DHT is hash-validated by the record in the blockchain which means you can get it from anywhere without trusting the source. The DHT is just one possible source of information and we have set up mirrors to ensure data redundancy and allow anyone to run a mirror in addition to a DHT node. Further, the data in the DHT gets periodically data mined and re-populated as needed by mirrors, to ensure there is no data loss whatsoever. This has been extensively tested.
  
Muneeb Ali (Blockstack CTO) also [stated](https://web.archive.org/web/20151004130708/https://www.reddit.com/r/Bitcoin/comments/3mwtw8/onenames_blockstore_is_much_less_secure_than/) on 2015 Sept. 30 (emphasis in original):
  
> Their DHT arguments show a lack of understanding of how Blockstore's storage works. They **incorrectly assume that the DHT doesn't have global state. It does.**
  
However, on 2017 Jan. 23, Muneeb Ali (Blockstack CTO) [posted](https://archive.is/KJ3GX) the following (link uses archive.is, which is not Tor-friendly, due to Blockstack apparently blocking the Tor-friendly archive.org Wayback Machine from archiving their forum):
  
> Over this weekend (Jan 22), some community members (thanks, Albin!) reported "Data not saved in DHT" error for their profiles. I debugged this issue and turned out that some nodes of our DHT deployment were on a partition. This is very common in DHTs. We've been lucky in our deployment (which started in summer 2015 and has been running continuously since) and haven't experienced partition issues that frequently. This is because of:
> 
> 1. Active monitoring of default discovery nodes and throwing more RAM/CPU at the discovery nodes, so it's hard to overwhelm them with requests.
> 2. Use of a caching layer where even if the underlying DHT network is experiencing, and recovering from, a partition read queries going to nodes that use a caching layer will still work for (heavily) cached data.
> 3. We can proactively check the blockchain for new data and check if data has propagated on the DHT network (traditional DHTs don't have any such channel where new data writes get broadcasted).
> 
> Even with these additional monitoring and caching services, and extra information about new writes, we still experience issues. And the Atlas network described above helps a lot because it's a fundamentally new design which, in my view, is much better than using a traditional DHT for our use case.
> Anyway, just restored the DHT partition and things are back to normal.
  
Blockstack subsequently stopped using a DHT; Muneeb Ali (Blockstack CTO) [stated](https://archive.is/KJ3GX) on 2017 Jan. 13 about why their proposed replacement (a custom P2P network called Atlas) is better than their DHT (emphasis in original; link uses archive.is, which is not Tor-friendly, due to Blockstack apparently blocking the Tor-friendly archive.org Wayback Machine from archiving their forum):
  
> Atlas nodes have a **global view** of the state meaning that they know if they're missing any data items. This is because we use the blockchain to propagate information about new puts (new data items written to the network). This increases reliability a lot because traditional DHT nodes don't even know if they're missing data (there is no global view in traditional DHTs and there are theoretical proofs for that).
  
In other words, the exact issue whose existence we pointed out, and he denied, in 2015.

Example 2: Namecoin developers [pointed out](https://web.archive.org/web/20150930144501/http://blog.namecoin.org/post/130158040415/onenames-blockstore-is-much-less-secure-than) when Blockstack launched that Blockstack was incompatible with SPV.  Ryan Shea (Blockstack CEO) [replied on Reddit](https://web.archive.org/web/20151004130708/https://www.reddit.com/r/Bitcoin/comments/3mwtw8/onenames_blockstore_is_much_less_secure_than/) on 2015 Sept. 30:
  
> > Implementing SPV wouldn't be secure as it depends on having all block information
> 
> The short version is that blockstore definitely supports lightweight nodes. We'll be publishing a blog post on exactly how this works very soon.
  
Muneeb Ali (Blockstack CTO) also [claimed](https://web.archive.org/web/20151004130708/https://www.reddit.com/r/Bitcoin/comments/3mwtw8/onenames_blockstore_is_much_less_secure_than/) on 2015 Sept. 30 (emphasis in original):
  
> it is **possible to have SPV-like functionality** in Blockstore. We will publish details about it.
  
However, the Blockstack developers **already knew** that this was impossible; on 2014 Dec. 12 (before Namecoin developers pointed out the issue), Chris Pacia (an OpenBazaar developer collaborating with Blockstack) [stated](https://web.archive.org/web/20170509074132/https://github.com/blockstack/blockstack-core/issues/1) on the Blockstack issue tracker:
  
> OK. I don't think a blockchain-only lightweight proof is possible without an additional consensus mechanism (blockchain). In fact, I think this is why counterparty and mastercoin don't have SPV implementations ― because you can't do it.
  
The system that Blockstack ended up releasing was... trusted 3rd-party checkpoint hashes.  Not remotely similar to SPV, and not something that most blockchain developers would refer to as a "lightweight node".

Example 3: Namecoin developers have pointed out in this FAQ that Onename (Blockstack's centralized web application for registering names) holds users' private keys.  On 2017 Apr. 07, Muneeb Ali (Blockstack CTO) [complained](https://web.archive.org/web/20170509072808/https://github.com/namecoin/namecoin.org/issues/131) about this, stating:
  
> Private keys on Onename are encrypted with a password only the user has. So Onename doesn’t technically hold private keys, just encrypted blobs that are useless without the users’ passwords.
In comparison, Coinbase actually holds private keys. Exchanges can send bitcoin without the user's permission. This is not the case for Onename.
  
Namecoin developers initially pointed out that the web server could easily serve malicious JavaScript to steal private keys, and therefore Blockstack developers still had access to keys.  However, it turned out to be even worse than that.  Blockstack's own documentation [states](https://web.archive.org/web/20170508084105/https://onename.zendesk.com/hc/en-us/articles/207755189-Profile-being-processed-for-new-registrations):
  
> For new registration, the Onename webapp registers your username on Blockstack on your behalf and then transfers the ownership to you.
  
This implies that the Onename server controls the keys during the registration process, and could easily steal names while they're being registered without serving malicious JavaScript.  A quite different picture than what one might imagine from what Muneeb said to us.

Blockstack's security model obfuscation raises serious questions about whether any future security claims by the Blockstack developers can be taken at face value.

### How does Namecoin compare to Ethereum Name Service (ENS)?

The ENS developers implemented a backdoor for government seizures of names into ENS.  On November 1, 2017, ENS developer Leonard Tan confirmed this at the ICANN60 joint session of the ICANN Board and the ICANN Technical Experts Group:

> PAUL WOUTERS [IETF]:  Sure.    Paul  Wouters,  IETF.    So  I  have  a  question.    Let's  say  IETF gets the domain IETF in this naming system and we pay our fees for a couple of years.  Everybody uses the site.  And then at some point,  we  forget  to  pay  and  the  domain  falls  back  into  the  pool  and  then  somebody  else  registers  it  and  we  don't  know  where  
they are or who they are.  Now I go to a court system.  I get some legal opinion saying I own this trademark and now I want to get this  domain  back.    Is  there  any  way  for  me  to  get  this  domain  back?
> 
> LEONARD TAN [ENS developer]:  So  right  now,  the  ENS  industry,  you  can  change  it  because  it  requires  four  out  of  seven  people.    Most  of  them  are  Ethereum  developers.    And  it  is  a  consensus  for  several  of  them  to  make  any changes.  So it is possible, but it is going to be a very difficult thing to do but it is possible.

Low-quality video of this exchange:

<video controls>
<source src="{{ site.files_url }}/files/videos/icann-60/ICANN-60-Joint-Meeting-ICANN-Board-and-Technical-Experts-Group-LQ-Video-with-Slides.webm#t=42:42,43:38" type="video/webm">
</video>

High-quality video of this exchange:

<video controls>
<source src="{{ site.files_url }}/files/videos/icann-60/ICANN-60-Joint-Meeting-ICANN-Board-and-Technical-Experts-Group-HQ-Video-Only.webm#t=51:39,52:34" type="video/webm">
</video>

Namecoin does not implement such a backdoor, for the reasons explained in [Why doesn't Namecoin implement a backdoor?](#why-doesnt-namecoin-implement-a-backdoor).

The ENS developers appear to be trying to give the impression that they removed this backdoor, or that they intend to remove this backdoor in the future.  However, this is a false impression, for two reasons:

1. The [ENS FAQ claims](https://docs.ens.domains/faq#who-owns-the-ens-rootnode-what-powers-does-it-grant-them) that:

    > The ENS rootnode is currently owned by the ENS DAO. It used to be owned by the ENS Multi-sig, a group of keyholders from different parts of the ecosystem, however as of EP4.10 the ownership has been transferred to the ENS DAO.

    This still constitutes a backdoor, it just complicates the mechanism by which the backdoor can be used. The DAO can still seize domains should they choose to do so.

2. The [ENS developers claimed](https://web.archive.org/web/20220202200523/https://medium.com/the-ethereum-name-service/why-ens-doesnt-create-more-tlds-responsible-citizenship-in-the-global-namespace-7e66658fe2b1) on October 15, 2019, that:

    > The success of our experiment with .ETH has proven the value of the technology. Moving forward, we want to be as responsible as we can. This includes possibly seeking to register .ETH through the normal ICANN [gTLD] process if and when the opportunity presents itself in order to protect our users. We may also apply for other new TLDs through the ICANN process that we could make available on ENS.

    Registering `.ETH` as a gTLD with ICANN would require that ENS be capable of complying with ICANN's trademark seizure policy, which would require the backdoor to remain in place.

    This previously came up at the ICANN60 session:

    > DAVID CONRAD [ICANN CTO]:  I'd  guess  one  question  I'd  have  myself  is  so,  obviously,  you  use  .ETH.    And  I'm  curious what your  plans  are  sort  of  moving  forward    with    regards    to    the    top-level    domain    or    the    identification that you're using for that.
    > 
    > LEONARD TAN [ENS developer]:  Right.    So  we  understand  that  .ETH  is  a  three-letter  code  for Ethiopia  so  it's  probably  out  of  the  question.    But  we  are  still  in  discussions.    Right  now  we  are  all  looking  towards  integration with   existing   systems   first   and   testing   out   whether   ENS   is   functional.  And then afterward, we'll see how it goes.
    > 
    > DAVID CONRAD:  Yeah.      Just   to   clarify,   .ETH   -- so   three-letter   codes   are   not   reserved.    So  the  fact  that  it's  a  three-letter  code  for  Ethiopia,  it  doesn't actually mean that it's been reserved for Ethiopia.
    > 
    > LEONARD TAN:  That's great.
    > 
    > DAVID CONRAD:  So   if   the   next   round   of   gTLDs   occurs,   that   might   could   be   something that you could look into, or not.

    Low-quality video of this exchange:

    <video controls>
    <source src="{{ site.files_url }}/files/videos/icann-60/ICANN-60-Joint-Meeting-ICANN-Board-and-Technical-Experts-Group-LQ-Video-with-Slides.webm#t=39:25,40:33" type="video/webm">
    </video>

    High-quality video of this exchange:

    <video controls>
    <source src="{{ site.files_url }}/files/videos/icann-60/ICANN-60-Joint-Meeting-ICANN-Board-and-Technical-Experts-Group-HQ-Video-Only.webm#t=48:21,49:29" type="video/webm">
    </video>

    The fact that ENS considered the primary obstacle to gTLD registration to be the reservedness of `.ETH` as a country code, rather than the trademark seizure policy, suggests that the ENS developers are not opposed to trademark seizures, which their backdoor enables.

The ENS developers also do not clearly disclose to their users the existence of their backdoor.  While their FAQ does technically mention the backdoor, the FAQ entry is riddled with confusing jargon (e.g. "node", "root node", and "subnode") that is not defined anywhere in the FAQ, and average users who read that FAQ entry are unlikely to understand that this actually means "It takes 4 out of 7 people to override the blockchain and steal your name to give to someone else."  As one concrete data point, we have directly spoken to a highly competent cryptography developer who is familiar with blockchain systems and ENS, and they were completely unaware of the ENS backdoor until we mentioned it to them.  Non-developers without cryptography knowledge are likely to be even less aware.

A secondary backdoor exists in the `.eth` registrar smart contract.  [As ENS developer Nick Johnson said](https://old.reddit.com/r/ethereum/comments/b9vd11/were_the_ethereum_name_service_ens_team_and_ens/ek7kwdb/):

> Once we're happy it's working as functioned, we'd like to make changes that would make it impossible for even the ENS root keyholders to change the .eth registrar. This would mean that while they could still change the rules for registration and renewal of names, they couldn't affect the ownership of any name in the .eth top-level domain - ownership would be iron-clad and completely free of control by a third-party.

Of course, this completely glosses over the fact that "changing the rules for registration and renewal of names" still permits a massive amount of mischief by the backdoor holders.

[According to EasyDNS CEO Mark Jeftovic](https://web.archive.org/web/20240520180852/https://easydns.com/blog/2017/09/19/dns-on-blockchain-ethereum-name-service-ens-vrm-and-governance-oh-my/), the consensus of the ENS developers in private conversations (which confirms why they created the backdoor) is:

> there needs to be a mechanism for when a domain has to come down.

> there was always the need for “the handbrake” – a big lever that “stops the train” when things go terribly wrong.

> Hard forking the blockchain every time you needed to take down a domain was not practical.

The ENS developers have also given dangerous security advice to Tor users, in an article entitled ["How Secure Is Using ENS for Tor .Onion Addresses?"](https://web.archive.org/web/20220528075149/https://medium.com/the-ethereum-name-service/how-secure-is-using-ens-for-tor-onion-addresses-85b22f44b6e0)  For example, the ENS developers advertise in that article that:

> Both the logic of the naming service and all records are stored on Ethereum. ENS has no servers.

Except that later in that article, they advocate for resolving domains via... centralized servers:

> MetaMask defaults to accessing the Ethereum blockchain via a service called Infura. Infura runs a number of Ethereum full nodes and allows people to interact with them via its API. This involves a certain level of trust. Infura is a well-known, trusted company in the space, so for most users leaving MetaMask on its default of using Infura should be good enough.

Disturbingly, the article also advocates for immutable keys, and claims that this is a security *upgrade*:

> It’s also possible to register a name, set its records, and then transfer control of the name to an Ethereum address no one controls (e.g. transfer both the Registrant and Controller of a name to “0x000000000000000000000000000000000000dEaD”; this can be done and verified with our Manager). That way, everyone can be certain the records as they currently exist cannot be changed by anyone and so will remain the same.
> 
> This is particularly helpful for achieving high security for Tor .onion users, because it can ensure the name won’t be used for phishing (e.g. someone sets a name to resolve to a legitimate .onion address, gains trust of users, then changes the name to resolve to a different .onion address of a phishing site that appears identical to the legitimate .onion website).

In other words, if you need to rotate your onion service keys for any reason (perhaps due to Heartbleed), you would permanently lose your name if you had followed the ENS developers' advice for "achieving high security".  Not to mention that the **entire set of ENS onion names** would have been permanently destroyed by the v3 onion service upgrade.  The claim about this design somehow being useful for preventing phishing is unintentionally revealing.  Normally, this claim would be nonsense, since there are plenty of ways to prevent unauthorized names pointing to a server without resorting to absurdities like immutable keys.  But this design **does** make some sense if one recognizes that the ENS developers aren't aiming at use cases where an onion service owner sets up a name for their own onion, but rather use cases where 3rd parties set up names for other people's onions, and expect users to then utilize those names as though they're official.  In contrast, the Namecoin developers explicitly warn against ever using a name set up by a 3rd party, because such usage is inherently dangerous.

In addition, the ENS article recommends that Tor Browser users install the MetaMask browser extension.  A quick glance at the [MetaMask page on AMO](https://addons.mozilla.org/en-US/firefox/addon/ether-metamask/) indicates quite a lot of built-in functionality that raises concerns about attack surface, such as:

> The extension injects the Ethereum web3 API into every website's javascript context, so that dapps can read from the blockchain.
> 
> MetaMask also lets the user create and manage their own identities (via private keys, local client wallet and hardware wallets like Trezor™), so when a Dapp wants to perform a transaction and write to the blockchain, the user gets a secure interface to review the transaction, before approving or rejecting it.
> 
> Because it adds functionality to the normal browser context, MetaMask requires the permission to read and write to any webpage.

MetaMask also is [closed-source](https://addons.mozilla.org/en-US/firefox/addon/ether-metamask/license/), under a license that mandates tracking users.

What do the ENS developers think about introducing this attack surface and closed-source code into Tor Browser?  Quoting their article:

> We believe this setup is secure enough for most users of Tor .onion websites

More generally, there is a disturbing attitude of hubris by the ENS developers, which is probably best exemplified by this quote from the ENS article:

> there’s just about no way ENS can go wrong. It can’t be hacked

Hmm, where have we heard [this kind of marketing language](https://web.archive.org/web/20180725131926/https://twitter.com/officialmcafee/status/1021805449681817600) before...?

> my Bitfi wallet is truly the world's first unhackable device
> 
> ~ John McAfee, scammer

This McAfee scam that used comparable marketing language to ENS was later the recipient of the [2018 Pwnie Award for Lamest Vendor Response](https://pwnies.com/bitfi-2/):

> This response has everything. Bitcoin. The word Unhackable. John McAfee. A 250k Bounty that is so narrowly constrained it is ridiculous. Reverse engineers posting that the wallet has no hardware security mechanisms (not even anti-tamper). Multiple people breaking the device. A video of John McAfee being displayed onscreen on the device. A tweet from bitfi claiming that rooting the device doesn’t mean that it was hacked.

(That Pwnie Award was collected by [a Namecoin developer](https://rya.nc/bitfi-wallet.html).)

One of the ENS developers (Virgil Griffith) also is known for [running wiretap infrastructure](https://medium.com/@c5/tor2web-proxies-are-using-google-analytics-to-secretly-track-users-fd245dbc81c5) on behalf of the U.S. and Singaporean governments. A U.S. court document [referenced Virgil's wiretap infrastructure](https://darknetlive.com/post/nasa-contractor-used-a-tor2web-proxy-to-download-child-porn/) when seeking an arrest warrant against a third party.

In addition to the ENS-specific concerns, ENS also inherits [the problems of Ethereum](#why-isnt-namecoin-implemented-as-an-ethereum-contract), on which they are dependent.

[Source material for the ICANN60 session is here.]({{ "/2020/04/30/icann-60-teg-recordings.html" | relative_url }})

### How does Namecoin compare to Handshake?

|  | **Namecoin** | **Handshake** |
---|--------------|---------------|
| **Global names** | Yes. | Yes. |
| **Decentralized** | Yes (blockchain). | Yes (blockchain). |
| **Human-meaningful names** | Yes. | Yes. |
| **Namespace** | `.bit` Special-Use Top-Level Domain (suTLD) ([why?](#why-does-namecoin-use-the-bit-special-use-top-level-domain-sutld-instead-of-overlaying-the-root-zone)).  A second-level domain such as `wikileaks.bit` is controlled solely by whoever holds its keys. | Overlays root zone.  To be decentralized, users must register top-level domains (not second-level domains), which pollutes the root namespace.  |
| **SPV name inclusion proofs** | Supported. | Supported. |
| **SPV unspent name inclusion proofs** | Not supported yet; Namecoin intends to add support via a softfork. | Supported. |
| **SPV name nonexistence proofs** | Not supported yet; Namecoin intends to add support via a softfork.  Currently worked around by asking multiple P2P nodes for inclusion proofs. | Supported. |
| **Mining** | Merge-mined Bitcoin sidechain; very high hashrate ([see Metrics]({{ site.metrics_url }}/namecoin/period-timestamps-14-days/pool/charts/latest.txt)). | Independent chain; relatively low hashrate. |
| **Hash function** | SHA-256d.  [Known attacks](https://crypto.stackexchange.com/questions/7895/weaknesses-in-sha-256d) exist, but are not believed to affect Bitcoin or Namecoin.  More well-studied. | BLAKE2b and SHA-3 ([source](https://web.archive.org/web/20210922221849/https://hsd-dev.org/protocol/summary.html)).  Less well-studied, but believed to be more secure. |
| **Expiration timestamp method** | Block height.  Expiration period varies based on hashrate.  Better security against reorganizations; worse UX security. | Block height.  Expiration period varies based on hashrate.  Better security against reorganizations; worse UX security. |
| **Difficulty retargeting interval** | 2016 blocks (typically 2 weeks).  More secure against PoW attacks, but less secure against expiration period UX attacks. | 1 block.  More secure against expiration period UX attacks, but less secure against [PoW attacks](https://web.archive.org/web/20220112235441/https://old.reddit.com/r/Bitcoin/comments/mtugta/mentor_monday_april_19_2021_ask_all_your_bitcoin/gv86j6b/). |
| **Nominal semi-expiration period (names stop resolving)** | 222 days since last renewal/update. | No grace period. |
| **Nominal expiration period (names can be registered by anyone else)** | 250 days since last renewal/update (28 days since semi-expiration with no renewal/update). | 2 years since last renewal/update. |
| **Behavior of semi-expired/expired names** | Unresolvable.  More secure against stealth-hijacking. | Resolvable.  Less secure against stealth-hijacking. |
| **Secure genesis proof of freshness?** | Insecure (<cite>V for Vendetta</cite> quote).  Arguably forgivable since genesis proofs of freshness were not widely understood in 2011.  No known allegations of actual premining abuse. | Secure (Bitcoin block hash). |
| **Full node codebase** | Fork of Bitcoin Core (very well-audited, supports W^X hardening, but not memory-safe). | Fork of Bcoin (memory-safe, but not very well-audited and does not support W^X hardening). |
| **Default DNS recursive resolver** | [Unbound](https://nlnetlabs.nl/projects/unbound/about/) (very well-audited, but not memory-safe). | [bns](https://github.com/chjj/bns) (memory-safe, but not very well-audited). |
| **Supported Layer 1 DNS record types** | Most DNS record types ([source](https://github.com/namecoin/proposals/blob/master/ifa-0001.md)).  Hosting your own nameserver, or using a nameserver operated by a third party, is [optional]({{ "/docs/name-owners/dnssec/" | relative_url }}).  Better UX, but worse scalability. | Only `NS`, `DS`, and `TXT` ([source](https://web.archive.org/web/20210708233457/https://hsd-dev.org/guides/resource-records.html)).  Hosting your own nameserver, or using a nameserver operated by a third party, is required.  Better scalability, but worse UX. |
| **Layer 1 value size limit** | 520 bytes.  Better flexibility, but worse scalability. | 512 bytes ([source](https://web.archive.org/web/20210708233457/https://hsd-dev.org/guides/resource-records.html)).  Better scalability, but worse flexibility. |
| **Layer 1 value format** | JSON.  Better debuggablity, but worse flexibility and scalability. | DNS wire format.  Better flexibility and scalability (approximately twice as efficient as Namecoin), but worse debuggability. |
| **Name update latency (for full nodes)** | 1 block (~10 minutes).  More reliable for key revocations. | 1 to 36 blocks (~10 minutes to ~6 hours) ([source 1](https://web.archive.org/web/20210708233457/https://hsd-dev.org/guides/resource-records.html)) ([source 2](https://web.archive.org/web/20211204054822/https://old.reddit.com/r/handshake/comments/j9g3y8/faq_what_is_the_coin_emission_schedule_for_hns/)).  Less reliable for key revocations. |
| **TLS installed by default** | Installed by default on Windows, not yet on other OS's. | Not installed by default. |
| **TLS implementation method** | Encaya is recommended.  An intercepting proxy (e.g. Let's DANE) will work ([see comparison](#how-does-namecoins-encaya-tls-compare-to-lets-dane)); Namecoin developers strongly recommend avoiding intercepting proxies ([why?](#why-doesnt-namecoin-recommend-a-tls-intercepting-proxy)).  A browser fork (e.g. Beacon) will work; Namecoin developers strongly recommend avoiding browser forks ([why?](#why-focus-on-getting-existing-browsers-and-oss-to-support-namecoin-instead-of-forking-those-browsers-and-oss)). | Requires intercepting proxy (e.g. Let's DANE) or a browser fork (e.g. Beacon). |
| **Names premined?** | Not premined. | Premined via airdrop to DNS name owners based on DNSSEC proofs and to trademark owners. |
| **Coins premined?** | Not premined. | Premined via genesis airdrop to investors, businesses, various charities and FLOSS projects (including Namecoin), and faucet users. |
| **Do the developers run and recommend centralized name resolution services?** | No, and the Namecoin developer team has a [solid track record]({{ "/2019/07/30/opennic-does-right-thing-shuts-down-centralized-inproxy.html" | relative_url }}) of persuading third-party services to shut down, as we consider such services to be harmful and a liability. | Yes.  [Easyhandshake TRR](https://easyhandshake.com/) is operated by Handshake developer Matthew Zipkin.  Matthew Zipkin's employer ([Impervious](https://impervious.com/)) and Handshake developer Andrew "rasengan" Lee (doing business as "DNS Live") [also run such services](https://archive.ph/AXQm4).  No one in the Handshake community reacted with criticism when these were [advertised on r/Handshake](https://archive.ph/NtMvo). |
| **Funding sources** | Crowdfunding, donations (including a no-strings-attached airdrop from Handshake), consulting/contracting (e.g. for F2Pool), and government grants (e.g. the Netherlands and the EU via NLnet). | Investor funding (investors received a pre-mined genesis airdrop).  Investors include Roger Ver (well-known for attempting a hostile takeover of Bitcoin) and Andrew "rasengan" Lee (well-known for performing a [hostile takeover of Freenode](https://www.devever.net/~hl/freenode_abuse)). |
| **Primary goal** | Alternative to DNS registries and registrars. | Alternative to ICANN. ["Handshake is meant to replace the root zone file, not DNS."](https://web.archive.org/web/20250126085335/https://handshake.org/faq/) ["The root becomes the blockchain instead of ICANN. This project simply finishes the beautiful DNS ecosystem, which was already decentralized, other than the root."](https://web.archive.org/web/20210116001302/https://news.ycombinator.com/item?id=25747284) |
| **Support chat channels** | Hackint, OFTC, Libera, Matrix. | Freenode ([operators engage in routine abuses of power](https://www.devever.net/~hl/freenode_abuse)), Slack (non-free protocol), Telegram ([about as safe as leaving exposed wires around your house because they are either not live or placed high enough that no one should touch them](https://buttondown.email/cryptography-dispatches/archive/cryptography-dispatches-the-most-backdoor-looking/)).  ([Source.](https://web.archive.org/web/20211012001546/https://old.reddit.com/r/handshake/))
| **Founder involvement** | Pseudonymous; retired; not active elsewhere. | Non-pseudonymous; mostly retired but still help out in emergencies and give advice; active elsewhere. |
| **Whitepaper launch** | 2010 (as BitDNS); 2011 (as Nakanames). | 2018. |
| **Mainnet launch** | 2011. | 2020. |
| **License** | Freedom Software (mostly MIT, GPLv3+, and LGPLv3+). | Freedom Software (mostly MIT and Apache). |

### How does Namecoin compare to Unstoppable Domains?

The Unstoppable Domains developers can censor or hijack names during the registration process, due to centralized registration with no frontrunning protections. In contrast, Namecoin utilizes cryptographic protections against frontrunning and has decentralized registration. [Per the Unstoppable Domains docs](https://docs.unstoppabledomains.com/smart-contracts/overview/uns-architecture-overview/#registry):

> "Accounts that are allowed to mint second-level domains (e.g.: `alice.x`) are called whitelisted minters. Whitelisted minters are only permitted to mint new domains. They can't control domain ownership (e.g. approve or transfer a domain to another owner) and they can't change domain records. Whitelisted minters are operated by Unstoppable Domains."

Unstoppable Domains also inherits [the problems of Ethereum](#why-isnt-namecoin-implemented-as-an-ethereum-contract), on which [they are dependent](https://docs.unstoppabledomains.com/smart-contracts/overview/uns-architecture-overview/#registry).

### How does Namecoin compare to GNU Name System?

* Both are decentralized.
* GNS has two name types: zTLD names, which are globally unique but not human-meaningful, and petnames, which are human-meaningful but not globally unique. Namecoin names are simultaneously globally unique and human-meaningful.
* GNS overlays the root zone; Namecoin uses a suTLD ([why?](#why-does-namecoin-use-the-bit-special-use-top-level-domain-sutld-instead-of-overlaying-the-root-zone)).

### How does Namecoin compare to Monero?

Monero's MoneroDNS project is similar in concept to Namecoin.  MoneroDNS's technical differences to Namecoin are similar to Monero's technical differences to Bitcoin.  Monero has had much less technical review than Bitcoin, and merge-mined chains based on Monero have significantly less hashrate security available to them than merge-mined chains based on Bitcoin.  On the other hand, Monero's small size enables them to liberally experiment with more advanced features and cryptography, whereas Bitcoin-based systems like Namecoin are more conservative.  The Namecoin and Monero development teams are cooperating on areas of common interest, as both projects agree that Namecoin and Monero both have a future.

On the other hand, Symas Corporation, which is [a sponsor of Monero](https://www.getmonero.org/community/sponsorships/), was [caught distributing backdoored crypto code](https://bugzilla.redhat.com/show_bug.cgi?id=1740070) in 2019, and subsequently [attempted to censor reporting of the backdoor](https://bugzilla.redhat.com/show_bug.cgi?id=1740070#c23).  Monero developer Howard Chu, who is the CTO of Symas Corporation, [was a participant](https://bugzilla.redhat.com/show_bug.cgi?id=1740070#c26) in this backdoor scheme, and [claimed that victims of his backdoored code are to blame](https://web.archive.org/web/20200820225753/https://twitter.com/hyc_symas/status/1296582095545028619). Namecoin developers would not have done this.

### How does Namecoin compare to OpenTimestamps?

Namecoin writes the hash of the timestamped file directly to the blockchain, while OpenTimestamps uses Merkle trees to commit to a large number of timestamped files in a single transaction. For proof-of-existence timestamping purposes, OpenTimestamps and Namecoin offer roughly equivalent security once their proofs have been committed to in a Bitcoin transaction. However, OpenTimestamps's usage of Merkle trees allows it to provide this security with much better scalability (in terms of transaction fees and blockchain storage used) -- so much so that OpenTimestamps doesn't need to charge fees to users, and is able to fully fund its Bitcoin transaction fees via donations. For such use cases, OpenTimestamps is preferable, as it conserves Namecoin blockchain storage for use cases (such as DNS) that require that storage, and avoids the UX and privacy issues of users having to pay fees to timestamp a file.

However, OpenTimestamps does not provide exclusivity proofs as Namecoin does.  For example, Alice can commit to both a "Heads" and "Tails" coin flip result in OpenTimestamps, and selectively reveal whichever commitment is to her benefit later, which might constitute fraud under some situations.  Alice would not be able to do this type of fraud in Namecoin, because Namecoin guarantees not just that the commitment *existed* (as OpenTimestamps does) but also that the commitment is *exclusive* (i.e. that no other commitments were covertly made).  For use cases that require exclusivity proofs, Namecoin may be preferable over OpenTimestamps, subject to other concerns such as scalability.

OpenTimestamps also does not provide human-meaningful names for commitments.  While this is fine for many situations, users who require human-meaningful names may prefer Namecoin (again, subject to other concerns such as scalability).

### What is Namecoin's relationship to OpenNIC?

On May 27, 2014, OpenNIC [voted](https://lists.opennicproject.org/sympa/arc/discuss/2014-05/msg00071.html) to add a centralized Namecoin inproxy to their DNS infrastructure.  No Namecoin developers participated in [the discussion](https://lists.opennicproject.org/sympa/arc/discuss/2014-05/msg00021.html) surrounding that vote.

On December 4, 2018, a brief [discussion](https://lists.opennicproject.org/sympa/arc/discuss/2018-12/msg00000.html) occurred within OpenNIC about whether Namecoin should be removed.  The cited reason for considering removing Namecoin was that some OpenNIC server operators had been harassed by blacklist providers and hosting providers due to some botnet activity that was accessing OpenNIC for C&C infrastructure.  The alleged botnet C&C domains included some Namecoin domains, but also included some centralized OpenNIC domains, such as domains on `.fur`.  OpenNIC criticized those blacklist providers for the harassment, saying "none of them have the courtesy to so much as send an email to abuse@domain to let you know that a problem was detected... they claim to be trying to protect the internet but don't give victims a chance to fix the problems".  The discussion "[produced] [little in the way of support or dissent](https://lists.opennicproject.org/sympa/arc/discuss/2019-06/msg00000.html)" for whether to continue resolving Namecoin domains, and OpenNIC decided to continue resolving Namecoin.

On December 19, 2018, [PRISM Break](https://prism-break.org/) lead maintainer Yana Teras floated the idea to Namecoin developer Jeremy Rand of de-listing OpenNIC due to security concerns about centralized Namecoin resolution.  Jeremy concurred that centralized Namecoin resolution was a security risk, pointed to a [case study]({{ "/2018/09/24/how-centralized-inproxies-make-everyone-less-safe-case-study.html" | relative_url }}) he had previously written on the subject, and recommended that PRISM Break not list centralized Namecoin resolvers; Yana removed OpenNIC from PRISM Break.

On June 9, 2019, Katie Holly from OpenNIC [contacted](https://gitlab.com/prism-break/prism-break/merge_requests/2073) Yana and Jeremy on the PRISM Break issue tracker, stated that she had recently discovered Yana's and Jeremy's concerns, and asked what OpenNIC would need to do to be re-listed on PRISM Break.  Katie also said that OpenNIC would shortly hold an election on whether to remove Namecoin support as Yana and Jeremy had recommended.

On June 10, 2019, Yana replied, stating that removing centralized Namecoin resolution was of "critical" priority if OpenNIC was to be re-listed.  Jeremy subsequently recommended the same.

On June 11, 2019, OpenNIC [announced](https://lists.opennicproject.org/sympa/arc/discuss/2019-06/msg00000.html) that they were beginning their election on whether to follow Yana's and Jeremy's recommendation to remove Namecoin support.

On June 25, 2019, Jeff Taylor from OpenNIC [announced](https://lists.opennicproject.org/sympa/arc/discuss/2019-06/msg00009.html) that the election had concluded in favor of following Yana's and Jeremy's recommendation, by a final margin of 13 to 2.

On July 30, 2019, Jeremy [published]({{ "/2019/07/30/opennic-does-right-thing-shuts-down-centralized-inproxy.html" | relative_url }}) a blogpost publicly thanking OpenNIC for doing the right thing.  Yana signed off on the blogpost before publication.  (The blogpost was written on June 30, but publication was delayed by the Tor Developer Meeting.)

There is currently no active relationship between Namecoin and OpenNIC, but some Namecoin developers (including Jeremy) continue to recommend OpenNIC to users who want a centralized naming system that isn't run by ICANN.

## Weaknesses

### How easy is it for names to be stolen?  What can be done if it happens?

For an attacker who does not have a majority of hashrate, stealing a Namecoin name is, roughly speaking, equivalent to the task of stealing bitcoins.  This usually requires stealing the private key which owns the name.  Assuming that proper security measures are in place by the owner, this is very difficult.  However, if a user fails to keep their private keys safe, all bets are off.  The standard method for attempting to steal bitcoins is to use malware; this is likely to be equally effective for stealing Namecoin names.  Users can protect themselves using all the standard methods of avoiding malware, which are out of scope of this FAQ.

The good news is that the script system inherent in Bitcoin and Namecoin is designed to enable features that make theft more difficult.  Many features are under development that would allow users considerable flexibility in constructing anti-theft policies that meet their needs.  For example:

* **Multisig** (similar to Bitcoin) would allow names to be controlled by M-of-N keys.  Some of these keys could belong to the various directors of a company, be stored in a secure location, or be stored by semi-trusted service providers.  This is currently supported by the Namecoin protocol and consensus rules, but not well-exposed to end users.
* **Offline signing** (similar to Bitcoin) would allow names to be controlled by keys that are located on an air-gapped computer, an isolated offline Qubes virtual machine, or a hardware wallet.  This is currently supported by the Namecoin protocol and consensus rules, but not well-exposed to end users.
* **Delegated renewal** (Namecoin-specific) would allow a key to be authorized to renew a name, but not change its value or its owner.  Efforts are underway to add this to the Namecoin protocol and consensus rules.
* **Delegated alteration** (Namecoin-specific) would allow a key to be authorized to alter the value of a name, but not change its owner.  This is supported, but not well exposed to end users. Further improvements are underway.  See the docs on [delegated alteration]({{ "/docs/name-owners/delegated-alteration" | relative_url }}).
* **Delegated partial alteration** (Namecoin-specific) would allow a key to be authorized to alter a specific subset of the value of a name (for example, be allowed to change a domain name's IP address but not its TLS certificate), but not change other parts of the value or its owner.  This is supported, but not well-exposed to end users.  Further improvements are underway.  See the docs on [delegated alteration]({{ "/docs/name-owners/delegated-alteration" | relative_url }}).

The above features can, of course, be combined arbitrarily for additional layered security.

Unfortunately, if all of the above security measures fail (or are not in use for a given name), and a name does get stolen, it is very difficult to recover it.  Legal action might be able to fine or imprison the thief if they refuse to return the name, but this is not reliable, given that there is no guarantee that the thief will be identifiable, or that the thief will be in a legal jurisdiction who cares.  Furthermore, since names do get sold or transferred on a regular basis, it would be difficult to prove that the name was not voluntarily transferred.  (False claims of theft are problematic in Bitcoin too.)  In cases where it is obvious that a theft has occurred (e.g. a previously reputable website starts serving malware), voluntary and user-bypassable third-party blacklists (e.g. [PhishTank](https://en.wikipedia.org/wiki/PhishTank)) could be reasonably effective at protecting users in some circumstances.  While this doesn't recover the name, it does reduce the incentive to attempt to steal names.

We are unaware of convincing empirical evidence of how Namecoin's theft risk compares to that of the DNS when the recommended security procedures of both are in use; this is difficult to measure because it is likely that a significant number of Namecoin users and DNS users are not using the recommended security procedures.

### What is the threat posed by 51% attacks?

Information about what a 51% attacker can do in Bitcoin is [described on the Bitcoin StackExchange](https://bitcoin.stackexchange.com/a/662).  Namecoin is quite similar.  The primary things that adversely affect Namecoin are reversing transactions sent by the attacker and preventing transactions from gaining confirmations.

Reversing transactions sent by the attacker would allow name registrations to be stolen if the reversed transaction is a `name_firstupdate`.  This is because prior to being registered, names are considered to be "anyone can spend", meaning that prior to the registration, any arbitrary attacker is equally in ownership of a name as the user who actually registers it.  Preventing transactions from gaining any confirmations would allow names to be stolen if all transactions for a name are prevented from confirming until the name expires after 36,000 blocks, at which point the attacker can register it (but it should be noted that this would require a prolonged 51% attack lasting until the 36,000-block expiry period elapses, which would be highly expensive).

Both of these attacks are detectable.  In the case of reversing transactions, the evidence would be an extremely long fork in the blockchain, possibly thousands of blocks long or longer.  In the case of preventing transactions from confirming, the evidence would be that the blockchain indicates that a name expired and was re-registered.  In both cases, it is detectable which names were attacked.  In the case of preventing transactions from confirming, it is also possible for the legitimate owner of the stolen name to register a new name after the attack is over, and sign it with the owner key of the original name, thus proving common ownership and allowing secure resurrection of the name.  The only way to prevent this resurrection is for the attacker to continue to expend mining resources on the attack for as long as they with to prevent the name from being resurrected.  In the case of reversing transactions, it is not possible to prove ownership of the original name and resurrect it.  Luckily, reversing old transactions is considerably more expensive than preventing new transactions from confirming.

It is noteworthy that a 51% attacker cannot sell a name to a user and then steal back the name.  Nor can a 51% attacker buy a name from a seller and then steal back the money.  This is because Namecoin supports *atomic* name trades: reversing the purchase payment also reverses the name transfer, and vice versa.  Double-spending of `name_update` transactions also isn't beneficial to an attacker, because `name_update` transactions typically are sent by a user to themself, meaning that the attacker could only scam themself.

In both Bitcoin and Namecoin, the Chinese government has jurisdiction over a majority of hashpower.  This is problematic for both Bitcoin and Namecoin, and should be fixed in both.  Because not all Bitcoin miners also mine Namecoin, F2Pool previously had a majority of Namecoin hashpower (they no longer do).  This was also problematic when it was the case.  However, in practice, the Chinese government has considerably more motivation to perform a 51% attack than F2Pool does.  (The Chinese government has a [history of messing with Internet traffic](https://en.wikipedia.org/wiki/Internet_censorship_in_China).  F2Pool has supported Namecoin development both financially and logistically, which makes it unlikely that they would want to attack it.)

A majority of Bitcoin's hashpower is routed via the Bitcoin Relay Network, which has the ability to censor Bitcoin blocks that pass through it.  This produces incentives for Bitcoin miners to self-censor any blocks that might violate any policy introduced in the future by Bitcoin Relay Network, because routing blocks through Bitcoin Relay Network reduces orphan rates for miners.  Namecoin's blocks are much smaller than Bitcoin's, and therefore Namecoin does not have similar incentives for centralized block relay infrastructure.  While it is possible for Bitcoin Relay Network to attack Namecoin by censoring Bitcoin blocks that commit to merge-mined Namecoin blocks, it is not feasible for Bitcoin Relay Network to look inside the Namecoin blocks that are committed to, which means that Bitcoin Relay Network cannot censor Namecoin blocks by content as they can with Bitcoin blocks.  Bitcoin Relay Network is operated by Bitcoin Core developer Matt Corallo, who is unlikely to want to attack Bitcoin (just as F2Pool is unlikely to want to attack Namecoin).

The takeaway here is that while F2Pool theoretically used to be capable of attacking Namecoin (but not Bitcoin), and Bitcoin Relay Network is theoretically capable of attacking Bitcoin (but not Namecoin), *in practice* the party with the most motivation to attack either chain (the Chinese government) has jurisdiction over a hashrate majority of both Bitcoin and Namecoin.  Mining decentralization is an active research area, and we hope that significant improvements in this area are made, as they would improve the security of both Bitcoin and Namecoin.

### Will major users (e.g. large corporations) refuse to use Namecoin because of the irreversible, catastrophic consequences of losing their domain name?

We don't think this will be a problem.  Crypto of all kinds is inherently unforgiving.  For example:

* Full-disk encryption (FDE) is inherently unforgiving if you forget your passphrase.
* Automated software update signing is inherently unforgiving if you lose your private signing keys.

Despite this, large corporations **routinely** use FDE and distribute software with automated update signing.  (In fact, large corporations who *don't* do this are usually criticized as negligent.)  Why do they do this?

* They have assessed that the consequences of **not** using these cryptosystems are **also** catastrophic.
    * They don't want to lose their trade secrets to industrial espionage due to a laptop getting stolen.
    * They don't want users of their software products to either ignore software updates or install malware that impersonates a software update.
* They have developed workflows that mitigate the risk of catastrophic outcomes.
    * They may backup their encrypted laptops' contents to drives that use a different FDE passphrase, held by a different employee
    * They may store their software update private signing keys on HSM's and use fallback signing keys held on a different HSM in a different location.

The consequences of having your DNS domain name hijacked or censored can be catastrophic, just like having an unencrypted laptop stolen.  And Namecoin is designed to support workflows that mitigate risk of key loss, like other well-designed crypto.  Since Namecoin is relatively new, these mitigation workflows are not as well-fleshed-out in Namecoin as in older crypto like FDE, but we expect this to improve over time.  Thus, while Namecoin is unforgiving just like other crypto, we don't expect this to be a dealbreaker in terms of adoption, similar to other crypto such as FDE.

### Is squatting a problem?  What can be done about it?

There are several types of squatting concerns sometimes raised in relation to Namecoin.

The first concern is that too many potentially high-value domains, e.g. `d/google`, have been squatted for the purpose of resale.  This is not a problem that can be solved in a decentralized system, because "squatting on `d/google`" is defined as "owning `d/google` while not being the real-world company named Google", and determining that a given name is or is not owned by a given real-world entity requires some trusted party.  Raising the price of names wouldn't have any effect on this, because no matter what the cost of registering a name is, the resale value of `d/google` is likely to be higher.

The second concern is that too many potentially high-value domains have been squatted for the purpose of impersonation.  This is not a problem specific to Namecoin; phishing sites exist in the DNS world too, and are frequently countered by using systems such as web-of-trust and voluntary user-bypassable third-party blacklists (e.g [PhishTank](https://en.wikipedia.org/wiki/PhishTank)).  There is no reason to think that similar counters would not work in Namecoin.

The third concern is that single entities can squat on a large number of names, which introduces centralization into the space of squatted names.  For comparison, DNS domain names are squatted a lot, but the space of squatted names is very decentralized, which reduces abusive behavior such as would happen if most squatted names belonged to one of a few people.  This concern could be resolved by raising the price of name registrations, so that a squatter with a given investment budget cannot register as many names without selling or otherwise using them to recoup costs.  While raising prices sounds like a great plan, the devil is in the details: increasing prices constitutes a softfork, and decreasing prices constitutes a hardfork.  Since cryptocurrencies like Namecoin have an exchange rate that varies over time, the optimal name price might need regular adjustment.  There is ongoing research into how regular name price adjustment could be done safely and non-disruptively, and research in the wider cryptocurrency world on block size adjustment (which is a similar problem in many ways) may be applicable.

At the moment, the current developers consider other issues to be somewhat higher priority.  For example, getting a domain name without dealing with squatters doesn't mean much if it's difficult for people to view your website.  Once development of other areas has progressed further, we do intend to spend a larger fraction of our time on improving name pricing.  However, if new developers want to get involved with proposing, prototyping, or analyzing name price systems, we would be delighted to have the assistance.

In the meantime, practical advice is that if you want a name but it's squatted, try to contact the owner (many squatters leave contact information in the value of their names) and see if they'll let you have it.  We have heard of many cases where squatters either gave away names or sold them for very little money if the recipient actually planned to use the name rather than resell it.  If they demand money that you're unwilling to pay, consider registering a different name.  It's unlikely that the website or service you want to set up can only work with that one specific name.  Strategies for finding an unused DNS domain name or an untrademarked business name are likely to be applicable for Namecoin too.

### Is Namecoin anonymous?

Like Bitcoin, issuing Namecoin transactions is not automatically anonymous.  A thorough description of Bitcoin's poor anonymity properties is outside the scope of this FAQ.

Both Namecoin Core and Electrum-NMC support resolving Namecoin names anonymously if Tor is enabled; use Tor Browser for best results.

To register names anonymously, see our [anonymous registration]({{ "/docs/name-owners/anonymity/" | relative_url }}) documentation.

Namecoin anonymity is experimental and unaudited.  Don't rely on it more than is warranted for your safety.

### I heard that an academic study found that Namecoin is only used by 28 websites; is that really true?

This claim is derived from a study out of Princeton University, and is a result of faulty study design.  The study's design considers all `.bit` websites that contain identical content to a DNS website to be "trivial" and discounts such websites, leaving only 28 `.bit` websites that contain content that cannot be found on a DNS website.  This number seems plausible to us, though we haven't tried to reproduce the result independently.  However, the Namecoin developers have never recommended that typical `.bit` domain owners restrict their website to only `.bit`; we usually recommend that `.bit` be used **in addition to** DNS.  Reading Sec. 4.3 of the study reveals that the study authors found an additional 111 `.bit` domains that pointed to a website that was also available via DNS.  This results in a total count of 139 `.bit` domains with non-trivial content, if the definition of "trivial" doesn't include websites that are available on both Namecoin and DNS.  This count of 139 also seems plausible to us, though (again) we haven't tried to reproduce the result independently.

It is unfortunate that the Princeton study authors primarily marketed the count of 28 despite the count of 139 being a far more relevant measure.  It is also unfortunate that the study authors did not contact us to ask for peer review, as we would have easily caught that issue had we been consulted.  (Interestingly, the study authors *did* contact the CTO of a Namecoin competitor to ask for feedback on their paper prior to publishing.)

### How does Namecoin affect global heating?

Namecoin does mildly [increase Bitcoin's hashrate](#does-namecoin-influence-bitcoins-hashrate), which incentivizes greater electricity consumption by Bitcoin mining.  However, this increase in electricity consumption is quite small compared to what Bitcoin would consume without Namecoin, because Namecoin's block reward is of much lower real-world value than Bitcoin's.  Thus, Namecoin is not a major contributor to Bitcoin's electricity usage.  Specifically, of the 39 Mt CO2e net emissions produced by Bitcoin+Namecoin mining in 2021, Namecoin was responsible for ~1.2 kt (0.003%).  Of the [S&P 500 companies](https://en.wikipedia.org/wiki/Carbon_footprint_of_S%26P_500_companies), only 4 have a lower greenhouse footprint (each) than Namecoin mining.  In addition, most Bitcoin mining is powered by renewable electricity sources, so Namecoin and Bitcoin are not a major cause of global heating.  For information about Bitcoin mining's electricity usage, these articles may be informative:

* [The reports of bitcoin environmental damage are garbage (Robert Sharratt, Jan. 2019)](https://medium.com/crescofin/the-reports-of-bitcoin-environmental-damage-are-garbage-5a93d32c2d7)
* [RE: Cost of Bitcoin Mining Misconceptions (Christopher Bendiksen, Jun. 2018)](https://medium.com/coinshares/re-cost-of-mining-misconceptions-e3fcff1ce726)
* [An Honest Explanation of Price, Hashrate & Bitcoin Mining Network Dynamics (Christopher Bendiksen, Nov. 2018)](https://medium.com/coinshares/an-honest-explanation-of-price-hashrate-bitcoin-mining-network-dynamics-f820d6218bdf)
* [Beware of Lazy Research: Let’s Talk Electricity Waste & How Bitcoin Mining Can Power A Renewable Energy Renaissance (Christopher Bendiksen, Dec. 2018)](https://medium.com/coinshares/beware-of-lazy-research-c828c900b7d5)
* [Surprise: Majority of BTC Energy Sourced from Hydro / Wind / Solar (Christopher Bendiksen, Jun. 2019)](https://medium.com/coinshares/surprise-majority-of-btc-energy-sourced-from-hydro-wind-solar-49f73839aec6)
* [Bitcoin’s Hash Rate Grew More Than 80% Since June — Mostly Within China (Christopher Bendiksen, Dec. 2019)](https://medium.com/coinshares/bitcoins-hash-rate-grew-more-than-80-since-june-mostly-within-china-7444b20b2c89)
* [Everything You’ve Heard About Bitcoin Mining and the Environment is Wrong (Christopher Bendiksen, Feb. 2022)](https://blog.coinshares.com/everything-youve-heard-about-bitcoin-mining-and-the-environment-is-wrong-585931a486e5)
* [The Bitcoin Mining Network: Trends, Marginal Creation Costs, Electricity Consumption & Sources (May 2018 Update) (CoinShares Research)](https://coinshares.com/assets/resources/Research/bitcoin-mining-network-may-2018.pdf)
* [The Bitcoin Mining Network: Trends, Marginal Creation Costs, Electricity Consumption & Sources (Nov. 2018 Update) (CoinShares Research)](https://coinshares.com/assets/resources/Research/bitcoin-mining-network-november-2018.pdf)
* [The Bitcoin Mining Network: Trends, Average Creation Costs, Electricity Consumption & Sources (Jun. 2019 Update) (CoinShares Research)](https://coinshares.com/assets/resources/Research/bitcoin-mining-network-june-2019-fidelity-foreword.pdf)
* [The Bitcoin Mining Network: Trends, Average Creation Costs, Electricity Consumption & Sources (Dec. 2019 Update) (CoinShares Research)](https://coinshares.com/assets/resources/Research/bitcoin-mining-network-december-2019.pdf)
* [The Bitcoin Mining Network: Energy and Carbon Impact (Jan. 2022) (CoinShares Research)](https://pd.coinshares.com/l/882933/2022-01-25/52bz1/882933/1643724699zWkQqOwT/COINSHARES_BITCOIN_MINING_JAN22.pdf)

Both Bitcoin and Namecoin also have second-order effects that oppose global heating.  For example, Bitcoin decreases the influence of the [Petrodollar](https://bitcoinmagazine.com/culture/the-hidden-costs-of-the-petrodollar) (the Petrodollar is a major reason why the U.S. establishment opposes renewable energy sources), and Namecoin helps fight surveillance (climate activists are heavily targeted by government surveillance).

### Will Namecoin protect me from U.S. intelligence agencies like the NSA and CIA?

Short answer: It's hard to be sure, but probably not.

Long answer: There are two main privacy use cases for Namecoin: MITM-resistant TLS, and human-meaningful Tor onion services.  Namecoin TLS protects against attacks involving malicious or compromised public CA's.  Based on publicly available documents (the [2013 Snowden archive](https://github.com/iamcryptoki/snowden-archive) and the [2016 Vault 7 archive](https://wikileaks.org/ciav7p1/)), neither the NSA nor the CIA have done this class of attack; they appear to prefer to compromise the endpoints (i.e. the web browser or the HTTPS server).  This is probably because compromising the endpoints is less likely to draw attention; MITM attacks will be eventually noticed via [certificate pinning](https://www.rfc-editor.org/rfc/rfc7469.html), [certificate transparency](https://certificate.transparency.dev/), [the SSL Observatory](https://www.eff.org/observatory), and other methods, because the TLS certificate fingerprint is wrong.  It is theoretically possible that the NSA or the CIA has started doing attacks on public CA's since those archives were released, or that they were already doing such attacks but did not mention them in the documents that Snowden and WikiLeaks obtained, or that some of the other 14 U.S. intelligence agencies (which would not be covered as well by the Snowden and Vault 7 archives) are doing or have done such attacks, but we are not aware of any evidence to support these conjectures.  Namecoin onion services protect against some classes of phishing attacks (e.g. prefix grinding), but we are not aware of any evidence that U.S. intelligence agencies have done any of these attacks.  In fact, given that the FBI [seized many phishing sites](https://web.archive.org/web/20141215052738/https://www.nikcub.com/posts/onymous-part1/) in 2014 while apparently under the impression that they were the real sites, it is doubtful that the FBI even understood how these attacks work.

It is substantially more likely that Namecoin will protect you from other countries' intelligence agencies such as Iran and Saudi Arabia, as there is credible evidence that they have [compromised public CA's](https://web.archive.org/web/20140202161322/http://www.computerworld.com/s/article/9219731/Hackers_spied_on_300_000_Iranians_using_fake_Google_certificate) or [intended to](https://moxie.org/2013/05/13/saudi-surveillance.html).

We are aware of third-party projects (who use Namecoin as a dependency but are not affiliated with us) who claim that their software uses Namecoin to "protect against NSA spying"; these projects are scams trying to part you from your money.

An argument could plausibly be made that Namecoin enhances the UX of Tor onion services, and since [Tor does protect from the NSA](https://raw.githubusercontent.com/iamcryptoki/snowden-archive/master/documents/2013/20131004-theguardian__tor_stinks.pdf), Namecoin thereby protects from the NSA by decreasing the barrier to entry of using Tor.  This is not necessarily wrong, but it is a very narrow claim and should not be given more weight than due.
