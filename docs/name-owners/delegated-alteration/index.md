---
layout: page
title: Delegated Alteration (for name owners)
---

{::options parse_block_html="true" /}

**Delegated alteration** is an anti-theft mechanism supported by Namecoin.  It allows a key to be authorized to alter the value of a name, but not transfer the name to a new owner.  Example use cases:

* You want to require authorization from multiple persons (e.g. via multisig) in order to transfer a name, but you want a single person to be able to alter the name's value.
* You want to require a hardware wallet (e.g. Trezor) in order to transfer a name, but you want to alter the name's value on your regular computer.
* You want to require your regular computer in order to transfer a name, but you want to allow a publicly facing server to alter the name's value automatically (e.g. for dynamic DNS functionality such as provided by DyName).

To use delegated alteration, you register two names rather than one.  The first name is in the `d/` namespace as usual, and is the one that determines what domain name points to your name.  The second name is in the `dd/` namespace (`dd` stands for "domain data"), and can be any name you like (but shorter names will incur lower transaction fees).  Let's say that you register `d/valuablename` and `dd/useless`.  You then set the value of `d/valuablename` to `{"import":"dd/useless"}`.  You can then set the value of `dd/useless` to `{"ip":"123.45.67.89"}`.  The result is that the domain name `valuablename.bit` will point to the IPv4 address `123.45.67.89`.  The owner of `dd/useless` will be able to change the IPv4 address (or any other DNS records associated with the name), but will **not** be able to permanently steal `valuablename.bit`.  If `dd/useless` gets stolen, the owner of `d/valuablename` can register a new `dd/` name, change the value of `d/valuablename` to point to the new `dd/` name, and the thief is left with a worthless `dd/` name.  There is no requirement that the `d/` name and the `dd/` name be held by the same wallet; e.g. you can store the `d/` name with multisig or a hardware wallet while storing the `dd/` name on an unencrypted hot wallet.

You can also use **delegated partial alteration**.  This prevents the `dd/` name from setting certain JSON fields.  For example, you can set a `tls` field in the `d/` name (alongside the `import` field), which will prevent the `dd/` name from setting a `tls` field for that domain name.  In this example, if the `dd/` name is stolen, the thief could change the IP address but not the TLS fingerprint, which would prevent the thief from performing MITM attacks (even before you switch to a new `dd/` name).  If the thief does change the IP address to a server she controls, then visitors to the website will get a TLS error, which converts a MITM attack (very bad) to a DoS attack (much less bad).

You can also combine delegated alteration with delegated partial alteration by using recursive `import` fields.  For example, you could register a `d/` name that imports a `dd/` name, which specifies both a TLS fingerprint and another `dd/` name to import.  The latter `dd/` name would be prevented from specifying a TLS fingerprint, and any thief who steals either `dd/` name would be prevented from transferring the domain name.
