{% if page.application == "Firefox" %}
{% assign enableaddonsdialog = "1" %}
{% assign nativemessaging = "1" %}
{% endif %}

{% include tls_certdehydrate_dane_rest_api.md %}

## Strict Transport Security

{{ page.application }} for {{ os }} can be used with Namecoin for Strict Transport Security; this improves security against sslstrip-style attacks by forcing HTTPS to be used for `.bit` domains that support HTTPS.  Instructions:

1. Install [ncdns]({{site.baseurl}}docs/ncdns/).
{% if nativemessaging %}1. Download and extract the DNSSEC-HSTS Native Component from the [Beta Downloads]({{site.baseurl}}download/betas/#dnssec-hsts) page.
1. Install the DNSSEC-HSTS Native Component like this:
   
       sudo cp ./org.namecoin.dnssec_hsts.json {{ nativemessagingdir }}/
       sudo cp ./dnssec_hsts /usr/bin/
   
{% else %}1. Download and extract certdehydrate-dane-rest-api from the [Beta Downloads]({{site.baseurl}}download/betas/#certdehydrate-dane-rest-api) page.
1. Create a text file called `certdehydrate_dane_rest_api.conf` in the same directory where `{{ certdehydratedanerestapifile }}` is, and fill it with the following contents (if ncdns is listening on a different IP or port, change the following accordingly):
   
       [certdehydrate-dane-rest-api]
       nameserver="127.0.0.1"
       port="5391"
   
1. Run `{{ certdehydratedanerestapifile }}`.
1. If you want to test certdehydrate-dane-rest-api, try visiting `http://127.0.0.1:8080/lookup?domain=ca-test.bit` in a web browser.  You should see a certificate.  If you instead get an error or an empty page, something is wrong.
{% endif %}1. Download the DNSSEC-HSTS WebExtensions Component from the [Beta Downloads]({{site.baseurl}}download/betas/#dnssec-hsts) page.
1. Install the DNSSEC-HSTS WebExtensions Component like this:
   
       unzip -d ./dnssec-hsts ./dnssec-hsts-*.xpi
       sudo rm -rf /usr/share/webext/dnssec-hsts/
       sudo cp -a ./dnssec-hsts /usr/share/webext/dnssec-hsts
       sudo ln -s -T /usr/share/webext/dnssec-hsts "{{ page.webextsystem }}/dnssec-hsts"
   

You may need to restart {{ page.application }}.  {% if enableaddonsdialog %}You may need to enable DNSSEC-HSTS in the {{ page.application }} Addons dialog.{% endif %}

`.bit` domains that support HTTPS will now automatically redirect from HTTP to HTTPS in {{ page.application }}.
