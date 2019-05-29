---
layout: page
title: Voice.bit
---

{::options parse_block_html="true" /}

__Deprecated: This protocol or feature has been deprecated due to lack of use.__

## Overview

Voicedotbit is a GUI for namecoin written in c++ using gtkmm-2.4 for the user interface. Eventually it will be a voice onion router using namecoin for identity management. The namecoin related features are fully functional. It connects to namecoind using JSON-RPC calls. On the first startup, it tries to self-configure by reading USER/.namecoin/bitcoin.conf. Failing this, it guesses default values. 

## Features

* Register names
* Update names
* Send NMC
* View addresses
* Manage/update names
* View transactions
* View network info
* Configure namecoind connection
* Buddy List (doesn't do anything right now)

## Platform

So far, it has only been tested on Ubuntu 10.04. Other Linux distributions should work. See the INSTALL file for details. 

### Dependencies

* libssl (openssl)
* libcurl
* libasio c++ networking library
* boost c++ libraries (1.40 - linking to 1.42 doesn't work)
* sqlite3
* gtkmm

## Name/Value Format

(This is a work in progress. Comments are welcome on the discussion page.)

It's probably impossible to enforce a namespace since transaction confirmation doesn't care about whether the namespace has an appropriate value. Informally, "v/" will be used.

The value type would vary slightly, depending on the type of user. 

```
{
  "version": 1,
  "subtype": "user",
  "public_signing_key": "MWRmN3M3Nmp2OGEzbnY0MDF2TlJTMFBzNTY1MVZma3M=",
  "public_encryption_key": "TVdSbU4zTTNObXAyT0dFemJuWTBNREYyVGxKVE1GQno=",
  "relays": [ "v/egalitarian" , "d/niceguy" , "v/charity" ]
} 
```

Note: The number of relays is variable.

```
{
  "version": 1,
  "subtype": "relay",
  "public_signing_key": "MWRmN3M3Nmp2OGEzbnY0MDF2TlJTMFBzNTY1MVZma3M=",
  "public_encryption_key": "TVdSbU4zTTNObXAyT0dFemJuWTBNREYyVGxKVE1GQno=",
  "address": "70.60.50.40:9655",
  "btc_address": "1FhMcuy9nYGgNtgb7Rf4CgEYZe6asfJboU",
  "nmc_address": "NDc579WNW9TTsayZ7K25bgrfAQ1v3ncoFz"
}
```

Note: A single entry cannot contain both relay and user information. Publishing an address would compromise a user's identity. A user and a relay could both operate some the same host. If Alice wants to be both a user and a relay, she could register two names: d/alice and d/princealbert. She would configure d/alice as a user, d/princealbert as a relay and keep her ownership of the d/princealbert confidential. 

## Current Release

* Deb package: [http://jailcity.com/voicedotbit/voicedotbit_0.1_i386.deb](http://jailcity.com/voicedotbit/voicedotbit_0.1_i386.deb)
* GitHub: [https://github.com/teathsch/voicedotbit](https://github.com/teathsch/voicedotbit)
* Project Web site: [http://jailcity.com/voicedotbit/](http://jailcity.com/voicedotbit/)
* Please send any feedback to [teathsch@jailcity.com](mailto:teathsch@jailcity.com)
