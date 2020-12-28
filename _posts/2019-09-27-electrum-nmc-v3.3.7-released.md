---
layout: post
title: "Electrum-NMC v3.3.7 Released"
author: Jeremy Rand
tags: [Releases, Electrum Releases]
---

We've released Electrum-NMC v3.3.7.  Here's what's new since v3.3.6.1:

* From upstream Electrum:
    * The AppImage Linux x86_64 binary and the Windows setup.exe (so now all Windows binaries) are now built reproducibly.
    * Bump fee (RBF) improvements: Implemented a new fee-bump strategy that can add new inputs, so now any tx can be fee-bumped (d0a4366). The old strategy was to decrease the value of outputs (starting with change).  We will now try the new strategy first, and only use the old as a fallback (needed e.g. when spending "Max").
    * CoinChooser improvements:
        - more likely to construct txs without change (when possible)
        - less likely to construct txs with really small change (e864fa5)
        - will now only spend negative effective value coins when beneficial for privacy (cb69aa8)
    * fix long-standing bug that broke wallets with >65k addresses (#5366)
    * Windows binaries: we now build the PyInstaller boot loader ourselves, as this seems to reduce anti-virus false positives (1d0f679)
    * Android: (fix) BIP70 payment requests could not be paid (#5376)
    * Android: allow copy-pasting partial transactions from/to clipboard
    * Fix a performance regression for large wallets (c6a54f0)
    * Qt: fix some high DPI issues related to text fields (37809be)
    * Trezor:
        - allow bypassing "too old firmware" error (#5391)
        - use only the Bridge to scan devices if it is available (#5420)
    * hw wallets: (known issue) on Win10-1903, some hw devices (that also have U2F functionality) can only be detected with Administrator privileges. (see #5420 and #5437)  A workaround is to run as Admin, or for Trezor to install the Bridge.
    * Several other minor bugfixes and usability improvements.
* Namecoin-specific:
    * Fix issue affecting plugin detection.  If you were encountering hardware wallet bugs, they might be fixed now.
    * Various rebranding fixes.
    * Various code quality improvements.

As usual, you can download it at the [Beta Downloads page]({{site.baseurl}}download/betas/#electrum-nmc).

This work was funded by Cyphrs.
