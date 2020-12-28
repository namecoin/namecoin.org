---
layout: post
title: "Electrum-NMC v3.3.6 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.6.  This release includes important security fixes, and we recommend that all users upgrade.  Here's what's new since v3.3.3.1.1:

* From upstream Electrum:
    * AppImage: we now also distribute self-contained binaries for x86_64 Linux in the form of an AppImage (#5042). The Python interpreter, PyQt5, libsecp256k1, PyCryptodomex, zbar, hidapi/libusb (including hardware wallet libraries) are all bundled. Note that users of hw wallets still need to set udev rules themselves.
    * hw wallets: fix a regression during transaction signing that prompts the user too many times for confirmations (commit 2729909)
    * transactions now set nVersion to 2, to mimic Bitcoin Core
    * fix Qt bug that made all hw wallets unusable on Windows 8.1 (#4960)
    * fix bugs in wallet creation wizard that resulted in corrupted wallets being created in rare cases (#5082, #5057)
    * fix compatibility with Qt 5.12 (#5109)
    * The logging system has been overhauled (#5296).  Logs can now also optionally be written to disk, disabled by default.
    * Fix a bug in synchronizer (#5122) where client could get stuck.  Also, show the progress of history sync in the GUI. (#5319)
    * fix Revealer in Windows and MacOS binaries (#5027)
    * fiat rate providers:
        - added CoinGecko.com and CoinCap.io
        - BitcoinAverage now only provides historical exchange rates for paying customers. Changed default provider to CoinGecko.com (#5188)
    * hardware wallets:
        - Ledger: Nano X is now recognized (#5140)
        - KeepKey:
            - device was not getting detected using Windows binary (#5165)
            - support firmware 6.0.0+ (#5205)
            - Trezor: implemented "seedless" mode (#5118)
    * Coin Control in Qt: implemented freezing individual UTXOs in addition to freezing addresses (#5152)
    * TrustedCoin (2FA wallets):
        - better error messages (#5184)
        - longer signing timeout (#5221)
    * Kivy:
        - fix bug with local transactions (#5156)
        - allow selecting fiat rate providers without historical data (#5162)
    * fix CPFP: the fees already paid by the parent were not included in the calculation, so it always overestimated (#5244)
    * Testnet: there is now a warning when the client is started in testnet mode as there were a number of reports of users getting scammed through social engineering (#5295)
    * CoinChooser: performance of creating transactions has been improved significantly for large wallets. (d56917f4)
    * Importing/sweeping WIF keys: stricter checks (#4638, #5290)
    * Electrum protocol: the client's "user agent" has been changed from "3.3.5" to "electrum/3.3.5". Other libraries connecting to servers can consider not "spoofing" to be Electrum. (#5246)
    * Several other minor bugfixes and usability improvements.
    * qt: fix crash during 2FA wallet creation (#5334)
    * fix synchronizer not to keep resubscribing to addresses of already closed wallets (e415c0d9)
    * fix removing addresses/keys from imported wallets (#4481)
    * kivy: fix crash when aborting 2FA wallet creation (#5333)
    * kivy: fix rare crash when changing exchange rate settings (#5329)
    * A few other minor bugfixes and usability improvements.
* Namecoin-specific:
    * [Checkpointed AuxPoW truncation]({{site.baseurl}}2019/02/02/electrum-nmc-checkpointed-auxpow-truncation.html).  This requires servers to run ElectrumX v1.9.2 or higher.  All public servers have upgraded; if you run a private server, please make sure that you've upgraded if you want Electrum-NMC to keep working.
    * Pending registrations in Manage Names tab now show the name and value rather than a blank line.
    * Manage Names tab now shows an estimated expiration date in addition to a block count.
    * Manage Names tab now allows copying identifiers and values to the clipboard.
    * Status bar now shows a count of registered names and pending registrations next to the NMC balance.
    * Set memo in name wallet commands.  This improves Coin Control, which paves the way for anonymity.
    * We now distribute Android APK binaries and GNU/Linux AppImage binaries (in addition to the previously existing Python tarball binaries and Windows binaries).  Android and AppImage binaries are not tested in any way (they might not even boot) -- please test them and let us know what's broken.
    * Notify when a new version of Electrum-NMC is available.
    * Add 2 new servers.
    * Remove 2 old servers that are now being decommissioned.
    * Various fixes for exception handling.
    * Various unit tests and fixes for AuxPoW.
    * Various rebranding fixes.
    * Various code quality improvements.

I want to draw attention in particular to one of the code quality improvements.  Most forks of Electrum rename the `electrum` Python package, in order to avoid causing namespace conflicts if both Electrum and an Electrum fork are installed on the same system.  Unfortunately, the result of this is that any change to `import` statements in upstream usually triggers a merge conflict.  I brought up this subject with SomberNight from upstream Electrum, in the hopes that we could find a solution that would avoid the merge conflicts.  My initial suggestion was for upstream to switch to relative imports; SomberNight shot that down due to code readability concerns, but he posted a code snippet that was a (non-working) attempt to work around the issue.  Based on the rough direction of his code snippet, I managed to produce a working patch to Electrum-NMC that allows the imports to revert to the upstream version.  For an idea of how much improvement this is, prior to this patch, merging one release tag's worth of commits (i.e. about a month of commits) would typically take me a day or so.  Now, it takes me about 30 minutes.  Kudos to SomberNight for his excellent efforts working with me to get us to a solution that optimizes productivity for both upstream and downstream.

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).

This work was funded by NLnet Foundation's Internet Hardening Fund and Cyphrs.
