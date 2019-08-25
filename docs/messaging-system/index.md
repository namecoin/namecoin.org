---
layout: page
title: Messaging System
---

{::options parse_block_html="true" /}

Draft Proposal for a Namecoin Messaging System

## Namespace

Messages use the m/ namespace

## Example

* UserA registers m/example (via a name_new, then a name_firstupdate)
* UserA updates m/example with a new value (aka: message body), and transfer it to UserB at namecoin address NAMEaddressexampleBBBB :
* * __name_update m/example "message body goes here" NAMEaddressexampleBBBB__
* UserB does a name_list, finds a new m/ name in the list, and reads the message.

# Message Formats

## Simple Format

For simple messages, no formatting is required. The whole name value is the message body.

## Mail Format

Example value:

```
{
   "to" : "NAMEaddressexampleBBBB",
   "from" : "NAMEaddressexampleAAAA",
   "subject" : "This is the subject",
   "body" : "This is the body of the message.  Lorem ipsum dolor sit amet..." 
}
```

* UserB can now reply by name_update'ing the message with a new value and transfering it to the address in the "from" field.
* Example message thread: [m/example on Namecoin Testnet](http://testnet.explorer.dot-bit.org/n/1873%7C)
* Example message with base64 encoding: [m/y on Namecoin Testnet](http://testnet.explorer.dot-bit.org/n/1871%7C)

## Notes

* Total value size limit is 1023 characters
* "to", "from", "subject", and "body" strings take away from the 1023 character limit. Perhaps "t", "f", "s", and "b" instead...
* a "name_history" type rpc command would be helpful. Basically a combo of name_debug1 and name_scan {name} 0 that also returns the value of the name as it was at each transaction listed.
* a "owner_address" field added to return of "name_list" and "name_scan" would be helpful.
* The [p/ Personal Namespace](https://wiki.namecoin.org/index.php?title=Personal_Namespace) would be a good place to list ones receiving address for messages.

