# WebRTC Proxy Leaks and Unix Socket Enforcement

## WebRTC Route Discovery and Proxy Leak Semantics

SocksTrace identified a WebRTC privacy vulnerability caused by a technique used during ICE (Interactive Connectivity Establishment) negotiation.

Browsers issue short-lived `connect()` calls on UDP sockets to Google DNS addresses (`8.8.8.8:53`) to determine the default local route. No packets are sent and the socket is immediately closed, but the syscalls bypass proxy routing and expose local addressing information.

### The Connected UDP Trick

These are `connect()` calls on UDP sockets used to discover which local address would be used to route to the internet in general. This is often called the "connected UDP trick."

From a network monitoring perspective, nothing happens. Wireshark would show no packets. But from a syscall monitoring perspective, the application is making direct network calls that bypass the proxy and reveal local routing information.

### What Counts as a Proxy Leak?

In practice, "proxy leak" can refer to multiple classes of behavior:

1. Outbound packets that do not go through the configured proxy.
2. Inbound or listening behavior that exposes network reachability outside the expected proxied path.
3. Any direct interaction with the host network stack that bypasses the proxy, even if no packets are emitted.

The network stack interaction enables the application to learn information about the user's network, and that information can then be transmitted over Tor. By analogy, an application that transmits your real IP address to a Tor onion service would surely still be considered a proxy leak! (This is not even a theoretical concern -- there are BitTorrent clients in the wild that have deanonymized users by sending their IP address in application-layer traffic.)

### Browser Responses

**Brave (Tor mode)** was affected by this issue. Brave acknowledged it and mitigated it by disabling WebRTC in Tor mode. The report was accepted and resulted in a **$400 bug bounty**.

**The Tor Browser Team** had already mitigated this issue in Mullvad Browser by disabling the "connected UDP trick" entirely, because leaking information about the user's local network, even without transmitting traffic outside the proxy, poses a privacy risk and could be used for fingerprinting.

This made it straightforward to confirm that SocksTrace was detecting a genuine proxy leak rather than a false positive. Mullvad Browser does not expose local addresses during ICE negotiation.

### Why Syscall Monitoring Matters

This illustrates a key advantage of SocksTrace. By monitoring syscalls directly, it can detect subtle privacy issues that tools like Wireshark would never reveal.

The `connect()` syscall on a UDP socket doesn't send any packets. It just tells the kernel to associate that socket with a destination address, which causes the kernel to select a local source address based on routing. No data leaves the machine, so network sniffers see nothing.

But the syscall still happened. The application still bypassed the proxy. And local routing information was still exposed. SocksTrace catches this because it operates at the syscall level, not the packet level.

## Unix Domain Socket Enforcement

Unix domain sockets use filesystem paths instead of network addresses. They cannot leak over the network because they only exist locally on the machine.

### Advantages of Unix Sockets

**Performance.** Unix sockets bypass the TCP/IP stack entirely. There's no network layer processing, no routing decisions, no packet fragmentation. Data is copied directly between processes.

**Lower resource overhead.** No need to allocate ports, maintain connection state for the network stack, or handle TCP retransmission logic. The kernel handles it as a simple IPC mechanism.

**Security.** Unix sockets cannot be accessed from another machine. Access is controlled by filesystem permissions.

### Enforcement

The `--enforce-unix-socks` flag enables a whitelist approach. Only `AF_UNIX` connections are allowed. Everything else is blocked.

```go
if enforceUnixSocks {
    if addr.Family != unix.AF_UNIX {
        logger.Warn().Msgf("%s blocked (only Unix sockets allowed): %s", syscallName, addr.String())
        return 0, 0, 0
    }
}
```

This is useful when Tor is configured to listen on a Unix socket (e.g., `/run/tor/socks`) instead of a TCP port. By forcing applications to only use Unix sockets for SOCKS connections, any attempt to open an IPv4 or IPv6 connection is blocked.

The address parser handles both filesystem paths and abstract sockets (paths starting with null bytes).

## Continuous Integration Tests

Two new CI tests were added to sockstrace.

The first test runs Firefox under Sockstrace to check for potential WebRTC-related proxy leaks, ensuring that Sockstrace correctly detects any connections that might bypass the configured proxy.

The second test verifies that SOCKSification works correctly, confirming that applications routed through Sockstrace properly use the configured SOCKS proxy.