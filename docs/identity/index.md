---
layout: page
title: Identity
---

{::options parse_block_html="true" /}

Namecoin ID: Manage your online identity

## Description

The purpose of id/ is to manage a public online identity.

* Any application can retrieve data associated with an identity.

* An identity can be composed of email addresses, bitcoin/namecoin/*coin addresses, gpg key (fingerprint), xmpp address, and other things.

* Namecoin addresses associated with the identity (either holding the name or via the 'signer' field) can be used to sign data on behalf of your identity, which can be used for online logins and other applications.

* Each application type that want to store data associated with an identity must be added in the registered applications list with a description on how data will be formatted.

## Syntax

* namespace : id/
* name :
  * max 255 characters,
  * lowercase,
  * a-z, 0-9
  * dash : max one space between other characters, not as first or last
  * prefixed with "id/"

Regexp (to be confirmed):

```
^id/[a-z0-9]+([-]?[a-z0-9])*$
```
* value : 520 characters max., JSON-encoded

## Examples

__Fetching all data from the identity of "khal" :__
```
$ namecoind name_show "id/khal"
{
  "email":    "khal@dot-bit.org",
  "bitcoin":  "1J3EKMfboca3SESWGrQKESsG1MA9yK6vN4",
  "namecoin": "N2pGWAh65TWpWmEFrFssRQkQubbczJSKi9"
}
```

__Fetching bitcoin data from the identity of "khal" :__
```
$ namecoind name_jsonget "id/khal" bitcoin
{
  "bitcoin": "1J3EKMfboca3SESWGrQKESsG1MA9yK6vN4"
}
```

## Registered Applications

The following fields may be part of the JSON value of an identity name to specify a multitude of different data about an online identity: 

### `name`
Name of the identity owner. 

Rules:
* A real name (first and last name) or pseudonym. 

Examples:

```
{
  "name": "Daniel Kraft"
}
```

### `email`
Store an email address for the identity.

Possible formats:
* an email address, or
* an array of addresses, or
* an object with labels (label "default" is required)

Examples:

```
$ namecoind name_show id/khal
{
  "email": "khal@dot-bit.org"
}
```
```
$ namecoind name_show id/khal
{
  "email":
    ["khal@dot-bit.org",
      "example@otherplace.info"]
}
```
```
$ namecoind name_show id/khal
{
  "email":
    {
      "default": "khal@dot-bit.org",
      "business": "khal@example.com"
    }
}

```

### `country`
A country is the sovereign nation in which a person is located. 

Rules:
The country is identified by the two-letter ISO 3166 code. 

Examples:

```
$ namecoind name_show id/khal
{
  "country": "AT"
}
```

### `locality`
A locality is a defined place within the region in which a person is located. Sometimes also called a "city", "town", or "village". 

Possible formats:

* a city, or
* an array of cities

Examples:

```
$ namecoind name_show id/khal
{
  "locality": "Vienna"
}
```
```
$ namecoind name_show id/khal
{
  "locality": ["Vienna","Вена"]
}

```

### `photo_url`
A photograph provides a pictorial representation of a person. 

A photograph comes in form of URL

Examples:
```
$ namecoind name_show id/khal
{
  "photo_url": "http://www.saint-andre.com/images/stpeter.jpg"
}
```

### `description`
It can be helpful to provide a natural-language description of a person. 

Examples:
```
$ namecoind name_show id/khal
{
  "description": "I'm Bitcoin fanatic \:)"
}
```

### `hobby`
A hobby is a non-work activity that a person enjoys pursuing. 

Possible formats:
* an array

Examples:
```
$ namecoind name_show id/khal
{
  "hobby": ["cryptography","cryptocurrency","blogging","geek","hiking"]
}
```

### `birthday`
A date in which a person was born. 

Possible formats:

* year/month/day
* year/month
* year

Examples:

```
$ namecoind name_show id/khal
{
  "birthday": "1990/03/27"
}
```

### `gender`
Gender is the self-defined gender of a person 

This is not limited to "male" and "female", although those are the expected values in most instances 

Examples: 
```
$ namecoind name_show id/khal
{
  "gender": "male"
}
```

### `weblog`
URI at which a person or other entity maintains a weblog. 

Rules:
* Comes in form of URL.

Examples: 
```
$ namecoind name_show id/khal
{
  "weblog": "http://www.saint-andre.com/blog/"
}
```

### `namecoin`
Namecoin address of the identity owner. 

Possible formats:

* a namecoin address, or
* an array of namecoin addresses, or
* an object of namecoin addresses with labels (label "default" is required)

Examples:
```
$ namecoind name_show id/khal
{
  "namecoin": "N2pGWAh65TWpWmEFrFssRQkQubbczJSKi9"
}
```
```
$ namecoind name_show id/khal
{
  "namecoin":
    ["N15mJsVMHNtVDedDnD8vu82M5hCfn3nJWq",
      "N2pGWAh65TWpWmEFrFssRQkQubbczJSKi9"]
}
```
```
$ namecoind name_show id/khal
{
  "namecoin":
    {
      "default": "N15mJsVMHNtVDedDnD8vu82M5hCfn3nJWq",
      "donation": "N2pGWAh65TWpWmEFrFssRQkQubbczJSKi9"
    }
}
```

### `bitcoin`
Bitcoin address of the identity owner. 

See "namecoin" above.

### `bitmessage`
Public Bitmessage address associated to the identity. 

A valid Bitmessage address.

Examples:
```
{
  "bitmessage": "BM-orkCbppXWSqPpAxnz6jnfTZ2djb5pJKDb"
}
```

### `xmpp`
XMPP/Jabber contact. 

```
{
  "xmpp": "jabber@dot-bit.org"
}
```

Rules: 
* A valid XMPP address. 

### `otr`
OTR public key fingerprint. 

Rules:
* Fingerprint or array of valid fingerprints. 
* Each fingerprint is a hex string, case insensitive and may contain spaces for readability that are ignored. 

Examples:
```
{
  "otr": "D2A5E5E0704A117D0B43C7FC0caee72C8FE85CA9"
}
```
```
{
  "otr":
    ["D2A5 E5E0 704A 117D 0B43 C7FC 0cae e72C 8FE8 5CA9",
      "some other fingerprint"]
}
```

### `gpg`
GPG keys and fingerprints. 

See the special section below.

### `signer`
Addresses allowed to "sign" on behalf of this identity for certain applications. The address holding the name is always implied to be a "signer". 

Namecoin address or array of Namecoin addresses. 

Examples:

```
$ namecoind name_show id/domob
{
  "signer": "NDgQyGeyTdoopvbUD14GR536FmDiv6esuU"
}
```
```
{
  "signer":
    ["NDgQyGeyTdoopvbUD14GR536FmDiv6esuU",
      "NBNfCNHWa2HZqnjVSpavcUXRefUbNPP7Jj"]
}
```

## GPG
### Fingerprints
Secure keys take a lot of space and it is best to store fingerprints/hashes on the blockchain. 

### `v`
Data format version. Currently, there is only one version. 

Example:
```
{
  "v":"pka1"
}
```

### `fpr`
OpenPGP fingerprint 

Example:
```
{
  "fpr":"0123456789012345678901234567890123456789"
}
```

### `uri`
URI where the key can be obtained, most implementations add link to fingerprint. Optional 

Example:
```
{
  "uri":"http://www.example.com/user.key"
}
```

### Example: Data Format

```
   "gpg": {
       "v": "pka1",
       "fpr": "0123456789abcde0123456789abcde0123456789",
       "uri": "http://www.example.com/user.key"
   }
```

### Example: Importing a key to GnuPG
Search for someone's "id/<name>" name using namecoin 

```
shell$ namecoind name_list id/<name> 1
[
    {
    "name": "id/<name>",
    "value": {
    "gpg": {
    "v": "pka1",
    "fpr": "0123456789abcde0123456789abcde0123456789",
    "uri": "http://www.example.com/user.key"
    }
    },
    "txid": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "expires_in": 11234
    }
]
```

Import the key into gpg 

```
shell$ wget -pO - http://www.example.com/user.key | gpg --import
gpg: key xxxxxxxx: public key "p/<name>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
```

Verify the fingerprint matches 

```
shell$ gpg --fingerprint p/<name> 
pub   4096R/xxxxxxxx 2011-06-23 [expires: 2013-06-22]
      Key fingerprint = 0123 4567 89ab cde0 1234  5678 9abc de01 2345 6789
uid                  p/<name>
sub   4096R/xxxxxxxx 2011-06-23 [expires: 2013-06-22]
shell$
```

### Keys

Mapping OpenPGP[1](http://www.rfc-ref.org/RFC-TEXTS/2440/chapter6.html#sub2) Message Headers/Footers into Namecoin: 

#### PGPK

openPGP header/footer:
```
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: Namecoin-Test 0.0.1 
 
(ASCII armored public key)
-----END PGP PUBLIC KEY BLOCK-----
```

Notes:
```
{
  "PGPK":"(the ASCII armored public key)"
}
```
Example: [p/example on testnet](http://testnet.explorer.dot-bit.org/n/1877%7C)

#### PGPM

openPGP header/footer:
```
-----BEGIN PGP MESSAGE-----
Version: Namecoin-Test 0.0.1 
 
(ASCII armored message)
-----END PGP MESSAGE-----
```

Notes: 
* for creating [secure messages]({{site.baseurl}}docs/messaging-system)

```
{
  "PGPM":"(ASCII armored message)"
}
```

#### PGPS

openPGP header/footer:
```
-----BEGIN PGP SIGNATURE-----
Version: Namecoin-Test 0.0.1 
 
(ASCII armored signature)
-----END PGP SIGNATURE-----
```

Notes: 
```
{
  "PGS":"(the ASCII armored signature)"
}
```

#### PGPM-X-Y

openPGP header/footer:
```
-----BEGIN PGP MESSAGE, PART X/Y-----
Version: Namecoin-Test 0.0.1 
 
(ASCII armored message part)
-----END PGP MESSAGE, PART X/Y-----
```

Notes:
```
{
  "PGM-1-2":"(the ASCII armored message part)"
}
```

#### PGPM-X

openPGP header/footer:
```
-----BEGIN PGP MESSAGE, PART X-----
Version: Namecoin-Test 0.0.1 
MessageID: 32-character-string-ID
 
(ASCII armored message part)
-----END PGP MESSAGE, PART X-----
```

Notes: 
```
{
  "PGM-2":"(the ASCII armored message part)",
  "mID":"32-character string of printable characters"
}
```
* Requires the MESSAGE-ID Armor Header



* Example: [m/m on testnet](http://testnet.explorer.dot-bit.org/n/1860%7C)
* Example: [m/n on testnet](http://testnet.explorer.dot-bit.org/n/1838%7C)


## Known Implementations

[Bitmessage](https://bitmessage.org/)
* Bitmessage can retrieve addresses from Namecoin identities if they specify an address. 

Applications:
* `bitmessage`

[NameID](https://nameid.org/)
* Can display lots of fields for identities, and you can use the site's support for signing with either the name's address or one of the "signer" addresses to log into an OpenID provider. 

Applications: 
* `name`
* `email`
* `bitcoin`
* `namecoin`
* `xmpp`
* `bitmessage`
* `gpg`
* `signer`

[Pidgin OTR+NMC](https://dot-bit.org/forum/viewtopic.php?f=2&t=1045)
* A proof-of-concept fork of the Pidgin OTR plugin that allows to verify fingerprints against Namecoin identities. 

Applications:
* `otr`
