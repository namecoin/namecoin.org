# DNS Proxification in SocksTrace

Most SOCKS5 proxies (including Tor) only handle TCP traffic. DNS queries typically use UDP to servers like `8.8.8.8:53`. If those queries go through directly, they bypass the proxy entirely, leaking both the query and potentially your real IP address.

Getting DNS proxification right took three attempts.

## First Attempt: Intercept and Answer

The initial idea was straightforward. Intercept DNS at the syscall level and answer it ourselves.

We watched `sendmsg()` and checked whether the destination port was 53. If so, we extracted the queried domain, resolved it via Tor, and tried to send the DNS response back to the application directly.

This approach failed at the kernel boundary.

The DNS reply was blocked because the kernel dropped it. The source IP of the response didn't match the destination IP the application originally contacted. From the kernel's perspective, the packet was invalid, so it never reached userspace.

## Second Attempt: IP_TRANSPARENT

To work around this, we experimented with `IP_TRANSPARENT`.

`IP_TRANSPARENT` allows a process to bind and send packets using non-local source addresses, effectively impersonating the original DNS server. With this enabled, the kernel accepts the reply because the source and destination IPs now match what the application expects.

Technically, this fixed the problem.

Practically, it wasn't acceptable. It requires elevated privileges (`CAP_NET_ADMIN` or root).

## Third Attempt: Socket Hijacking

The final approach was to stop faking DNS responses and instead take control of the socket itself.

SocksTrace starts two local DNS servers, one for TCP and one for UDP. These servers resolve all incoming queries using Tor and return standard DNS responses.

When an application performs a DNS lookup, we intercept the `connect` syscall and hijack the socket at the kernel boundary. Rather than letting the socket reach the original resolver, we rebind the socket's communication path so that all subsequent reads and writes are transparently routed to our local DNS server.

From that point on, the socket behaves exactly as the application expects. The application continues unmodified, believes it is talking to a normal DNS resolver, and receives valid responses, while all resolution is enforced through Tor.

## Connectionless DNS Handling

Unlike TCP, UDP DNS does not require a `connect` syscall. Applications can send queries directly via `sendmsg()`, bypassing our socket-setup interception.

To detect this, SocksTrace checks whether a UDP packet sent to port 53 is using a socket that hasn't been previously connected. If so, we intercept the `sendmsg` syscall and rewrite the destination address in the application's memory before the syscall completes, redirecting its traffic to the local UDP DNS server.

## The Implementation

**For `connect()` syscalls** (when the app calls `connect()` on a socket to `8.8.8.8:53`):
We hijack the socket itself by directly connecting it to our local server:

```go
case "UDP":
    if err := unix.Connect(localFd, localDNSAddrUDP); err != nil {
        // handle error
    }
```

**For `sendmsg()` syscalls** (when the app sends data with a destination address embedded):
We rewrite the destination address in the application's memory before the syscall completes:

```go
if err := writeSockaddrInet4(mem, namePtr, localDNSAddrUDP); err != nil {
    // handle error
}
```

Either way, the app thinks it's talking to `8.8.8.8:53`, but the traffic goes to `127.0.0.1:randomport` instead. The local DNS server resolves the query through Tor using the SOCKS5 RESOLVE extension (command `0xF0`) and returns a standard DNS response.

## How Tor RESOLVE Works

The SOCKS5 protocol defines standard commands like CONNECT (0x01) for TCP connections. Tor extends this with RESOLVE (0xF0), which asks Tor to perform DNS resolution at the exit node.

The handshake is standard SOCKS5:

```
Client → Tor: VER=5, NMETHODS=1, METHODS=0x00 (No Auth)
Tor → Client: VER=5, METHOD=0x00
```

Then we send the RESOLVE request:

```
Client → Tor: VER=5, CMD=0xF0, RSV=0, ATYP=3 (Domain), LEN, DOMAIN, PORT=0
```

Tor performs the DNS lookup at the exit node and responds with the resolved IP:

```
Tor → Client: VER=5, REP=0, RSV=0, ATYP=1 (IPv4), IP, PORT=0
```

This is how DNS resolution stays anonymous. The lookup happens at the Tor exit node, not on your local network. Your ISP never sees the DNS query.
