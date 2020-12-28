---
layout: post
title: Stream Isolation for Namecoin Name Lookups
author: Jeremy Rand
tags: [News]
---

The documentation for using Namecoin for name lookups with Tor (via ncprop279) includes a warning about stream isolation.  Specifically, it states that while TCP connections issued by the application (e.g. Tor Browser) will be stream-isolated as usual, stream isolation will *not* be applied to whatever network traffic might be induced by the Namecoin lookup.  As a result, our documentation recommends against using Electrum-NMC with ncprop279, since Electrum-NMC will produce network traffic on each lookup.  Our documentation instead recommends Namecoin Core or ConsensusJ-Namecoin's leveldbtxcache mode, neither of which produce any network traffic per lookup.  However, this situation is non-ideal; Electrum-NMC has some very real advantages, and it's a shame that we can't recommend it for this purpose.  Can we do better?

For background, stream isolation is a little-known but highly important feature in Tor, which prevents different TCP connections from different activities from sharing a single Tor circuit.  Imagine if this weren't the case.  Keith, who runs an exit relay (or wiretaps one) could easily observe that Ed visited a website of a restaurant in Hawaii, and also visited the website of the WikiLeaks submission system.  Keith doesn't need to know who Ed is or what his real IP address is; Keith has learned that someone in Hawaii is likely a WikiLeaks source, which is valuable information.  In other words, Ed has only achieved *pseudonymity*, i.e. his real name and IP address are hidden, but all of his activities are linkable to a single pseudonym.  Stream isolation unlinks these activities, so that Keith instead sees that someone accessed a Hawaiian restaurant's website and also sees that someone accessed WikiLeaks's submission system, but doesn't have any idea if they are the same person.  Stream isolation enables users to be *anonymous* rather than *pseudonymous*.

How does stream isolation work in Tor?  Applications can decide which TCP connections can share a circuit without leaking private information, and they communicate this to Tor by setting the SOCKS5 username and password fields.  Tor makes sure that any two TCP connections that have different SOCKS5 username+password values will never share a circuit.  (Technically I'm oversimplifying here; I'll come back to this.)  So, in order for this to work properly with Namecoin, we need to make sure that the Namecoin software is able to access the SOCKS5 username and password that the application used when talking to Tor, and pass this (or derivative data, see below) through to Tor when Electrum-NMC is doing lookups.  In practice, this means that every piece of software in the chain (starting with Tor's control port, which talks to StemNS, and ending with aiorpcX, which is the library used by Electrum-NMC to open the TCP connections via Tor's SOCKS port) must be patched to preserve the SOCKS5 username and password that the application used, and pass it through to the next piece of software in the chain.

So, let's look at how we handled this, starting at the end of the chain and working backwards to the beginning.

## aiorpcX

aiorpcX is the network library used by Electrum.  It has its own SOCKS5 implementation, which already supports username/password authentication, so you might think there's nothing to patch here.  However, observing Bitcoin Core's behavior yields a hint for how we can improve aiorpcX.

