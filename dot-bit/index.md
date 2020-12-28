---
layout: page
title: Dot-Bit
---

{::options parse_block_html="true" /}

Dot-Bit-enabled websites end with ".bit" instead of ".com" or something similar. Dot-Bit uses Bitcoin technology to decentralize and free website addresses, just like Bitcoin decentralizes and frees money.

### What's DNS? And why does Dot-Bit matter?

DNS is like the phonebook of the Internet. When you type in www.google.com, your computer asks a digital phonebook on the Internet (called a DNS server) what the address means, and gets back a series of numbers like 74.125.239.19. The problem is that these DNS servers are controlled by governments and large corporations, and could abuse their power to censor, hijack, or spy on your Internet usage. This happens on a regular basis across the world, including in countries like China as well as in countries like the United States.

Dot-Bit-enabled websites are immune to these problems, because instead of the phone book being a corporation or government, the digital phonebook is on __your own computer__. Bitcoin technology ensures that every user in the world has the same phonebook data on their computer, without anyone being able to illegitimately change that phonebook data.

### Censorship-Resistance

With standard DNS, the digital phonebook can falsely claim "there's no website here"; this is what SOPA would have mandated in the U.S. Dot-Bit cannot easily be censored, for the same reasons that no one can easily prevent you from spending bitcoins.

### Security

With standard DNS, the digital phonebook can direct you to fake websites that steal your passwords (or worse). So-called experts claim that HTTPS (the "secure" website protocol) prevents this kind of hijacking, but it doesn't. Dot-Bit prevents hijacking __for real__. How can this work? Standard HTTPS allows CA's, or "certificate authorities" (run by governments or large corporations), to vouch for the legitimacy of a website. If a single CA (there are thousands) gets broken into by criminals, makes a mistake, or is forced by a government, they can issue fraudulent credentials that allow someone to impersonate any website. Dot-Bit's decentralized digital phonebook does the security job that a CA would normally do, without relying on a CA; this means that no one can easily hijack Dot-Bit-enabled websites for the same reason that no one can easily steal your bitcoins. It also means that Dot-Bit-enabled HTTPS is __free__ for website owners.

### Privacy

With standard DNS, the digital phonebook server and anyone watching you talk to it can deduce which websites you're visiting. Sound creepy? Dot-Bit's digital phonebook doesn't generate any network traffic when you lookup a website address, which improves your privacy. (Obviously, Tor provides even better privacy.)

### Lightning-Fast

With standard DNS, when a website switches configuration (e.g. due to moving datacenters), the phonebook doesn't notice for about 24 to 48 hours. This causes unnecessary downtime in many circumstances. Dot-Bit's phonebook updates within 40 minutes on average with default settings. Standard DNS servers also take time to look up a website's information, which can take 100 milliseconds or more if you're unlucky. Since Dot-Bit keeps the phonebook on your own computer, looking up a website usually takes under 3 milliseconds. __Dot-Bit makes websites load faster and reduces website downtime.__

### DNS for Tor and I2P Anonymity Networks

Dot-Bit's digital phonebook entries can point to anonymously hosted websites on the Tor and I2P anonymity networks. Unlike Tor's .onion domains, which consist of random letters and numbers, or I2P's .i2p domains, which can point to different websites for different people, Dot-Bit enables proper, human-readable, deterministically resolvable DNS for Tor- and I2P-hosted services. Note that while Dot-Bit may be able to hide the location and IP address of a domain owner if the domain was registered using Tor, it will probably still be possible to link the domain owner to his or her other transactions (e.g. withdrawing funds from an exchange), which could reveal the owner's identity.

### Free and Open Source Software

Dot-Bit is powered by Namecoin, a free and open source software project based on Bitcoin, and other free and open-source software packages. Dot-Bit software can be audited by anyone, and historically security issues have been resolved promptly without incident. You should demand nothing less from any software to which you entrust your security.

### Sound Awesome?

[Learn how to browse Dot-Bit-enabled websites.]({{site.baseurl}}dot-bit/browsing-instructions) And if you have your own website, [learn how to enable it]({{site.baseurl}}docs/name-owners) for the improved censorship-resistance, security, privacy, and speed that Dot-Bit offers.
