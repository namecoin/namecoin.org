---
layout: post
title: "Porting Namecoin in Tor Browser to macOS"
author: Jeremy Rand
tags: [News]
---

Hot on the heels of [porting Namecoin in Tor Browser to Windows]({{ "/2020/08/28/porting-namecoin-in-tor-browser-to-windows.html" | relative_url }}), it was time to do the final remaining desktop OS, macOS.  This one was always going to present a challenge in the QA testing department, because I don't own any macOS devices.  On the other hand, I fully expected that the amount of code written for macOS support was going to be pretty minimal; in fact, I expected that other than tweaking a few constants, macOS support was likely to be a subset of the code needed for Windows support.  But, of course, our friend Murphy wasn't going to let that assumption stand.

On the bright side, two of our community members who do have macOS devices volunteered to test my binaries and supply me with debug logs when things failed.  So at least that wasn't going to prevent a successful port.

## Initial Attempt

As a first try, I added the Electrum-NMC, `ncprop279`, and StemNS dependencies (with their config files) to the `tor-browser` rbm project, and added the missing lines in Tor Launcher for determining the paths of Electrum-NMC and StemNS on macOS.  Then I flipped the `var/namecoin` switch for macOS in `tor-browser-build`, and started up a build job.  In order to build without errors, I then needed to make some slight edits to the build scripts of some of the Go projects that `ncprop279` depends on, mostly related to cgo edge cases.

Alas, the resulting binaries consistently failed to detect Electrum-NMC and `ncprop279`.

## What is this external user data craziness?

It turns out that Tor Browser for macOS does something very different from Tor Browser for GNU/Linux and Windows.  On macOS, the user data directory is stored separately from the application executable code.  To make matters worse, on macOS there is no way to supply "default" contents for the user data directory.  In fact, in order to set the default bookmarks for Firefox, Tor Browser on macOS does some kind of witchcraft involving stuffing the bookmarks file inside one of the Firefox application archives, such that when Firefox eventually creates a fresh profile, the bookmarks end up in the desired place.  For non-Firefox data, there simply is no mechanism at all.  Even the file `torrc`, which exists in the source code, never actually gets installed on macOS (which I suppose is tolerated because it's an empty file, so who cares if it gets installed?).

Alas, the Namecoin support in Tor Browser relies on supplying default config files for both Electrum-NMC and `ncprop279`.  Fixing this was going to take some refactoring.

## Electrum-NMC Support

I considered a few options here.  Initially the thought occurred to me of patching Electrum-NMC to support a read-only config file in a separate directory from its writeable data directory.  Alas, this seemed rather invasive, and I didn't want to write a complex patch without good reason.  I also considered generating the config file on-demand as part of Tor Launcher, but this was also not going to be very clean.  Instead, I realized that we could just pass the config options we cared about as command-line flags, not supply a default config file at all, and be done with it.

Oh wait.  Murphy says no.  Turns out that the RPC port settings in Electrum can't be set on the command-line, only in the config file.  Upon consulting with SomberNight from upstream Electrum, he pointed me to a spot in the relevant Python source, where I could probably do a 3-line patch that would do what I want, and would probably be upstreamable without controversy.  This ended up working very well.  We were thus able to launch Electrum-NMC.

## `ncprop279` Support

This one was easier.  `ncprop279` doesn't need to write to any config directory, and it will happily look for a config file adjacent to its executable file if one is there.  So I just stuck `ncprop279.conf` in the same directory as the executable, and we were done there.

## StemNS Support

A minor tweak was needed for StemNS, so that it would search for `ncprop279` relative to StemNS's script directory instead of relative to the `PATH`.  Turns out that macOS doesn't standardize the `PATH` in the way that GNU/Linux and Windows do, so relying on the `PATH` wasn't usable on macOS.

Not too bad!

I also took the opportunity to do some minor refactoring/cleanup of StemNS, mostly related to error handling and debug logging.  Now the console output of StemNS is actually likely to be informative.  (My beta testers very much appreciated this.)

## It works?  It works!

At this point it seems to work perfectly.  I still need to squash Git history and do some final checks on GNU/Linux and Windows to make sure the refactors didn't break anything, and then I'll hand it off to the Tor Browser developers.

![A screenshot of Namecoin in Tor Browser on macOS.]({{ "/images/screenshots/tor/tor-browser-macos-2020-09-20.png" | relative_url }})

This work was funded by Cyphrs and Cyberia Computer Club.
