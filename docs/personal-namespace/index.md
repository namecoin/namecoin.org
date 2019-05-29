---
layout: page
title: Personal Namespace
---

{::options parse_block_html="true" /}

__Deprecated: This protocol or feature has been deprecated in favor of [Identity]({{site.baseurl}}docs/identity) namespace. Convert to an NEP after NEP protocol is resolved.__

The Personal Namespace is __p/__

The purpose of __p/__ is to "include a personal handle namespace mapping handles to public keys and personal address data."[[1]](https://github.com/vinced/namecoin/blob/master/README.md)

## Format

* Raw format
* JSON format

"i" - identity name 

## PGP

Mapping OpenPGP[[2]](http://www.rfc-ref.org/RFC-TEXTS/2440/chapter6.html#sub2) Message Headers/Footers into Namecoin: 

### `PGPK`

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

### `PGPM`

openPGP header/footer:

```
-----BEGIN PGP MESSAGE-----
Version: Namecoin-Test 0.0.1 
 
(ASCII armored message)
-----END PGP MESSAGE-----
```

Notes:
* for creating secure [messages]({{site.baseurl}}/docs/messaging-system)

```
{
  "PGPM":"(ASCII armored message)"
}
```

### `PGPS`

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

### `PGPM-X-Y`

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

### `PGPM-X`

openPGP header/footer:

```
-----BEGIN PGP MESSAGE, PART X-----
Version: Namecoin-Test 0.0.1 
MessageID: 32-character-string-ID
 
(ASCII armored message part)
-----END PGP MESSAGE, PART X-----
```

Notes:
* Requires the MESSAGE-ID Armor Header

```
{
  "PGM-2":"(the ASCII armored message part)",
  "mID":"32-character string of printable characters"
}
```


* Example: [m/m on testnet](http://testnet.explorer.dot-bit.org/n/1860%7C)
* Example: [m/n on testnet](http://testnet.explorer.dot-bit.org/n/1838%7C)

## Large Keys

Many keys are too large to fit in the block chain. The following format may be used to link to a large key. 

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

URI where the key can be obtained

Example:

```
{
  "uri":"http://www.example.com/user.key"
}
```

URI where the key can be obtained 

### Example: Data Format

`{"v":"pka1","fpr":"0123456789abcde0123456789abcde0123456789","uri":"http://www.example.com/user.key"}`

### Example: Importing a key to GnuPG

Search for someone's "p/<name>" name using namecoin

```
shell$ namecoind name_list p/<name> 1
[
    {
        "name" : "p/<name>",
        "value" : "{\"v\":\"pka1\",\"fpr\":\"0123456789abcde0123456789abcde0123456789\",\"uri\":\"http://www.example.com/user.key\"}",
        "txid" : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "expires_in" : 11234
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

## Notes

How about space for a BTC receiving address? 
