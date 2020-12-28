---
layout: post
title: "Namecoin Core Name Renew GUI"
author: Jeremy Rand
tags: [News]
---

Now that Namecoin Core's [`name_list` GUI]({{ "/2020/08/23/namecoin-core-name-list-gui.html" | relative_url }}) is merged to `master` branch (it'll be in the v22.0 release!), it's time to move on to renewing names.  As with the `name_list` GUI, I'm trying to follow the principles of (1) keeping PR's small, and (2) keeping all the interesting logic in the RPC method rather than the GUI.

In service of principle 1, I'm not touching the "Configure Name" GUI, nor am I touching the "Renew Name" button; this only adds the right-click context menu for renewing names.  In service of principle 2, yanmaani has done the excellent work of [adding a renew mode]({{ "/2020/12/04/namecoin-core-name-firstupdate-name-update-default-values.html" | relative_url }}) to the `name_update` RPC method, which simplifies the GUI logic considerably.

So, without further rambling, here are some screenshots:

![A screenshot of the Renew Names context menu in Namecoin-Qt.]({{ "/images/screenshots/namecoin-core/name-renew-single-context-menu-2020-12-04.png" | relative_url }})

![A screenshot of the Renew Names confirmation dialog in Namecoin-Qt.]({{ "/images/screenshots/namecoin-core/name-renew-single-confirmation-2020-12-04.png" | relative_url }})

![A screenshot of the Renew Names context menu for multiple names in Namecoin-Qt.]({{ "/images/screenshots/namecoin-core/name-renew-multiple-context-menu-2020-12-04.png" | relative_url }})

![A screenshot of the Renew Names confirmation dialog for multiple names in Namecoin-Qt.]({{ "/images/screenshots/namecoin-core/name-renew-multiple-confirmation-2020-12-04.png" | relative_url }})

Astute readers will have noticed that you can now renew multiple names at once, like in Electrum-NMC.  This was a minimal enough change from Brandon's GUI that I figured I'd toss it in.

Some more code review will be needed, but I don't expect any major obstacles getting this merged.
