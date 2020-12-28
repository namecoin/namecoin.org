---
layout: post
title: "Notes on building Python for Windows using RBM"
author: yanmaani
tags: [News]
---

Namecoin would like for Tor Browser to support .bit domains.  The only mature, lightweight way to do this is to use the wallet qua name resolver Electrum-NMC.  It is written in Python.  To run Python software, you need an interpreter, like CPython.

Namecoin and Tor are both intended to be secure projects.  All their binaries have to build reproducibly.  The Tor Browser is also intended to be portable.  It's not acceptable for users to have to install additional software on their computer to run Tor Browser.

This means a Python interpreter would have to be bundled in order for Electrum-NMC to be includible in Tor Browser.  And since Tor Browser is a secure project, said Python interpreter has to be built reproducibly.  For this reason, the `tor-browser-build` repository has received some patches to reproducibly build such binaries.

This post details the problems encountered while making them.

Building CPython reproducibly for Linux is trivial.  Download the source code, patch it to disable build timestamps, and compile.  That's it, you're done.

The situation is markedly different on Windows.  The official Python documentation suggests [building with Microsoft Visual Studio 2017](https://github.com/python/cpython/blob/master/PCbuild/readme.txt).  This is no good.  That compiler doesn't support reproducible builds, it's closed-source, and it would have to run in Wine.

There should be another way.  CPython is written in standard C.  GCC can cross-compile C software for Windows using MinGW - the compiler runs on Linux, but produces binaries for Windows.  That's how the Tor Project build Tor Browser for Windows.  In theory, it should be possible to use GCC to cross-compile CPython for Windows, and a lot of Tor's tooling should be possible to re-use.

In practice, Python's ordinary build system doesn't support this.  It isn't made for cross-compilation.  Thankfully, one [Erik Janssens](https://github.com/erikjanss) had created an alternative [Meson](https://mesonbuild.com/)-based [build script](https://github.com/v-finance/cross-python) to compile Python for Windows with Linux using GCC and MinGW.  Many thanks!

This build script needed some minor adaptations to properly integrate it with the Tor Project's RBM build system.  Meson and RBM both have built-in features for dependency handling, such as downloading files from URLs, verifying their hashes, and caching them.  Doing this requires Internet access.  When compiling, RBM disables Internet access.

The configuration script will thus have to download the binaries and move them into the cache directory used by Meson.  This change also makes the build faster - RBM uses a fresh VM for each build, so unless the cache is outside of the VM, it will be wiped on each new build.

After this was done, RBM was able to produce something resembling a Python 3.8 interpreter.  However, it wasn't functional.  Owing to what presumably was an idiosyncracy of the MinGW system, a critical library named `libwinpthread-1.dll` wasn't included.

This problem turned out to be easy to fix.  Ruben Van Boxem, a contributor to the MinGW project, [suggested](https://stackoverflow.com/a/14033674) on StackOverflow that the compiler/linker simply be explicitly told to link this library statically.  This worked:

```
$ wine python.exe
Python 3.8.5 (default, xx/xx/xx, xx:xx:xx) [gcc] on win32
>>>
```

The changes are now submitted and subject to review.

We think other projects that use Python might find these efforts useful.  In particular, upstream Electrum may benefit from using a reproducible build of Python.  We want to help others, so we try to submit patches and contribute where appropriate:

* The RBM build descriptor carries a custom patch to omit build timestamps in CPython.  With this merged upstream, reproducible builds of CPython would become easier, and the maintenance burden lower.
* I have submitted some [minor documentation changes](https://github.com/v-finance/cross-python/pull/1) for Mr. Janssens's build script.
* The RBM build descriptor can be used to build Python, without necessarily building the Tor Browser.
