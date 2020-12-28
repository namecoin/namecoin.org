---
layout: post
title: "Namecoin Core name_firstupdate, name_update default values"
author: yanmaani
tags: [News]
---

Namecoin Core will, starting version 0.21, no longer require for a value to be provided in the `name_update` and `name_firstupdate` RPC calls. If no value is provided, Namecoin Core will use the last known such. If none exists, the empty string will be used. This change has no adverse impact on existing workflows, since it only makes previously required parameters optional. However, it does make it easier to update names. If no change in the value is desired, users will be able to directly issue an update for the name, without having to interrogate the present value with `name_show`. This simplifies a common workflow.

This change is being made as part of the effort to simplify the RPC API for name management.
