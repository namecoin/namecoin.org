{% if os == "Windows" %}
{% assign rbmtarget = "ncdns-windows-x86_64" %}
{% assign libncp11file = "ncp11.dll" %}
{% assign libnssckbifile = "nssckbi.dll" %}
{% assign libnssckbitargetfile = "nssckbi-namecoin-target.dll" %}
{% endif %}

{% if os == "GNU/Linux" %}
{% assign rbmtarget = "ncdns-linux-x86_64" %}
{% assign libncp11file = "libncp11.so" %}
{% assign libnssckbifile = "libnssckbi.so" %}
{% assign libnssckbitargetfile = "libnssckbi-namecoin-target.so" %}
{% endif %}

{% if os == "macOS" %}
{% assign rbmtarget = "ncdns-osx-x86_64" %}
{% assign libncp11file = "libncp11.dylib" %}
{% assign libnssckbifile = "libnssckbi.dylib" %}
{% assign libnssckbitargetfile = "libnssckbi-namecoin-target.dylib" %}
{% endif %}

{% if page.application == "Tor Browser" %}
{% assign tornetwork = "1" %}
{% assign mozillapkix = "1" %}
{% endif %}

{% include tls_certdehydrate_dane_rest_api.md %}

## TLS Positive and Negative Overrides

{{ page.application }} for {{ os }} can be used with Namecoin for TLS positive and negative overrides; this allows certificates for `.bit` domains that match the blockchain to be used without errors, and prevents malicious or compromised public CA's from issuing certificates for `.bit` domains.  Instructions:

1. Install [ncdns]({{site.baseurl}}docs/ncdns/).
1. Download and extract certdehydrate-dane-rest-api and ncp11 from the [Beta Downloads]({{site.baseurl}}download/betas/) page.
1. Create a text file called `certdehydrate_dane_rest_api.conf` in the same directory where `{{ certdehydratedanerestapifile }}` is, and fill it with the following contents (if ncdns is listening on a different IP or port, change the following accordingly):
   
       [certdehydrate-dane-rest-api]
       nameserver="127.0.0.1"
       port="5391"
   
1. Run `{{ certdehydratedanerestapifile }}`.
1. If you want to test certdehydrate-dane-rest-api, try visiting `http://127.0.0.1:8080/lookup?domain=ca-test.bit` in a web browser.  You should see a certificate.  If you instead get an error or an empty page, something is wrong.
1. Make sure {{ page.application }} is installed.
{% if tornetwork %}1. Make sure {{ page.application }} is already [configured to use Namecoin for Tor name resolution]({{site.baseurl}}docs/tor-resolution/).
{% endif %}1. Make sure {{ page.application }} is shut down.
1. In {{ page.application }}'s `Browser` folder, rename `{{ libnssckbifile }}` to `{{ libnssckbitargetfile }}`.
1. Copy `{{ libncp11file }}` to {{ page.application }}'s `Browser` folder.
1. In {{ page.application }}'s `Browser` folder, rename `{{ libncp11file }}` to `{{ libnssckbifile }}`.

You can now visit in {{ page.application }} a `.bit` website that supports TLS, e.g. [the ncp11 test page](https://ca-test.bit/).  The website should load in {{ page.application }} without errors.  {% if mozillapkix %}Note that only CA trust anchors are accepted; end-entity trust anchors are not accepted.  This means that some older `.bit` domains will have their certificates rejected in {{ page.application }}.  We are working on contacting the affected `.bit` domain owners to ask them to upgrade their setup.{% endif %}

