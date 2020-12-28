---
layout: post
title: "Porting Namecoin in Tor Browser to Windows"
author: Jeremy Rand
tags: [News]
---

As you no doubt remember [from 36C3]({{ "/2020/01/11/36c3-summary.html" | relative_url }}), the GNU/Linux version of Tor Browser Nightly comes with Namecoin support included.  While we've received significant test feedback (overwhelmingly positive), it's been pointed out that supporting Windows would enable additional test feedback, since not everyone has a GNU/Linux machine to test things on.  So, I've been porting the Namecoin support in Tor Browser Nightly to Windows.

## StemNS and Tor Bootstrap

First off, since this endeavor was going to involve some changes to StemNS, I figured this was a good opportunity to investigate an odd bug that was happening in StemNS sometimes.  I had noticed last year that in a fresh Tor Browser install, if Namecoin was enabled on the first run, Tor Launcher would indicate that Tor bootstrap had stalled at the "loading authority certificates" stage.  I found that spamming the Tor Launcher buttons to cancel and retry connecting would usually make the connection succeed after 5-10 tries, which seemed to suggest a race condition.  After quite a lot of manual inspection of StemNS logs, I found something odd.

While the Tor control spec states that the `__LeaveStreamsUnattached` config option will cause all streams to wait for the controller (StemNS in this case) to attach them, this was empirically not what was happening.  Rather, streams created as a result of user traffic (e.g. Firefox or Electrum-NMC) were waiting for StemNS to attach them, but streams created by Tor's bootstrap were still automatically being attached.  The Tor control spec goes on to say the following:

> Attempting to attach streams
> via TC when "__LeaveStreamsUnattached" is false may cause a race between
> Tor and the controller, as both attempt to attach streams to circuits.
> 
> You can try to attachstream to a stream that
> has already sent a connect or resolve request but hasn't succeeded
> yet, in which case Tor will detach the stream from its current circuit
> before proceeding with the new attach request.

This certainly explained what had been happening.  Tor was opening a stream to bootstrap (attaching the stream to a circuit in the process), and (depending on exact timing) StemNS was trying to attach it a 2nd time, which caused the stream to be detached, thus killing the bootstrap.

At this point, I decided to ask the Tor developers whether this was a bug in the spec or the C implementation.  Roger Dingledine pointed me to the exact C code that handled this, which indicated exactly how StemNS could detect this case and handle it properly.  Roger also indicated that the C code was correct, and that the spec was incorrect.  I concurred that this made sense.

I was then able to modify StemNS to handle this properly by detecting whether a new stream was created by user traffic or internal bootstrap, and only attaching streams from the former.  Testing confirmed that the bug was fixed.  Great, now let's move on.

## Exiting Namecoin when Tor Browser Exits

The existing Namecoin support in Tor Browser relies on a Bash script that signals Electrum-NMC and StemNS to exit after Firefox exits.  Alas, Bash is only used as a launcher in GNU/Linux, so I needed to port this to a more cross-platform approach.

Tor Browser already solves this problem for the Tor daemon: Tor needs to exit when Firefox has done so.  Tor Browser does this by having Firefox send the `TAKEOWNERSHIP` command to Tor, which instructs Tor to exit when Firefox closes the control port connection.  This inspired me to do something similar in StemNS: I added an event listener to StemNS that triggers when Tor closes the control port connection to StemNS (which will happen when Tor exits).  I configured the event listener to send an RPC `stop` command to Electrum-NMC (which will make Electrum-NMC exit), and then exit StemNS as well.  (The latter took some DuckDuckGo-fu, as it turns out that `sys.exit()` can't be called from a child thread in Python; the correct way to exit from a child thread is `os._exit()`.)

Some testing revealed that this worked; I was able to remove the Bash code that terminated Electrum-NMC and StemNS, and they still exited properly.  Moving on...

## Launching Namecoin when Tor Browser Starts

Of course, the other part of the Bash launcher for Namecoin was the code that launches Electrum-NMC and StemNS.  For this, I ended up copying/pasting the code in Tor Launcher that launches the Tor daemon.  As XPCOM-based JavaScript code goes, Tor Launcher is pretty readable, so the copy/paste job wasn't particularly eventful.  I *did* notice that the documentation for debugging Tor Launcher was outdated, but the Tor developers on IRC were able to point me in the right direction there.

I won't bore you with too many details on this part; it was mostly grunt work.  But I got it working.  Excellent, moving on....

## Windows and Python

By this point, all of the GNU/Linux-specific code had been replaced with cross-platform code.  So we were ready to move onto enabling Windows support.  Most of this was as simple as tweaking the rbm descriptors to enable Namecoin on Windows, and fixing a few bugs where the Go dependencies for certain rbm projects were wrong on Windows.  But, there was one issue that needed dealing with: Python.

Both Electrum-NMC and StemNS are written in Python.  GNU/Linux systems generally have Python available by default, but this is not the case for Windows.  In addition, on GNU/Linux, Python scripts are executable programs, but on Windows, they're data files that need to be explicitly opened with the Python interpreter.  This means that some Windows-specific things need to be done.

For Python being available, I took the easy way out: I simply defined [1] it to be out of scope, i.e. the user is responsible for installing Python themselves before enabling Namecoin in Tor Browser.  I also rigged Tor Launcher to check every directory in the `PATH` for a Python interpreter, and to use the discovered Python binary as the executable, passing the Electrum-NMC or StemNS path as a command-line argument instead.  Worked pretty well.

Finally, I re-implemented verbose logging for Namecoin (which was also part of the Bash code that I had removed).  This was done via a `TOR_VERBOSE_NAMECOIN` environment variable.  It does two things when enabled:

1. Pass the `-v` argument to Electrum-NMC, which enables verbose output.
2. On Windows, use `python.exe` (which pops up a command prompt window with logs) instead of `pythonw.exe` (which doesn't spawn a command window).

Oh, and I had to tweak the linker flags for `ncprop279` to make it avoid launching a command prompt window on Windows as well.

![A screenshot of Namecoin in Tor Browser on Windows.]({{ "/images/screenshots/tor/tor-browser-windows-2020-08-20.png" | relative_url }})

## Epilogue

I sent in the code to the Tor Browser Team, and it's now awaiting review.

In the meantime, I noticed that the `__LeaveStreamsUnattached` issue has a more correct fix now.  The master branch of Tor and Stem recently added a new stream status, `CONTROLLER_WAIT`, which indicates specifically that a stream is now waiting for the controller to attach it.  Thus, I've updated StemNS to only check for this status, rather than the mildly-convoluted previously-existing method of guessing whether a stream was waiting for this.  That means StemNS's master branch is now incompatible with Tor 0.4.5.0, Stem 1.8.0, and earlier.  I've tagged a stable release that doesn't include this refactor, and if any important bugfixes make their way into StemNS before the new Tor and Stem behavior gets into releases, I'll probably backport them to a stable branch.

And now, we wait for code review from the Tor Browser Team.  Let the bikeshedding begin!

This work was funded by Cyphrs and Cyberia Computer Club.

[1] This is a totally legit usage of definitional discretion.  [Really.](https://old.reddit.com/r/Jokes/comments/77zo3h/an_engineer_a_physicist_and_a_mathematician_are/)
