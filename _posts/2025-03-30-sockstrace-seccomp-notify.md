---
layout: post
title: "Enhancing Proxy Leak Detection with sockstrace: From ptrace to seccomp notify"
author: Robert Nganga
tags: [News]
---

## Switching from ptrace to seccomp notify

Initially, sockstrace relied on `ptrace` to trace connect syscalls. While `ptrace` works well for simple programs, it wasn’t practical for high-performance applications, especially browsers.

### Why switch to seccomp notify?
* Performance: ptrace slowed down applications significantly, making it impractical for real-time proxy leak detection.
* Scalability: Large, multithreaded programs like browsers were difficult to trace effectively using ptrace.
* More precise control: seccomp notify allows sockstrace to intercept only the syscalls it cares about, without stepping through every syscall like ptrace does.

### How the transition works
Instead of using `PTRACE_SYSCALL` to catch connect, sockstrace now sets up a seccomp filter with `SECCOMP_RET_USER_NOTIF`. This allows user-space handling of specific syscalls, without the overhead of stepping through every process instruction. When connect is intercepted, sockstrace can inspect the syscall parameters, decide whether to allow or deny it, and act accordingly.

## Whitelisting syscalls

With `seccomp`, sockstrace can define a strict policy that only allows necessary syscalls, blocking everything else.

### Why syscall whitelisting matters
* Reduces the attack surface by preventing unnecessary syscalls.
* Ensures sockstrace only intercepts network-related calls without interfering with other system behavior.
* Can be extended for different security policies.

### Implementation details
Using `go-seccomp-bpf`, sockstrace creates a seccomp filter that:
* Blocks all syscalls by default (ActionErrno).
* Explicitly allows safe syscalls like read, write and exit.
* Uses `seccomp.ActionTrace` to intercept connect for analysis.
This prevents unauthorized connections while ensuring minimal disruption to the application's normal behavior.

## Configuring TCP blocking
A new feature in sockstrace allows users to decide whether to block incoming TCP connections.

### How does it work?
By intercepting `bind`, `accept`, `accept4`, and `listen`, sockstrace can monitor and control incoming TCP connections.

### Configurable blocking options
Currently, sockstrace offers two options for incoming TCP connections:

* Allow all incoming connections.
* Block all incoming connections (to prevent accidental exposure).

We are also working on an option to allow only specific addresses, adding more fine-grained control.