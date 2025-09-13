---
layout: post
title: "Introducing Encasha: Off-Chain SSHFP Records"
author: Jeremy Rand
tags: [News]
---

Since Encaya now supports off-chain `TLSA` records (used for TLS server authentication), this begs a question: can something similar be done for `SSHFP` records (used for SSH server authentication)?

In principle, the main things we would need to pull this off are:

1. Some way to embed a blob of data inside an SSH public key.
2. Some way for that blob to get passed to code we control (*during* the SSH handshake).
3. Some way to mark a public key as trusted (also *during* the SSH handshake).

For requirement 1, guess what? [SSH has certificates](https://www.ietf.org/archive/id/draft-miller-ssh-cert-01.html). SSH certificates are surprisingly rarely used, but they are a thing. SSH certificates [can have extensions](https://www.ietf.org/archive/id/draft-miller-ssh-cert-01.html#name-certificate-extensions) in them.

For requirement 2 and 3, the [OpenSSH `KnownHostsCommand` config option](https://man.openbsd.org/ssh_config#KnownHostsCommand) does exactly this.

Thus, Encaya now has a younger sister: Encasha. Encasha has essentially the same threat model and scalability properties as off-chain TLSA records with Encaya. Most of the code that I had written for off-chain TLSA records has been split off into a library, which is now called by both Encaya and Encasha.

Huge kudos are due to the OpenSSH developers for making this much less painful than any of the TLS implementations I've ever worked with. If only HTTP over SSH were a thing....

Encasha should be released soon; [the code is on GitHub](https://github.com/namecoin/encasha) if you'd like to play with it early.

This work was funded by NLnet Foundation's NGI0 Core Fund.
