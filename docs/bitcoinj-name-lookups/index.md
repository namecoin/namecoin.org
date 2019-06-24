---
layout: page
title: ConsensusJ-Namecoin
---

{::options parse_block_html="true" /}

This is documentation for ConsensusJ-Namecoin (a lightweight SPV Namecoin name lookup client).  It is based on the following pre-existing projects:

* libdohj by Ross Nicoll
* ConsensusJ by Sean Gilligan
* Webbtc by Marius Hanne

**Warning: this is beta software, and is not suitable for production use.  It is being made available for testing purposes only.  It doesn't support proxying or stream isolation.  In the examples on this page, we explicitly pass command-line arguments telling the client that this is okay.  Leaving off those arguments will result in an error for safety reasons.**

## Build prerequisites

(This is only if you want to build from source.)

### GNU/Linux

1. Install OpenJDK from your package repositories.  These instructions will be updated later with specific package names.  Development was done with JDK 8; JDK 7 might work but is untested.
2. Make sure that the `JAVA_HOME` environment variable is set.  On Jeremy's Debian Jessie VM, he had to manually set it to `/usr/lib/jvm/java-8-openjdk-amd64`.
3. Install Maven from your package repositories.  These instructions will be updated later with specific package names.

### Windows

1. Install JDK.  Note that Oracle's download site doesn't support TLS.  If you enjoy being MITM-attacked and installing malware, you can [download it here (non-TLS link)](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
2. Make sure that the `JAVA_HOME` environment variable is set.  On Jeremy's Windows 10 VM, he had to manually set it to `C:\Program Files\Java\jdk1.8.0_101`.
3. Install Maven.  Note that Maven's official download site uses non-TLS downloads (insecure), MD5 checksums (insecure), and 1024-bit DSA signing keys (insecure).  If you enjoy being MITM-attacked and installing malware, you can use the [Maven download page](https://maven.apache.org/download.cgi) and the [Maven install page](https://maven.apache.org/install.html).

For those of you who *don't* enjoy installing malware, we suggest building from source on GNU/Linux and copying the binary to Windows.

### OS X

No idea.  If anyone can contribute instructions for OS X, let us know.

## Build instructions

(This is only if you want to build from source.)

~~~
git clone https://github.com/dogecoin/libdohj.git
cd libdohj
mvn clean install
cd namecoin
mvn clean install
cd ../..
git clone https://github.com/JeremyRand/consensusj.git
cd consensusj
git checkout consensusj-namecoin-0.3.2.1
./gradlew clean :cj-nmc-daemon:assemble
~~~

The binary will be created at `cj-nmc-daemon/build/libs/namecoinj-daemon-0.3.2-SNAPSHOT.jar`.

## Running it

**All API elements that are not directly taken from Namecoin Core (including all command-line arguments and all URL formats and JSON structures for the upstream REST API) are not guaranteed to have a stable API; they might be renamed, modified, or removed in the future.**

~~~
java -jar ./namecoinj-daemon-0.3.2-SNAPSHOT.jar --connection.proxyenabled=false --connection.streamisolation=false
~~~

The blockchain takes around 5 minutes to download.  Once it is fully synchronized, the RPC server will automatically start; it listens on port 8080.

You can also customize the behavior of the server with some command line options:

~~~
--server.port=<port> (default: 8080)
~~~

Change what port the RPC server listens on.

~~~
--namelookup.latest.algo=<algo> (default: restmerkleapi)
~~~

Change how `name_show` lookups are performed.  The following algorithms are available:

* `restheightapi`: Looks up the height of the latest `name_anyupdate` operation for the name that has at least 12 confirmations by using a REST API (default URL is `https://namecoin.webbtc.com/name/heights/<name>.json?raw`), and retrieves that block over the P2P network.  This is usually fast, but if the name is part of a very large block, it can take a couple of seconds.  It reveals to the REST API which name is being looked up, and it reveals to a P2P peer what the height of that name is.  The REST API can hide recent `name_anyupdate` operations without being detected.
* `restmerkleapi`: Looks up a Merkle proof for the latest `name_anyupdate` operation for the name that has at least 12 confirmations by using a REST API (default URL is `https://namecoin.webbtc.com/name/<name>.json?history&with_height&with_rawtx&with_mrkl_branch&with_tx_idx&raw`).  This is slower than `restheightapi` for most names, but it’s faster than `restheightapi` if the name is in a very large block.  It reveals to the REST API which name is being looked up; it doesn’t reveal anything to the P2P network.  The REST API can hide recent `name_anyupdate` operations without being detected.
* `restmerkleapisingle`: **Unreliable in the current version.** Similar to `restmerkleapi`, but increases lookup speed by asking the REST API to only generate a Merkle proof for the most recent `name_anyupdate` operation for the name (default URL is `https://namecoin.webbtc.com/name/<name>.json?with_height&with_rawtx&with_mrkl_branch&with_tx_idx&raw`).  Faster than `restmerkleapi`, but will return an error if the name’s most recent update has between 1 and 11 confirmations (inclusive).  The REST API can hide recent `name_anyupdate` operations without being detected.
* `leveldbtxcache`: Maintains a cache of all unexpired `name_anyupdate` operations, obtained by downloading full blocks (instead of just headers) for all blocks that are newer than 366 days old.  Much, much faster lookups than the REST-API-based algos, and lookups don’t generate any network traffic (so lookup operations are as private as Namecoin Core).  Initial syncup will take somewhat longer, and approximately 10 MB of extra storage will be used for the name database.  It is not feasible for `name_anyupdate` operations to be hidden without detection, because full blocks are downloaded.  There are known hypothetical attacks possible involving reorganizations deeper than 12 blocks; see the libdohj source code comments for details.

~~~
--namelookup.latest.resturlprefix=<prefix>
--namelookup.latest.resturlsuffix=<suffix>
~~~

Change what REST API URL is constructed; default depends on the value of `--namelookup.latest.algo`.  The URL is constructed by concatenating the prefix, the name, and the suffix.

## Using it

### namecoin-cli

**All API elements that are not directly taken from Namecoin Core (including the `valueParsed` field and `name_show_at_height` method) are not guaranteed to have a stable API; they might be renamed, modified, or removed in the future.**

You can use the namecoin-cli tool that comes with Namecoin Core to look up names.  Make sure that you're using the correct port.  Any username and password are okay.

The following RPC commands are supported:

~~~
name_show <name>
~~~

Similar to `name_show` provided by Namecoin Core.  Does not show a result for expired names.  Uses the algorithm specified by `--namelookup.latest.algo`.  As of this writing, the `vout` and `expired` fields normally provided by Namecoin Core are not supported (they are always null).  If the `value` field is valid as a JSON object, it will be parsed and made available as a JSON object in the `valueParsed` field.

~~~
name_show_at_height <name> <height>
~~~

Similar to `name_show`, but displays the `name_anyupdate` operation from the given block height, even if it isn’t the latest `name_anyupdate` operation for that name.  Does not show a result for expired operations.  Does not show a result if the specified block doesn’t contain a `name_anyupdate` operation for the specified name.  The algorithm always retrieves the block over the P2P network.  Usually faster than `name_show`, unless `--namelookup.latest.algo=leveldbtxcache` is set.  It reveals to a P2P peer which block height is being looked up; it doesn’t reveal anything to a REST API.

Example usage:

~~~
./namecoin-cli -rpcport=8080 -rpcuser=user -rpcpassword=pass name_show d/domob
~~~

### curl

If you don’t have namecoin-cli, any JSON-RPC client should work.  For example, you can use curl:

~~~
curl --user user:pass --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"name_show","params":["d/domob"]}' -H 'content-type:text/plain;' http://127.0.0.1:8080
~~~

### ncdns

ncdns should work as long as it's set to the correct port.  For example, you might set the following line in `ncdns.conf`:

~~~
namecoinrpcaddress="127.0.0.1:8080"
~~~

However, note that `--namelookup.latest.algo=leveldbtxcache` will be more reliable on many setups than the other algorithms, because of DNS timeouts.
