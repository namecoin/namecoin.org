---
layout: post
title: "`generate_nmc_cert` is now `ncgencert`"
author: Jeremy Rand
tags: [News]
---

If you've used `generate_nmc_cert` to set up a Namecoin TLS server, you've probably found the interface a tad vexing. Examples of such weirdness:

* Why is the `-use-ca` argument always required? What happens if you forget it?
* Why is the `-use-aia` argument sometimes required?
* What the heck is the `-falsehost` argument?

The answer is: prioritization of interface stability over UX. This may have made sense many years ago when the Encaya certificate format was still experimental, but by now everyone knows that we're not going back to the pre-Encaya certificate formats (which is what you'd get if you forgot `-use-ca` or `-use-aia`, or if you used `-falsehost`).

I've now refactored the interface, as follows:

* `-use-ca` is always true. The code paths for when it was false have been sent to a luxurious permanent retirement; we thank them for their past service.
* `-use-aia` is now inferred based on whether parent or grandparent chains are specified. The code paths for when the aforementioned inference was wrong have also been sent to luxurious permanent retirement; we thank them for their past service as well.
* All code associated with `-falsehost` has met the same fate, and received the same thank-you, as above.

To celebrate the new, more user-friendly interface, the tool has also been renamed to `ncgencert`. The old name `generate_nmc_cert` was a result of the tool's code being a copy of a Golang standard library example called `generate_cert`; it was chosen with essentially no thought. In particular, it was inconsistent with existing convention for how Namecoin tools are named: application-layer tools generally are supposed to have `nc` as a prefix (e.g. ncdns, ncp11, ncprop279, and Encaya's original spelling ncaia). The "NMC" abbreviation is supposed to be reserved for wallets and similar tools.

This work was funded by Power Up Privacy.
