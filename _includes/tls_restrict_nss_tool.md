## TLS Negative Overrides{% if tlsrestrictnsstoolmethodnum %} (Method {{ tlsrestrictnsstoolmethodnum }}){% endif %}

{{ page.application }} for {{ os }} can be used with Namecoin for TLS negative overrides; this prevents malicious or compromised public CA's from issuing certificates for `.bit` domains.  Instructions:

{% if hpkpenforce %}**Important warning for users of TLS intercepting proxies: these instructions will probably cause your intercepting proxy to produce an HPKP error for HTTPS websites that use HPKP.  Right now, Namecoin TLS negative overrides for {{ page.application }} are not compatible with TLS intercepting proxies that try to intercept HPKP-enabled websites.  If you haven't deliberately installed a TLS intercepting proxy, or if you don't know what a TLS intercepting proxy is, you can probably ignore this warning.**{% endif %}

{% if hpkpenforce %}**Note: Installing Namecoin TLS negative overrides for {{ page.application }} might cause previously-unnoticed attacks against you, e.g. from malicious surveillance infrastructure, to produce visible errors (even if those attacks are trying to intercept non-Namecoin connections).**{% endif %}

{% if hpkpenforce %}1. Go to `about:config` in {{ page.application }}.
1. Search for `security.cert_pinning.enforcement_level`.
1. Double-click the `security.cert_pinning.enforcement_level` preference.
1. Enter `2` and click OK.
1. Search for `security.cert_pinning.process_headers_from_non_builtin_roots`.
1. Double-click the `security.cert_pinning.process_headers_from_non_builtin_roots` preference until the `Value` column says `true`.
1. Close the `about:config` tab in {{ page.application }}.
1. Restart {{ page.application }}.
{% endif %}{% if os == "Windows" %}1. Install the [Visual C++ 2010 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=26999).
1. Install the [Visual C++ 2015 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=53587).
1. Download `mar-tools-win32.zip` or `mar-tools-win64.zip` (depending on whether you're on 32-bit or 64-bit Windows) from [Tor's download page](https://dist.torproject.org/torbrowser/).
1. Extract the following files from the `mar-tools` zip to a new `mar-tools-32` or `mar-tools-64` (depending on whether you're on 32-bit or 64-bit Windows) subdirectory of the directory where `tlsrestrict_nss_tool.exe` is:
    * `certutil.exe`
    * `freebl3.dll`
    * `mozglue.dll`
    * `nss3.dll`
    * `nssdbm3.dll`
    * `softokn3.dll`
1. Rename `certutil.exe` to `nss-certutil.exe`.
1. To recap, if `tlsrestrict_nss_tool.exe` is in `C:\Users\Edward\Downloads\tlsrestrict_nss_tool.exe` on 64-bit Windows, then there should also be `C:\Users\Edward\Downloads\mar-tools-64\nss-certutil.exe`.
{% endif %}1. Create a temporary directory; make sure that it only is readable/writeable by a user whom you trust with access to the {{ page.application }} certificate database.  Note its path; make sure you use forward-slashes instead of backslashes, and leave off the trailing slash.
{% if nssdbdirsubdir %}1. Find your NSS directory; it will usually be a subdirectory of `{{ nssdbdir }}`.  For example, `{{ nssdbdir }}/r3a8ono6.default`.  Make sure you use forward-slashes instead of backslashes, and leave off the trailing slash.
{% if os == "Windows" %}1. Find the directory where `nssckbi.dll` is located.  This will usually be `C:/Program Files/Mozilla Firefox`.  Make sure you use forward-slashes instead of backslashes, and leave off the trailing slash.
1. Run the following, substituting the temporary directory, NSS directory, and CKBI directory for `$TEMP_DIR`, `$NSS_DIR`, and `$CKBI_DIR`:
   
       tlsrestrict_nss_tool.exe "--tlsrestrict.nss-temp-db-dir=$TEMP_DIR" "--tlsrestrict.nss-dest-db-dir=$NSS_DIR" "--tlsrestrict.nss-ckbi-dir=$CKBI_DIR"
   {% else %}1. Run the following, substituting the temporary directory and NSS directory for `$TEMP_DIR` and `$NSS_DIR`:
   
       ./tlsrestrict_nss_tool --tlsrestrict.nss-temp-db-dir="$TEMP_DIR" --tlsrestrict.nss-dest-db-dir="$NSS_DIR"
   {% endif %}{% else %}1. Run the following, substituting the temporary directory for `$TEMP_DIR`:
   
       ./tlsrestrict_nss_tool --tlsrestrict.nss-temp-db-dir="$TEMP_DIR" --tlsrestrict.nss-dest-db-dir="{{ nssdbdir }}"
   {% endif %}
1. Wait a few minutes for `tlsrestrict_nss_tool` to finish running.

You'll need to rerun the above `tlsrestrict_nss_tool` command whenever the built-in certificate list is updated.{% if hpkpenforce %}  You won't need to redo the `about:config` steps, though.{% endif %}

If you've manually imported any non-built-in TLS trust anchors to {{ page.application }}, and you want to restrict them from intercepting `.bit` traffic, you should do the following for each such trust anchor:

1. Get a DER-encoded certificate of the trust anchor.
1. Run the following, substituing the path to your trust anchor certificate for `$CERT_PATH`:
   
       {% if os == "Windows" %}cross_sign_name_constraint_tool.exe "--cert.input-root-ca-path=$CERT_PATH"{% else %}./cross_sign_name_constraint_tool --cert.input-root-ca-path="$CERT_PATH"{% endif %}
   
1. 3 new certificates will be created: `root.crt`, `intermediate.crt`, and `cross-signed.crt`.
1. Delete the existing trust anchor from {{ page.application }}.
1. Import `root.crt` into {{ page.application }}; mark it as a trusted TLS root CA.
1. Import `intermediate.crt` and `cross-signed.crt` into {{ page.application }}; do not mark them as trusted.

If you decide later that you want to remove the negative overrides from {{ page.application }}, follow these instructions:

1. Run the following:
   
       {% if os == "Windows" %}tlsrestrict_nss_tool.exe "--tlsrestrict.nss-temp-db-dir=$TEMP_DIR" "--tlsrestrict.nss-dest-db-dir={% if nssdbdirsubdir %}$NSS_DIR{% else %}{{ nssdbdir }}{% endif %}" "--tlsrestrict.nss-ckbi-dir=$CKBI_DIR" --tlsrestrict.undo{% else %}./tlsrestrict_nss_tool --tlsrestrict.nss-temp-db-dir="$TEMP_DIR" --tlsrestrict.nss-dest-db-dir="{% if nssdbdirsubdir %}$NSS_DIR{% else %}{{ nssdbdir }}{% endif %}" --tlsrestrict.undo{% endif %}
   
1. Wait a few minutes for `tlsrestrict_nss_tool` to finish running.
{% if hpkpenforce %}1. If you want to restore compatibility with TLS intercepting proxies, follow these steps.  If you don't want to use a TLS intercepting proxy, or if you don't know what a TLS intercepting proxy is, you probably don't need to do this.
    1. Go to `about:config` in {{ page.application }}.
    1. Search for `security.cert_pinning.enforcement_level`.
    1. Right-click the `security.cert_pinning.enforcement_level` preference.
    1. Click `Reset`.
    1. Search for `security.cert_pinning.process_headers_from_non_builtin_roots`.
    1. Right-click the `security.cert_pinning.process_headers_from_non_builtin_roots` preference.
    1. Click `Reset`.
    1. Close the `about:config` tab in {{ page.application }}.
    1. Restart {{ page.application }}.{% endif %}

### Screenshot

If a `.bit` HTTPS website uses a CA-signed certificate that doesn't match the Namecoin blockchain, an error like this will be displayed:

![start.fedoraproject.org uses an invalid security certificate.  The certificate is not trusted because the issuer certificate is unknown.  The server might not be sending the appropriate intermediate certificates.  An additional root certificate may need to be imported.]({{site.baseurl}}images/screenshots/tls/tls-reject-firefox-linux-2018-08-01.png)
