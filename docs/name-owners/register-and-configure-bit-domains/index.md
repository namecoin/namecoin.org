---
layout: page
title: Register and Configure .bit Domains
---

{::options parse_block_html="true" /}

## Register a domain name with a registrar

__Please note: Use registrars only for experimental purposes, and for domain names or Namecoins you can afford to lose. A registrar can shut down operations at any time without advance warning. In this case you have no chance of retrieving your names and coins.__

Advantages:

* No need to download and run any piece of software
* No need to keep an eye on the expiration time of the names you registered
* No need to use Namecoins directly

Disadvantages:

* You don't own the domain name, i.e. you have no control over the private keys of the domain name
* You cannot prove your ownership of the name
* Registrar fees are higher than the fees for Namecoin-Qt or namecoind

Example links:

* [blockchain-dns.info](https://blockchain-dns.info/) (free domains, browser addons, proxy, web API, instant update, etc.)
* [dotbit.me](https://dotbit.me/) (updates in ? time)
* [peername.com](https://peername.com/) (updates in 7 days)

## Register a domain name using namecoind or Namecoin-Qt

### How much does it cost

You can register a .bit domain for 0.02 NMC using the Namecoin software namecoind or Namecoin-Qt. The fee consists of two parts: a) the registration fee, and b) the transaction fees for the name_new and the name_firstupdate transactions.

#### `name_new`

Registration Fee:
* 0.01 NMC

Transaction Fee:
* 0.005 NMC

Summary:
* Pre-order a domain name

Notes:
* __You still don't own the domain!__


#### `name_firstupdate`

Registration Fee:
* 0.00 NMC

Transaction Fee:
* 0.005 NMC

Summary:
* Finalize the registration. The name becomes public.

Notes:
* You own the domain during the next 36000 blocks (six months, approx.)
 
`name_update` 

Registration Fee:
* 0.00 NMC

Transaction Fee:
* 0.005 NMC

Summary:
* Renew, update, or transfer a name

Notes:
* Gives you another ~6 months of ownership

### Install the Namecoin software

Install Namecoin-Qt (GUI) or namecoind (no GUI), see [here]({{site.baseurl}}download)

Start the software and wait until it has synchronized, i.e. it has downloaded the whole blockchain.

Namecoin-Qt shows the synchronization progress on its main screen.
On namecoind use the command

```
./namecoind getinfo
```

and compare the block count with the info at one of the Namecoin blockchain explorers (e.g. [http://namecoin.webbtc.com/](http://namecoin.webbtc.com/) or [http://namecha.in/](http://namecha.in/)).

The synchronization process can take between 2 hours (fast network connection, SSD) and 50 hours (mediocre network connection, old harddisk).

For advanced users: How to Speed-up the Initial Program Start

Namecoin-Qt (GUI) is mostly self-explanatory. If you choose namecoind, however, you have to issue the two initial steps name_new and name_firstupdate manually. 

### How to register names with the graphical interface namecoin-qt

First you register a name. For example "d/example" for the website "example.bit"

Second you update it with a value. This is a text that will tell the software where is the website.

If you have a regular hosting like, godaddy, or a free hosting, like 000webhost, enter your hosting dns servers here with a json format, skip down to 'How to configure your domain'

```
{"ns": ["ns0.web-sweet-web.net", "ns1.web-sweet-web.net", "ns0.xname.org"]}
```

For zeronet support just add a 'zeronet' key to your namecoin domain.

```
{
  "zeronet": {
  "": "1EU1tbG9oC1A8jz2ouVwGZyQ5asrNsE4Vr",
  "subdomain": "1BLogC9LN4oPDcruNz3qo1ysa133E9AGg8",
  "subdomain2": "1TaLk3zM7ZRskJvrh3ZNCDVGXvkJusPKQ" }
} 
```

### How to register names with the commandline 

#### Pre-order a domain name

`<name>` is your domain name without .bit, in lowercase. For internationalized domain names, the [IDNA](http://en.wikipedia.org/wiki/IDNA) ASCII standard applies. Unicode entries are not supported.

Use one of the Namecoin blockchain explorers ( e.g. [http://namecoin.webbtc.com/](http://namecoin.webbtc.com/) or [http://namecha.in/](http://namecha.in/) ) to check if the name is available. Or find out on the command line:

```
./namecoind name_show d/<name>
```

If the name is available you can now pre-order the name with the following command:

```
./namecoind name_new d/<name>
```

The output will look like this:

```
"0e0e03510b0b0b7dbba6e301e519693f68062121b29f3cd3a6652c238360d0d0", "9f213ff4a582fd65"
```

This will reserve a name but not make it visible yet (you still don't own the domain!). Make a note of the short hex number. You will need it for the next step. Wait at least 12 blocks, which is usually between two and six hours, then finalize your registration by issuing the name_firstupdate command, see next step. It's fine to issue it earlier, the registration will be simply delayed until 12th block. (Do not shut down namecoind during the waiting time!)

If you lose the random number, you can just issue name_new again. You still need to wait 12 blocks before you can proceed. 

#### Finalize your registration

Type:

```
./namecoind name_firstupdate d/<name> <rand> '<json-value>'
```

where <rand> is the shorter hex number you got from the previous command, and <json-value> is a JSON-encoded string that contains your webserver/nameserver information, see below. Note that your JSON must be enclosed in quotes and escaped properly.

If you see this error message:

```
error: {"code":-1,"message":"previous tx used a different random value"}
```

...then try adding the long hex number:

```
./namecoind name_firstupdate d/<name> <rand> <longhex> '<json-value>'
```

(WARNING: if namecoind is not synchronized, then the getinfo command can fool you into thinking more than 12 blocks have passed. Do NOT use deletetransaction in an attempt to "fix" an unconfirmed name_firstupdate.)

(NOTE: it seems in latest namecoind versions the <longhex> parameter is required so always use the long form.)

Your registration is valid and publicly visible as soon as the name_firstupdate transaction is included in the block chain. This usually takes between 5 minutes and one hour.

You can validate it using an OpenNIC resolver (approx. 30 minutes after an update):

```
dig A <name>.bit @185.121.177.177
```

Or browse it using the OpenNIC proxy: [http://proxy.opennicproject.org/](http://proxy.opennicproject.org/)

#### Other updates

Use the `name_update` command if you want to change the JSON value.

Furthermore, name_update is used for the renewal of a registration after six months.

```
./namecoind name_update d/<name> '<json-value>'
```

Each name_update resets the expire time to the maximum value, i.e. 36000.

name_update can also be used to transfer a name to someone else. 

### How to configure your web server

Add your domain on your web hosting server, like you do it for other domains. For example, to host a yourdomain.bit you would add the following virtual host entry to your Apache configuration file.

```
<VirtualHost *:80>
  DocumentRoot /www/yourdomain.bit
  ServerName www.yourdomain.bit
</VirtualHost>
```

Most shared hosts (like Dreamhost, Hostgator, Bluehost, etc.) and control panels (like CPanel) have error checking mechanisms that prevent non-traditional TLD's from being added. The best you can do is try to add your .bit domain using the normal domain configuration interface they provide and contact their technical support if this fails. 

## How to configure your domain

Adapted from : [https://github.com/vinced/namecoin/blob/master/README.md](https://github.com/vinced/namecoin/blob/master/README.md) (text no more available at that link)

Values in the name_update command are JSON encoded. Here is a syntax validator that checks your json-value: [https://dot-bit.org/tools/domainCheck.php](https://dot-bit.org/tools/domainCheck.php)

=> use it to get proper escaping for Windows. 

### Delegate your domain and subdomains to DNS servers:

Recommended:

```
{"ns": ["ns0.web-sweet-web.net", "ns1.web-sweet-web.net", "ns0.xname.org"]}
```

Avoid ip if possible:

```
{"ns": ["1.2.3.4", "1.2.3.5"]}
```

=> Full zone control (standard way of managing domains). IP or hostname allowed.

Step required:
* Add example.bit in the same interface where you added example.com

If you can only add a domain by registering it, you can't use this method. You may use another web hosting provider. 

### Map all hosts in the domain to one IP address:

```
{"ip":"1.2.3.4", "map": {"*": {"ip":"1.2.3.4"}}}
```

Example:

```
./namecoind name_update d/<name> '{"ip":"1.2.3.4", "map": {"*": {"ip":"1.2.3.4"}}}'
```

=> No custom subdomain: domain.bit and *.domain.bit point to 1.2.3.4

Step required:
* Add example.bit in the same interface where you added example.com

If your web hosting provider don't accept unknown TLDs (.bit for example), you must use another provider. 

### Map hosts in the domain to several IP addresses:

```
{"ip":"1.2.3.4", "map": {"demo": {"ip":"1.2.3.5"}}}
```

Example:

```
./namecoind name_update d/<name> '{"ip":"1.2.3.4", "map": {"demo": {"ip":"1.2.3.5"}}}'
```

=> 1 custom subdomain: demo.domain.bit points to 1.2.3.5 and, domain.bit points to 1.2.3.4 

### Do a translation step before delegation:

```
{"translate": "bitcoin.org", "ns": ["1.2.3.4", "1.2.3.5"]}
```

in which case, foo.example.bit will be translated to foo.bitcoin.org before the DNS server will reply.

Now compatible with DNS servers using a recent NamecoinToBind. 
