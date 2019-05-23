---
layout: page
title: Atomic Name-Trading
---

{::options parse_block_html="true" /}

Because both currency transactions and name operations share a common technical backing (the Namecoin blockchain), it is possible to construct transactions that transfer both namecoins and a name _atomically_. This means that it is guaranteed that either both transfers succeed or both transfers are not executed at all. A potentially very useful application of this technique is trading of names for namecoins, since this makes it possible to sell or buy a name in a completely trustless manner without the necessity to use escrow.

At the moment, it is possible to make such transfers only using RPC commands to namecoind directly. But in the future, hopefully an easy-to-use UI will be developed that handles all the technicalities. On this page, the basic work-flow will be described with RPC commands. We will assume as an example that Bob wants to buy 'd/my-cool-domain' from Sally for 10 NMC. The work-flow for this transaction is shown below on the test net. 

## Bob Prepares a Buy-Offer

Bob finds the domain of interest and Sally's offer to sell the domain. This could happen, for instance, via Sally using a special value for the domain or by some other channel out of the scope of this page. For instance: 

```
$ namecoind name_show d/my-cool-domain
{
  "name" : "d/my-cool-domain",
  "value" : "for sale by Sally for 10 NMC, pay to mm1mGfLEMjFPyGsbkcoYiN6yiPcBztK6Dw",
  "txid" : "00abd8282558574369038722d24c65355e1b98ca3f00d7d09cb7bea8732b598a",
  "address" : "mt2vTvKfvfb9TKfxB8ns7NVrY4cYzRs73b",
  "expires_in" : 36000
}
```

Now, Bob can prepare an atomic transaction that sends 10 NMC to Sally and transfers __d/my-cool-domain__ at the same time to himself. We assume that Sally wants the 10 NMC sent to __mm1mGfLEMjFPyGsbkcoYiN6yiPcBztK6Dw__, while Bob wants the name to be transferred to __mwKDtLZ9EHSeL8TjkZAcppsnb7M3LRhoGR__. 

To construct the transaction, Bob needs to use the "createrawtransaction" RPC command. It needs three pieces of information: 

* Currency inputs: These will be provided by Bob to pay the 10 NMC to Sally as well as the transaction fee.
* Currency outputs: 10 NMC to Sally's address and potential change back to Bob.
* A name_update operation to be performed.

In this example, these three parts will be written in seperate files for simplicity, and then these files will be used in the final RPC command. Of course, it is also possible to write everything directly onto the command-line. 

### Currency Inputs

Assuming a transaction fee of 0.005 NMC is appropriate, Bob needs to find one of his unspent inputs of at least 10.005 NMC to include in the transaction. For this, the "listunspent" command can be used. A suitable input could be this one: 

```
$ namecoind listunspent
[
  {
    "txid" : "12ed9f83b83e248e2ca19e0197933914013145981fcacc5ba47c27e60eacbfaa",
    "vout" : 0,
    "scriptPubKey" : "41040a1b1f8d3b497c7ee13e441539b9e1fe5b4ea96696a4827a74e02aa6c4df4383209de42bbc02ce90e28e5e109b9b1b7dcfd14b02449603c4320faf394719a8f1ac",
    "amount" : 974.90000000,
    "confirmations" : 2
  }
]
```

With a size of 974.9 NMC, it is large enough. It will produce __974.9 - 10.005 = 964.895 NMC__ change. The interesting data fields for our purpose are __txid__ and __vout__. They will form the currency input for "createrawtransaction", so Bob writes into the file "tx.in": 


```
[{
  "txid": "12ed9f83b83e248e2ca19e0197933914013145981fcacc5ba47c27e60eacbfaa",
  "vout": 0
}]
```

If no single unspent output is large enough, Bob could instead either include multiple inputs into this file, or produce a suitable output first by sending a sufficiently large amount to himself.

### Currency Outputs

Required currency outputs are the price paid to Sally as well as the change paid back to Bob. So Bob first creates a new address of his own to receive the change. We will use __mwAEUoA3NzSmASyWxrTK1mhsd4pFvruoXj__ for this purpose. Then, the corresponding data to be put in "tx.out" is: 

```
{
  "mm1mGfLEMjFPyGsbkcoYiN6yiPcBztK6Dw": 10.0,
  "mwAEUoA3NzSmASyWxrTK1mhsd4pFvruoXj": 964.895
}
```

### The Name Operation

