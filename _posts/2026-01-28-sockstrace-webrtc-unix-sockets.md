# WebRTC Proxy Leaks and Unix Socket Enforcement

## WebRTC Proxy Leaks in Brave, Firefox, and Chromium

SocksTrace identified a WebRTC-related proxy leak in Firefox, Brave, and Chromium caused by a technique used during ICE (Interactive Connectivity Establishment) negotiation.

Browsers issue short-lived `connect()` calls on UDP sockets to Google DNS addresses (`8.8.8.8:53`) to determine the default local route. No packets are sent and the socket is immediately closed, but the syscalls bypass proxy routing and expose local addressing information.

### The Connected UDP Trick

In Firefox, Mozilla explained that these are `connect()` calls on UDP sockets used to discover which local address would be used to route to the internet in general. They refer to this as the "connected UDP trick." They emphasized that no network traffic occurs and that the socket is immediately closed.

From a network monitoring perspective, nothing happens. Wireshark would show no packets. But from a syscall monitoring perspective, the application is making direct network calls that bypass the proxy and reveal local routing information.

### Browser Responses

**Brave (Tor mode)** was affected by the same issue. In contrast to Mozilla's response, Brave acknowledged the leak and mitigated it by disabling WebRTC in Tor mode. The report was accepted and resulted in a **$400 bug bounty**.

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
