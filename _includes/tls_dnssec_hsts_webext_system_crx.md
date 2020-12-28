{% include tls_certdehydrate_dane_rest_api.md %}

## Strict Transport Security

{{ page.application }} for {{ os }} can be used with Namecoin for Strict Transport Security; this improves security against sslstrip-style attacks by forcing HTTPS to be used for `.bit` domains that support HTTPS.  Instructions:

1. Install [ncdns]({{site.baseurl}}docs/ncdns/).
1. Download and extract certdehydrate-dane-rest-api from the [Beta Downloads]({{site.baseurl}}download/betas/#certdehydrate-dane-rest-api) page.
1. Create a text file called `certdehydrate_dane_rest_api.conf` in the same directory where `{{ certdehydratedanerestapifile }}` is, and fill it with the following contents (if ncdns is listening on a different IP or port, change the following accordingly):
   
       [certdehydrate-dane-rest-api]
       nameserver="127.0.0.1"
       port="5391"
   
1. Run `{{ certdehydratedanerestapifile }}`.
1. If you want to test certdehydrate-dane-rest-api, try visiting `http://127.0.0.1:8080/lookup?domain=ca-test.bit` in a web browser.  You should see a certificate.  If you instead get an error or an empty page, something is wrong.
1. Download and extract the DNSSEC-HSTS WebExtensions Component for {{ page.application }} from the [Beta Downloads]({{site.baseurl}}download/betas/#dnssec-hsts) page.
1. Install the DNSSEC-HSTS WebExtensions Component like this:
   
       sudo mkdir /usr/local/namecoin/ /usr/share/google-chrome/extensions/
       sudo cp ./dnssec-hsts*.crx /usr/local/namecoin/dnssec-hsts.crx
       sudo chmod +r /usr/local/namecoin/dnssec-hsts.crx
       sudo cp ./ogimlildljgffpifafnhjggflenjhljf.json /usr/share/google-chrome/extensions/
       sudo chmod +r /usr/share/google-chrome/extensions/ogimlildljgffpifafnhjggflenjhljf.json
   

You may need to restart {{ page.application }}.

`.bit` domains that support HTTPS will now automatically redirect from HTTP to HTTPS in {{ page.application }}.
