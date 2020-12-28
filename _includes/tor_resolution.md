{% if controller == "TorNS" %}
{% assign controllergit = "https://github.com/meejah/TorNS" %}
{% assign controllerpython = "python2" %}
{% endif %}

{% if controller == "StemNS" %}
{% assign controllergit = "https://github.com/namecoin/StemNS" %}
{% assign controllerpython = "python3" %}
{% endif %}

Namecoin can be used for name resolution with Tor.  This guide covers how to set this up using {{ prop279 }} and {{ controller }}.

**Warning: this is beta software, and is not suitable for production use.  It is being made available for testing purposes only.  It's using experimental API's that may be replaced or removed in the future, and it will make your Tor client stand out from everyone else.**

## Install Tor

Hopefully you've already done this.  Note that these instructions are not tested in any way with Whonix, Tails, or Subgraph OS; such systems use control port filters that may cause problems.

## Install a Namecoin name lookup client

{% if prop279 == "dns-prop279" %} **If you're using the ncdns for Windows installer, you can skip this step.** {% endif %}

This could be either Namecoin Core or ConsensusJ-Namecoin.  Note that if you're using Namecoin Core, you may wish to make Namecoin Core route its traffic over Tor (this procedure should be identical as what you'd do for Bitcoin Core).  ConsensusJ-Namecoin doesn't yet support routing its traffic over Tor.  If you're using ConsensusJ-Namecoin, it is strongly recommended that you use `leveldbtxcache` mode (this is the default if you're running the shortcut created by the ncdns for Windows installer; it is **not** the default if you're running it from the command line); this is because the other modes will generate network traffic that isn't subject to stream isolation.  Electrum-NMC is not recommended because it will generate network traffic that isn't subject to stream isolation.

{% if prop279 == "dns-prop279" %}

## Install ncdns

See [ncdns documentation]({{site.baseurl}}docs/ncdns).

You should install ncdns on a machine which has a trusted network path to the machine running Tor.  It is **not** necessary to install Dnssec-Trigger if you're only planning to use Namecoin resolution with Tor.

**Warning: ncdns caches responses by default, which may pose a deanonymization vector.**

{% endif %}

## Install {{ prop279 }}

{{ prop279 }} can be downloaded at the [Beta Downloads]({{site.baseurl}}download/betas/#{{ prop279 }}) page.  The build is not yet reproducible.

If you want to build from source:

~~~
go get github.com/namecoin/{{ prop279 }}
~~~

{% if prop279 == "dns-prop279" %}

**Warning: all errors encountered by dns-prop279 will be reported as NXDOMAIN, even if that's not the actual error that occurred.**

{% endif %}

## Install {{ controller }}

{{ controller }} {% if controller == "TorNS" %} (by meejah) {% endif %} is [available on GitHub.]({{ controllergit }})

The `_service_to_command` configuration in {% if controller == "TorNS" %}[poc.py](https://github.com/meejah/TorNS/blob/5ed4abe5717a6fe713220dee853bb657b1064e8c/poc.py#L26){% endif %} {% if controller == "StemNS" %}`settings_services.py`{% endif %} should look like this ({% if prop279 == "dns-prop279" %}assuming that ncdns is listening on 127.0.0.1 port 5391; {% endif %}fill in the path to where your {{ prop279 }} binary is located accordingly):

~~~
_service_to_command = {
    "bit.onion": ['/path/to/{{ prop279 }}'{% if prop279 == "dns-prop279" %}, '-port', '5391', '@127.0.0.1'{% endif %}],
    "bit": ['/path/to/{{ prop279 }}'{% if prop279 == "dns-prop279" %}, '-port', '5391', '@127.0.0.1'{% endif %}],
}
~~~

If you're using Tor Browser Bundle, or are otherwise using a non-default Tor control port, you'll need to update the control port in {% if controller == "TorNS" %} `poc.py` {% endif %} {% if controller == "StemNS" %} `settings_port.py`{% endif %}{% if controller == "TorNS" %} as per the TorNS documentation{% endif %}.

{% if controller == "StemNS" %}

## Configure Tor

Tor must be configured with the following option:

~~~
__LeaveStreamsUnattached 1
~~~

In a typical Tor Browser installation, `torrc-defaults` is the correct place to add this option.

{% endif %}

## Running it

Make sure that the name lookup client{% if prop279 == "dns-prop279" %}, ncdns,{% endif %} and Tor are running.  Then, run `{{ controllerpython }} poc.py` in the {{ controller }} directory.  It should automatically configure Tor to use Namecoin for any domain name lookups that end in `.bit` or `.bit.onion`.  Here's a screenshot of [the Tor example rendezvous points page](http://federalistpapers.bit.onion/):

![Screenshot.]({{site.baseurl}}images/screenshots/tor/tor-browser-onion-2018-08-01.png)

Semantically, `.bit.onion` means that a domain name will always resolve to a `.onion` address (meaning that `.bit.onion` names are encrypted and authenticated regardless of whether TLS is used); `.bit` means that a domain name will resolve to any of `.onion`, IPv6, IPv4, or CNAME, meaning that `.bit` names are only encrypted and authenticated if TLS is used.  These semantics are open to revision later, as the Tor community evolves its canonical naming semantics.

Namecoin name owners can specify a `.onion` domain via the `txt` field in the `_tor` subdomain of their name.  This specification is open to revision later, as the Tor community evolves its canonical naming specifications.  (In particular, it is possible that `TXT` records might be replaced with `SRV` records.)
