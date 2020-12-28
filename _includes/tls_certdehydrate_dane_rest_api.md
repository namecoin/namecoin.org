{% if os == "Windows" %}
{% assign certdehydratedanerestapifile = "certdehydrate-dane-rest-api.exe" %}
{% endif %}

{% if os == "GNU/Linux" %}
{% assign certdehydratedanerestapifile = "certdehydrate-dane-rest-api" %}
{% endif %}

{% if os == "macOS" %}
{% assign certdehydratedanerestapifile = "certdehydrate-dane-rest-api" %}
{% endif %}