The last part of the transaction that needs to be created is the name operation. It should be a name_update of __d/my-cool-domain__ to some value (can be chosen by Bob already at this stage, but it usually isn't too important for a name trade) and to Bob's address __mwKDtLZ9EHSeL8TjkZAcppsnb7M3LRhoGR__. The corresponding data to put in the last file "tx.op" is this: 

```
{
  "op": "name_update",
  "name": "d/my-cool-domain",
  "value": "thanks from Sally",
  "address": "mwKDtLZ9EHSeL8TjkZAcppsnb7M3LRhoGR"
}
```

### Finishing the Offer

With all this in place, the transaction can be created: 

```
$ namecoind createrawtransaction "cat tx.in" "cat tx.out" "cat tx.op"
0071000002aabfac0ee6277ca45bccca1f9845310114399397019ea12c8e243eb8839fed120000000000ffffffff8a592b73a8beb79cd0d7003fca981b5e35654cd2228703694357582528d8ab000100000000ffffffff0300ca9a3b000000001976a9143c4b7d4b93bc6194087bbbc422fd6cd1a40f820e88ac60ed3877160000001976a914ab96c9bfb7c55de825be7f12bd38dd25b62be02b88ac40420f00000000003f5310642f6d792d636f6f6c2d646f6d61696e117468616e6b732066726f6d2053616c6c796d7576a914ad4a0929e9c7c95910534b93ec0727058a27f2b988ac00000000
```

Now Bob can check that everything is fine: 

```
$ namecoind decoderawtransaction <large hex string>
{
  "txid" : "88180e13968cea5ea611fcb34d26b5391bdc9118f8a35fad2495b07be9e88c7b",
  "version" : 28928,
  "locktime" : 0,
  "vin" : [
    {
      "txid" : "12ed9f83b83e248e2ca19e0197933914013145981fcacc5ba47c27e60eacbfaa",
      "vout" : 0,
      "scriptSig" : {
        "asm" : "",
        "hex" : ""
      },
      "value" : 974.90000000,
      "sequence" : 4294967295
    },
    {
      "txid" : "00abd8282558574369038722d24c65355e1b98ca3f00d7d09cb7bea8732b598a",
      "vout" : 1,
      "scriptSig" : {
        "asm" : "",
        "hex" : ""
      },
      "value" : 0.01000000,
      "sequence" : 4294967295
    }
  ],
  "vout" : [
    {
      "value" : 10.00000000,
      "n" : 0,
      "scriptPubKey" : {
        "asm" : "OP_DUP OP_HASH160 3c4b7d4b93bc6194087bbbc422fd6cd1a40f820e OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "76a9143c4b7d4b93bc6194087bbbc422fd6cd1a40f820e88ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mm1mGfLEMjFPyGsbkcoYiN6yiPcBztK6Dw"
        ]
      }
    },
    {
      "value" : 964.89500000,
      "n" : 1,
      "scriptPubKey" : {
        "asm" : "OP_DUP OP_HASH160 ab96c9bfb7c55de825be7f12bd38dd25b62be02b OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "76a914ab96c9bfb7c55de825be7f12bd38dd25b62be02b88ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mwAEUoA3NzSmASyWxrTK1mhsd4pFvruoXj"
        ]
      }
    },
    {
      "value" : 0.01000000,
      "n" : 2,
      "scriptPubKey" : {
        "nameOp" : {
          "op" : "name_update",
          "name" : "d/my-cool-domain",
          "value" : "thanks from Sally"
        },
        "asm" : "NAME_OPERATION OP_DUP OP_HASH160 ad4a0929e9c7c95910534b93ec0727058a27f2b9 OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "5310642f6d792d636f6f6c2d646f6d61696e117468616e6b732066726f6d2053616c6c796d7576a914ad4a0929e9c7c95910534b93ec0727058a27f2b988ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mwKDtLZ9EHSeL8TjkZAcppsnb7M3LRhoGR"
        ]
      }
    }
  ],
  "fees" : 0.00500000
}
```

The most important pieces to check are highlighted above, but they are obviously the addresses as well as the amounts to be sent. It is also a good idea to check the calculated fees to make sure there's no typo in the amounts resulting in exorbitantly high fees.

When everything looks fine, Bob can sign his inputs to the transaction (after unlocking the wallet if it is password-protected): 

```
$ namecoind signrawtransaction <large hex string>
{
  "hex" : "0071000002aabfac0ee6277ca45bccca1f9845310114399397019ea12c8e243eb8839fed12000000004948304502202131c98c98a3dfe19713ec0e48917a502063028766abf292b46fb8e8a96d80df022100f22198c86e814eff3a2562a36de5249a425c08080cb174eace7da9529e6e16b801ffffffff8a592b73a8beb79cd0d7003fca981b5e35654cd2228703694357582528d8ab000100000000ffffffff0300ca9a3b000000001976a9143c4b7d4b93bc6194087bbbc422fd6cd1a40f820e88ac60ed3877160000001976a914ab96c9bfb7c55de825be7f12bd38dd25b62be02b88ac40420f00000000003f5310642f6d792d636f6f6c2d646f6d61696e117468616e6b732066726f6d2053616c6c796d7576a914ad4a0929e9c7c95910534b93ec0727058a27f2b988ac00000000",
  "complete" : false
}
```

Finally, Bob can now again check the signed transaction with "decoderawtransaction", although this is not strictly necessary. He can now pass the partially-signed transaction (the hex string above) to Sally. 

## Sally Accepts the Offer

After Sally receives the partial transaction from Bob, she can check that everything is fine: 

```
$ namecoind decoderawtransaction <large hex string>
{
  "txid" : "92a50d2495d66cbfb13ae87deaec059ab605a7bf737b10935f9e0f80065debac",
  "version" : 28928,
  "locktime" : 0,
  "vin" : [
    {
      "txid" : "12ed9f83b83e248e2ca19e0197933914013145981fcacc5ba47c27e60eacbfaa",
      "vout" : 0,
      "scriptSig" : {
        "asm" : "304502202131c98c98a3dfe19713ec0e48917a502063028766abf292b46fb8e8a96d80df022100f22198c86e814eff3a2562a36de5249a425c08080cb174eace7da9529e6e16b801",
        "hex" : "48304502202131c98c98a3dfe19713ec0e48917a502063028766abf292b46fb8e8a96d80df022100f22198c86e814eff3a2562a36de5249a425c08080cb174eace7da9529e6e16b801"
      },
      "value" : 974.90000000,
      "sequence" : 4294967295
    },
    {
      "txid" : "00abd8282558574369038722d24c65355e1b98ca3f00d7d09cb7bea8732b598a",
      "vout" : 1,
      "scriptSig" : {
        "asm" : "",
        "hex" : ""
      },
      "value" : 0.01000000,
      "sequence" : 4294967295
    }
  ],
  "vout" : [
    {
      "value" : 10.00000000,
      "n" : 0,
      "scriptPubKey" : {
        "asm" : "OP_DUP OP_HASH160 3c4b7d4b93bc6194087bbbc422fd6cd1a40f820e OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "76a9143c4b7d4b93bc6194087bbbc422fd6cd1a40f820e88ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mm1mGfLEMjFPyGsbkcoYiN6yiPcBztK6Dw"
        ]
      }
    },
    {
      "value" : 964.89500000,
      "n" : 1,
      "scriptPubKey" : {
        "asm" : "OP_DUP OP_HASH160 ab96c9bfb7c55de825be7f12bd38dd25b62be02b OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "76a914ab96c9bfb7c55de825be7f12bd38dd25b62be02b88ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mwAEUoA3NzSmASyWxrTK1mhsd4pFvruoXj"
        ]
      }
    },
    {
      "value" : 0.01000000,
      "n" : 2,
      "scriptPubKey" : {
        "nameOp" : {
          "op" : "name_update",
          "name" : "d/my-cool-domain",
          "value" : "thanks from Sally"
        },
        "asm" : "NAME_OPERATION OP_DUP OP_HASH160 ad4a0929e9c7c95910534b93ec0727058a27f2b9 OP_EQUALVERIFY OP_CHECKSIG",
        "hex" : "5310642f6d792d636f6f6c2d646f6d61696e117468616e6b732066726f6d2053616c6c796d7576a914ad4a0929e9c7c95910534b93ec0727058a27f2b988ac",
        "reqSigs" : 1,
        "type" : "pubkeyhash",
        "addresses" : [
          "mwKDtLZ9EHSeL8TjkZAcppsnb7M3LRhoGR"
        ]
      }
    }
  ],
  "fees" : 0.00500000
}
```

It is also crucial to check which inputs Bob has prepared for her to sign, so that she doesn't end up sending something she doesn't intend to send. I'm not completely sure what would be the easiest and safest way to ensure that the transaction from Bob is not malicious. A possible way to guard against this could be to look up the address holding the sold name, export its private key, and use "signrawtransaction" with this private key as optional argument.

When everything is fine, Sally can sign her parts of the input: 

```
$ namecoind signrawtransaction <large hex string>
{
  "hex" : "0071000002aabfac0ee6277ca45bccca1f9845310114399397019ea12c8e243eb8839fed12000000004948304502206114a73cb307e17ec0d4c5d7caa9d87a2136da511a94b7bd8027aab726b2e67a022100bcebf433a9fa13d50c602f0cf54e1e7ab2ac851ca1ed9017ecf95d7dc02e25e401ffffffff8a592b73a8beb79cd0d7003fca981b5e35654cd2228703694357582528d8ab00010000008a47304402202620285799e7314e3da0573fe473354b6bf0eb29640254f073a124fe1454dc9d022019e4884853a5aba76059ff2bd23e6e5b6e8c607df0e46e83cbfc2ea26e67da4a01410467d20dd8d4c08674a13ea14540f09d62389c7d96bed805f5bbbb4079210dbf2ede9eeced9ab638a8d6ed01a909b91473e78a1ff65ba3de19b38203cf22c9d12dffffffff0300ca9a3b000000001976a9143c4b7d4b93bc6194087bbbc422fd6cd1a40f820e88ac60ed3877160000001976a914ab96c9bfb7c55de825be7f12bd38dd25b62be02b88ac40420f00000000003f5310642f6d792d636f6f6c2d646f6d61696e117468616e6b732066726f6d2053616c6c796d7576a914ad4a0929e9c7c95910534b93ec0727058a27f2b988ac00000000",
  "complete" : true
}
```

The transaction is now completely signed (when "complete: true" is returned). Sally can check it again, and if everything is fine, she can relay it to the network: 

```
$ namecoind sendrawtransaction <large hex string>
bdf33963b3635d41d597e07805ee8f0f8e637e7e09e46ff5117931e7ffdb8550
```

That's it. When the transaction is confirmed, the trade is completed. However, there's no risk to either Bob or Sally that the trade could ever be done only partially, i. e., someone cheat the other. 
