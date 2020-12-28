---
layout: post
title: "Namecoin Core name_show name expiration"
author: yanmaani
tags: [News]
---

Namecoin Core will, starting version 0.21, change the default behavior of the `name_show` RPC API call in the presence of certain errors to better match the documentation, the behavior of Electrum-NMC, and the behavior expected by users.

When Namecoin Core was first written, it exposed name resolution using an inconsistent API.
When querying for a name that was not active, the behavior varied by the history of the name.
If it had never been registered, Namecoin would return an error.
If it had once been registered in the past, but was now expired, Namecoin would return a response that was deceptively similar to that returned when querying for names that were still active.

Owing to this inconsistency, some applications using Namecoin Core came to treat expired names as if they were still active.
This was a security problem.
Users continued to use services identified by the names as usual, and as such their operators did not re-register them, but Namecoin does not afford unregistered names any protection.
Therefore, anyone could have registered the names, thereby hijacking the services.
While this may be considered immaterial, it is our opinion that Namecoin should not indirectly encourage such dangerous use-cases.

Furthermore, those applications' use of the API for this purpose was incorrect.
Expired names should not be considered alive, and it can hardly be thought that considering them as such would have been the intent in implementing it.
A programmer who relied solely on the documentation ("Looks up the current data for the given name. Fails if the name doesn't exist.") would not be left with the impression that the operation would, in fact, only fail for never-registered names.

For these reasons, a change to the `name_show` API in Namecoin Core has been made.
`name_show` will now by default throw an error when attempting to resolve an expired name.
This brings the default behavior in line with Electrum-NMC, which has always thrown an error.
The old behavior can be preserved by setting the allowExpired option or -allow_expired command-line parameter to true.
There are presently no plans to deprecate these flags.

This change will be included in version 0.21 of Namecoin Core.
Downstream users who use `name_show` to resolve names for user-facing purposes should not need to make any changes to their usage.
Downstream users who use `name_show` to resolve names, but who would also like to distinguish between names that have expired and names that have never been registered, are encouraged to explore the allowExpired field in the JSON RPC options argument and the -allowexpired command line parameter.
In such cases, the old behavior still applies, whereby downstream users are expected to consider the value of the `expired` field to ascertain whether a domain has expired.

This change does not affect the resolution of active names in any way.
This change does not affect the `name_history` or `name_scan` RPC calls.
This change does not affect Electrum-NMC.