Bitcoin Core (and, by extension, Namecoin Core) open each peer connection using a random SOCKS5 username and password.  The effect is that each peer connection will go over its own Tor circuit.  This has several advantages.  It improves Sybil-resistance (by making it impossible for a single malicious Tor exit relay to control a Bitcoin node's view of the blockchain).  It also avoids situations where a malicious user gets a Tor exit banned by most of the Bitcoin network, and then other users who end up on that Tor exit can't connect.  These advantages are beneficial even without worrying about privacy specifically.

I submitted a patch to aiorpcX that allows applications to request that a random SOCKS5 username+password be used per connection.  This makes things quite a bit cleaner.  The patch has been merged by Neil.

## Electrum-NMC

Patching Electrum-NMC to use the above aiorpcX feature was fairly straightforward.  However, I also needed to add an RPC argument to `name_show`, so that the caller can specify a "stream isolation ID", which has a similar role as the SOCKS5 username+password in the Tor SOCKS port.  Electrum-NMC executes `name_show` with a different server connection for each unique stream isolation ID that it is passed.

You may be wondering why we're not just passing through the stream isolation ID to aiorpcX's SOCKS5 username; why go through the trouble of randomizing the username and then maintaining a mapping inside Electrum-NMC?  The reason is that Electrum-NMC needs to preemptively open server connections before `name_show` is called.  Otherwise, each name lookup would be delayed by an Electrum protocol handshake, which would be an unacceptable latency penalty.

These patches are also useful for non-Namecoin use cases, and accordingly I've also sent them upstream to Electrum, where they're awaiting review.

## btcd

btcd is best-known as an alternate implementation of a Bitcoin full node, but it's also the primary implementation of a Bitcoin RPC client in Go.  Up until recently, ncdns used an ancient 2015 fork of btcd to talk to Namecoin Core and Electrum-NMC.  This fork dealt with the arguments to `name_show`.  I wasn't really fond of piling more and more hacks onto an ancient fork, so I looked into what would be needed to use modern btcd with Namecoin.  There were only 2 features missing from current btcd that we needed: extensible commands (so that we could add `name_show` as an RPC method) and cookie authentication (so that the user doesn't need to set up RPC passwords manually).  Both of these were pretty easy to implement, and I've sent patches for both to the btcd developers.  They're both undergoing review.

With that out of the way, I was able to get the Namecoin `name_show` command working with current btcd (I'm currently maintaining a fork of btcd until the above 2 patches are merged), via the new `ncbtcjson` and `ncrpcclient` packages.  These packages now support passing a stream isolation ID to Namecoin Core and Electrum-NMC.  (Namecoin Core ignores it, since it doesn't generate any network traffic per lookup.)

I also needed to hack Electrum-NMC a bit to make the new btcd's stream isolation ID argument work with it.  This is because Electrum, by convention, expects optional arguments to be passed in a slightly different way than Bitcoin Core, and since the stream isolation ID is an optional argument, I needed to rig Electrum-NMC to also recognize the Namecoin Core style.

## ncdns

Rewriting ncdns's integration with btcd was quite enjoyable, because modern btcd is much simpler to use than the ancient 2015 fork we were using previously.  This meant that I got to rip out quite a lot of code that was no longer needed.  Adding a stream isolation ID argument to ncdns's lookup code that gets passed through to btcd was pretty easy, but there's another important thing that was necessary.  ncdns caches responses for performance reasons, and it's important to isolate the cache based on the stream isolation ID.  So, now ncdns creates a new cache for each new stream isolation ID that it sees.

## madns

madns is the authoritative DNS library that ncdns uses.  Even though ncprop279 doesn't include a DNS server, it uses madns to handle various DNS protocol functionality (e.g. wildcard domains) that one would expect a naming system to handle.  Making madns pass a stream isolation ID to ncdns was pretty easy (though it required breaking the madns stable API).  But where would madns get the stream isolation ID from, since usually it receives requests via the DNS wire protocol?

The solution Hugo and I found was to use EDNS0, which is a protocol extension mechanism in the DNS wire protocol.  I created an EDNS0 extension that allows DNS clients to specify a stream isolation ID; madns then passes it to ncdns.

This has other interesting implications.  For example, a method of supporting stream isolation in the DNS wire protocol would be interesting to explore for the Tor DNS port, as well as Unbound and other locally-run DNS servers.

## ncprop279

Modifying ncprop279 to pass a stream isolation ID to madns via EDNS0 was straightforward.  I also had to modify the Prop279 protocol a bit so that ncprop279 knows what stream isolation ID to use.  This was pretty easy.

## StemNS

Making StemNS pass a stream isolation ID to ncprop279 was pretty easy.  But how to calculate the stream isolation ID?  Alas, simply using the SOCKS5 username+password wasn't going to fly.  Remember how I said I was oversimplifying how Tor decides which connections to isolate?  In reality, there are a variety of different data fields associated with a connection made through Tor besides the SOCKS5 username/password.  Other fields that are relevant include the source IP (useful if you have multiple VM's that access a common Tor instance and you want each VM to be stream-isolated) and the destination IP/port (useful if you have an application that talks to multiple servers via Tor's Trans port and you want each server to be stream-isolated).  Additionally, Tor can be configured to enable or disable stream isolation for each of these fields independently.  And did I mention that Tor can run multiple listener ports, and each of these ports can have independent stream isolation settings?

Trying to reliably compress this data into some kind of hash that we could use as a stream isolation ID seemed error-prone, so I instead copied Nick Mathewson's English description of the logic that Tor itself uses to decide whether two given Tor streams can go over the same circuit, and I made StemNS store the relevant raw data.  StemNS deletes this data every time Tor cycles to a new identity (typically every 10 minutes, though this can vary by settings, and also happens immediately if the user clicks the New Identity button), so it shouldn't eat up too much memory.  Whenever StemNS finds that a newly requested stream isn't compatible with any of the streams previously assigned to a stream isolation ID, it makes up a new stream isolation ID and assigns the stream to that one.  Not too bad.

## Tor

StemNS talks to Tor via the control port protocol.  Unfortunately, quite a few of the relevant fields (including the SOCKS username/password) weren't actually available via the control port's `STREAM` event, which is the event we need to hook in order to do name resolution.  The control port *does* make the SOCKS username/password available via other events, but those events don't fire until it's too late to do name resolution.

So I ended up patching Tor to make all of those fields available over the control port.  Because the control port protocol follows a spec, that also meant patching the spec.  After a few revisions of the spec and code as per review, Nick from Tor merged my patches.  Nightly builds of Tor now support the necessary control port features for StemNS to handle stream isolation properly.

## Conclusion

Getting this implemented across the stack was an interesting and nontrivial endeavor, due to the large number of codebases involved, many of which involve third parties.  But I think it was worth it.  New release tags of the relevant codebases will hopefully be coming soon, which means we'll finally be able to get rid of the scary warning against using Electrum-NMC with ncprop279.  Considering that Electrum-NMC syncs by far the quickest of any Namecoin name lookup client, which is a big deal given Tor's bandwidth constraints, this is a major UX win.

This work was funded by NLnet Foundation's Internet Hardening Fund.
