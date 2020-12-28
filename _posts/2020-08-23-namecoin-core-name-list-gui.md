---
layout: post
title: "Namecoin Core name_list GUI"
author: Jeremy Rand
tags: [News]
---

Namecoin Core's name management GUI has always been a bit neglected.  While we do have a GUI that works reasonably well, it's been stuck in an old branch that is nontrivial to forward-port.  The main reason that it's been hard to maintain is that it depends on internal API's that often get refactored, which breaks the GUI unless someone volunteers to constantly test the GUI whenever upstream refactors get merged (which is not a great use of anyone's time).  GUI code is also hard to test on Travis CI compared to CLI-accessible code, which compounds the problem.

Brandon accurately observed that a way to mitigate this issue is to expose all of the functionality that the GUI needs as RPC methods, and then simply make the GUI call RPC functions.  (Bitcoin Core includes a built-in API for internally calling RPC functions.)  This minimizes the amount of logic that the GUI needs to carry, which both enables integration testing and eliminates private API usage in the GUI code.  This was partially done in Brandon's branch that was used for the name tab binaries that we released, but unfortunately, there was still some logic that needed internal API's.

So, I'm picking up where Brandon left off.  For one thing, I'm splitting the code into multiple PR's, which can be merged independently: the GUI equivalents of `name_list`, `name_update`, and `name_autoregister`.  The first of these, `name_list`, is used for displaying the current name inventory.  I've spent some time forward-porting the `name_list` GUI to current Namecoin Core, and here's a preliminary result:

![A screenshot of the Manage Names tab in Namecoin-Qt.]({{site.baseurl}}images/screenshots/namecoin-core/manage-names-2020-08-19.png)

There's still some more code cleanup needed before it can be merged, but I'm optimistic that we can get a merge to happen soon.

