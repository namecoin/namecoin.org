---
layout: page
title: ncdns
---

{::options parse_block_html="true" /}

ncdns is software for accessing `.bit` domain names.  If you want to access `.bit` domain names, ncdns is what you want to install.  (Technically speaking, ncdns is a Namecoin to DNS bridge.  It allows software that speaks the DNS protocol to use Namecoin.)

## Installation

You can download ncdns at the [Beta Downloads]({{site.baseurl}}download/betas/) page.

### Windows

An installer wizard is available.  The ncdns Windows installer will offer to automatically install a Namecoin name lookup client (either Namecoin Core or ConsensusJ-Namecoin) and [Dnssec-Trigger](https://www.nlnetlabs.nl/projects/dnssec-trigger/):

![Screenshot.]({{site.baseurl}}images/screenshots/ncdns-nsis/select-spv-dnssec-trigger-2018-07-31.png)

If you're missing a dependency for ConsensusJ-Namecoin, you'll see a notice like this:

!["Cannot use BitcoinJ SPV client (Java must be installed)"]({{site.baseurl}}images/screenshots/ncdns-nsis/spv-missing-java-2018-08-10.png)

Or like this:

!["Cannot use BitcoinJ SPV client (Microsoft Visual C++ Redistributable Package must be installed)"]({{site.baseurl}}images/screenshots/ncdns-nsis/spv-missing-vc2010-2018-08-10.png)

To enable installing ConsensusJ-Namecoin, exit the installer wizard, install the relevant dependency, and re-run the installer wizard.

The ncdns installer wizard also sets up TLS certificate validation for `.bit` domain names if a supported web browser is installed.  Currently, the following web browsers are supported for Namecoin TLS on Windows:

* Chromium
* Google Chrome
* Google Chrome Canary
* Opera

### Other OS's

ncdns plain binaries (without install scripts) are available for most major operating systems.  These require installing a [Namecoin name lookup client]({{site.baseurl}}get-started/name-lookup-clients/) and a DNS resolver (e.g. Dnssec-Trigger) separately, and manually configuring ncdns to integrate with them (see instructions below).  ncdns plain binaries are only recommended for advanced users at this time.

TLS instructions for ncdns on GNU/Linux are at the [TLS Client Compatibility]({{site.baseurl}}docs/tls-client/) page.

## Supplying your own Namecoin node

The ncdns Windows installer will offer to install Namecoin Core or ConsensusJ-Namecoin, and configure ncdns to use it.  However, there are several reasons why you might want to supply your own Namecoin node:

* You're not using Windows.
* You want to use a Namecoin node that isn't Namecoin Core or ConsensusJ-Namecoin.
* You want to run a Namecoin node on a different machine than ncdns.
* You want to handle updating your Namecoin node separately from updating ncdns.

If you want to supply your own Namecoin node, you can follow these steps:

1. Make sure that your Namecoin node has the RPC server enabled.
2. Open `ncdns.conf`.  On Windows, it's in the `etc/` subdirectory of where you installed ncdns.
3. Look for the `namecoind access` section.
4. If your Namecoin node isn't listening on `127.0.0.1`, or if it's listening on a non-default port, uncomment the `namecoinrpcaddress` line and fill in the IP and port.
5. If your Namecoin node uses cookie authentication, fill in the path to the cookie file in the `namecoinrpccookiepath` line.  Make sure that the ncdns user has filesystem permissions to read the cookie file.  (Be careful not to grant the ncdns user filesystem permissions that it doesn't need.  For example, don't grant ncdns the ability to read your wallet.)
6. If your Namecoin node doesn't use cookie authentication, comment out the `namecoinrpccookiepath` line, uncomment the `namecoinrpcusername` and `namecoinrpcpassword` lines, and fill in your Namecoin node's RPC username and password.
7. Restart ncdns.  On Windows, you can do this by going to `Control Panel` -> `Administrative Tools` -> `Services`, right-click `ncdns`, and click `Restart`.
