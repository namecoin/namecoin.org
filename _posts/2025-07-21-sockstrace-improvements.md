---
layout: post
title: "Improving sockstrace: Debugging, Process Control, and Proxy Rules"
author: Robert Nganga
tags: [News]
---

sockstrace just got a major update. Here's a quick overview of the new features:

## Core Dump & Stack Trace
When a proxy leak is detected, sockstrace can:

Stack Trace: Extract a stack trace of the leaking process to show where in the code the leak occurred. This uses `gdb` behind the scenes, so the trace includes detailed symbol infomation (if available).

Core Dump: Creates a full core dump of the leaking process by sending `SIGABRT.` Before triggering it, sockstrace checks that `ulimit` allows dumping. The resulting core can be loaded into GDB for full post-mortem analysis, including memory, registers, and detailed traces.

## Kill All Tracees (Including Children)
Previously, sockstrace only supported killing the specific PID that triggered the leak. In multi-process applications like browsers, this often left child processes alive, leading to inconsistent behavior or silent failures.

Now, it can recursively terminate the entire process tree rooted at that PID, ensuring:
* A clearer signal to the user that something went wrong (Avoid silent failures)
* No zombie processes are left behind

## Whitelist for Incoming TCP Connections
You can now define a whitelist of allowed source IPs or subnets for incoming TCP connections.
sockstrace enforces the whitelist by intercepting the `bind` and `listen` syscalls: it parses the bind address from the syscall arguments, and on listen, it calls `syscall.Getsockname` to retrieve the actual bound address. This address is then checked against a user-defined whitelist, and if it doesn't match, the bind is flagged as a leak or blocked based on the configuration. 

This is useful because:
* It blocks unexpected incoming connections.
* It ensures only known gateways (e.g. Tor) are allowed to connect, as in Whonix-like setups.
* It catches misconfigured or unsafe behavior in network-facing apps.

## SOCKS5 Handshake Enforcement
sockstrace now enforces SOCKS5 rules by intercepting the `sendto` syscall and parsing the actual handshake data.

Parse & Validate Structure: Verifies the SOCKS5 version, authentication methods, and field layout directly from the syscall. Rejects malformed or legacy handshakes.

Require Authentication: Flags connections that use no-auth `(0x00)` as leaks. This helps catch unsafe fallback behavior.

Tor-Compatible Isolation: Supports enforcing Tor-style stream isolation using SOCKS5 username/password fields. While implementing this, we also fixed a few typos and ambiguities in the [Tor spec](https://spec.torproject.org/socks-extensions.html).

Regex-Based Rules: Users can define custom regex patterns for valid auth fields (e.g. session-*, profile-[0-9]+) to ensure proper identity separation.

This gives fine-grained control over SOCKS5 behavior and helps detect apps that bypass proxy isolation.

This work was funded by NLnet Foundation's Next Generation Internet Zero Core Fund.
