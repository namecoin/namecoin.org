## Strict Transport Security

{{ page.application }} for {{ os }} can be used with Namecoin for Strict Transport Security; this improves security against sslstrip-style attacks by forcing HTTPS to be used for `.bit` domains that support HTTPS.  Instructions:

1. Install [ncdns]({{site.baseurl}}docs/ncdns/).
1. Download and extract the DNSSEC-HSTS Native Component from the [Beta Downloads]({{site.baseurl}}download/betas/#dnssec-hsts) page.
1. Install the DNSSEC-HSTS Native Component like this{% if nativemessagingdirrelative %} (substitute your {{ page.application }} directory){% endif %}:
   
       sudo mkdir -p {{ nativemessagingdir }}/
       sudo cp ./org.namecoin.dnssec_hsts.json {{ nativemessagingdir }}/
       sudo cp ./dnssec_hsts /usr/bin/
   
1. Go to `about:config` in {{ page.application }}.
1. Search for `xpinstall.signatures.required`.
1. If the `Value` column says `true`, double-click it to turn it to `false`.
1. Close the `about:config` tab in {{ page.application }}.
1. Restart {{ page.application }}.
1. Download the DNSSEC-HSTS WebExtensions Component from the [Beta Downloads]({{site.baseurl}}download/betas/#dnssec-hsts) page.
1. Open the DNSSEC-HSTS `.xpi` file in {{ page.application }}, and accept the extension installation dialog.

`.bit` domains that support HTTPS will now automatically redirect from HTTP to HTTPS in {{ page.application }}.
