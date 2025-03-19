---
layout: api-docs
page_title: "How to Get a Bearer Token"
seo_title: ""
description: ""
permalink: /get-a-bearer-token
in-page-nav: true
---

# {{ page.page_title }}

A bearer token, also known as an access token or JSON web token (JWT), authorizes use of the Beneficiary Claims Data API (BCDA) endpoints. After getting a bearer token, you can [access claims data]({{ '/access-claims-data' | relative_url }}) in the sandbox and production environments.

The sandbox environment (sandbox.bcda.cms.gov) can be accessed by anyone and contains test data. The production environment (api.bcda.cms.gov) is only available to organizations who have completed [onboarding]({{ '/production-access' | relative_url }}) and contains actual Medicare claims data. 

Whether you’re trying to access the sandbox or production environment, follow the instructions below to first obtain a bearer token. The steps are nearly identical for both environments, with minor differences in the source of your credentials and URL.  

## Instructions

<!-- Code snippets for instructions section BEGIN -->
{% capture Snippet1 %}{% raw %}
Example Client ID (Extra-Small Model Entities):
2462c96b-6427-4efb-aed7-118e20c2e997

Example Client Secret (Extra-Small Model Entities):
825598c105bd1fe021c9eb9d41b30e82beb7a505a1184282e69891f76aa0a396dc9d20f35c9df4a5
{% endraw %}{% endcapture %}

{% capture Snippet2 %}{% raw %}
POST /auth/token
{% endraw %}{% endcapture %}

{% capture Snippet3 %}{% raw %}
Authorization: Basic {base64_encoded_credentials}
Accept: application/json
{% endraw %}{% endcapture %}

{% capture Snippet4 %}{% raw %}
curl -d "" -X POST "https://sandbox.bcda.cms.gov/auth/token" \
	--user {client ID}:{client secret} \
	-H "Accept: application/json"
{% endraw %}{% endcapture %}

{% capture Snippet5 %}{% raw %}
{
"access_token": "eyJhbGciOiJSUzUxMiIsInR...", 
"expires_in": "1200",
"token_type":"bearer"
}
{% endraw %}{% endcapture %}

{% capture Snippet6 %}{% raw %}
Authorization: Bearer {bearer_token}
{% endraw %}{% endcapture %}

<!-- Code snippets for instructions section END -->


### 1. Get your organization's credentials

BCDA protects its token endpoint with Basic Auth. Your credentials will be formatted as a client ID and client secret.
- If you’re trying to access the **sandbox environment:** Use the sample client IDs and secrets provided in the [sandbox credentials section]({{ '/production-access' | relative_url }}).
- If you’re trying to access the **production environment:** Use the client ID and secret issued by your model-specific system during onboarding.

### 2. Request a bearer token

Start a request for a bearer token in your terminal window or using a tool such as Postman. For the examples below, you may use the credentials for the extra-small model entity in BCDA's sandbox environment:

#### Sample Credentials

{% include copy_snippet.html code=Snippet1 language="yaml" %}

#### Request to retrieve a token

{% include copy_snippet.html code=Snippet2 language="yaml" %}

#### Request header

The header contains “Authorization: Basic” followed by your credentials. The credentials (clientID:secret) must be joined by a colon, then encoded in Base64 format.

{% include copy_snippet.html code=Snippet3 language="yaml" %}

#### Example curl command to request a bearer token

In this example, the authorization in the request header is replaced with `--user {client ID}:{client secret}`. This command uses curl’s built-in ability to Base-64 encode your credentials, request, and receive your token in a single step.

{% include copy_snippet.html code=Snippet4 language="yaml" %}

<div class="usa-alert usa-alert--info">
    <div class="usa-alert__body">
        <h4 class="usa-alert__heading">Remember to use the correct URL for your environment</h4>
        <p class="usa-alert__text">
            Requests to get a bearer token contain a URL. Use <code>sandbox.bcda.cms.gov</code> to access the sandbox or <code>api.bcda.cms.gov</code> to access the production environment.
        </p>
    </div>
</div>

#### Response example: successful request

If your request succeeds, you’ll receive a 200 response with your bearer token in the response body. It’ll be the full text string that follows “access_token.” The token string below has been abbreviated for readability.

“Expires_in” counts down the seconds remaining before the token expires, which is 20 minutes after it is generated. “Token_type: Bearer” is a fixed value.

{% include copy_snippet.html code=Snippet5 language="yaml" %}

### 3. Set your bearer token in your request headers

You must include your bearer token in the authorization header when requesting data from /Group, /Patient, and other endpoints in the sandbox or production environment. “Bearer” must be included in the header with a capital B and followed by a space.

{% include copy_snippet.html code=Snippet6 language="yaml" %}

## Guides

Once you have a bearer token, learn [how to access claims data]({{ '/placeholder' | relative_url }}). This documentation can be used for both the sandbox and production environments, which are nearly identical. The biggest differences, as noted above, are the credentials you use and the URL in your requests. 

## Sandbox credentials

Sandbox credentials allow anyone to access synthetic claims data. BCDA has provided credentials for sample model entities which differ in the size of their data sets, ranging from 50 to 30,000 synthetic enrollees. This allows you to retrieve test claims data for whichever number of enrollees best matches the needs of your organization. 

These credentials will not work in the production environment. Remember that when getting a bearer token with sandbox credentials, you’ll need to use the sandbox URL (sandbox.bcda.cms.gov) in your requests. 

### Adjudicated claims data sets - 5 simple sizes
Adjudicated claims data is available to all eligible model entities. These 5 data sets are simple approximations of BCDA data. They are designed to test the stress of retrieving and downloading large data files into your internal ingestion processes. However, the data in these API payloads won’t reflect the distribution of disease and demographic information you might expect from production data.

#### Extra-small model entity (50 synthetic enrollees)

Client ID:

{% capture Snippet7 %}{% raw %}
2462c96b-6427-4efb-aed7-118e20c2e997
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet7 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet8 %}{% raw %}
825598c105bd1fe021c9eb9d41b30e82beb7a505a1184282e69891f76aa0a396dc9d20f35c9df4a5
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet8 language="yaml" can_copy=true %}

#### Extra-large model entity (30,000 synthetic enrollees)

Client ID:

{% capture Snippet9 %}{% raw %}
aa2d6b93-bbe7-4d1b-8cc5-9a5172fae3a6
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet9 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet10 %}{% raw %}
f35e507b5a744c311a89f8f1d8743f011daa390b128ce092e221120e88bd53cf22e3af58cd07c618
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet10 language="yaml" can_copy=true %}

### Adjudicated claims data sets – 2 advanced sizes

Advanced data sets offer a more accurate representation of BCDA production data. They follow BCDA’s Bulk FHIR format and contain a more realistic distribution of disease and demographic information. 

We suggest using the extra-small data set to view and understand the format of BCDA data. The large data set may be better for more in-depth exploration of the data or early load testing of your systems.

#### Extra-small model entity (100 synthetic enrollees)

Client ID:

{% capture Snippet11 %}{% raw %}
e75679c2-1b58-4cf5-8664-d3706de8caf5
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet11 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet12 %}{% raw %}
50eeab7d37a8bf17c8dad970116508f9656a1b0954fe9a467e4658643a4a877945a5096707da9e91
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet12 language="yaml" can_copy=true %}

#### Large advanced model entity (10,000 synthetic enrollees)

Client ID:

{% capture Snippet13 %}{% raw %}
0a0c75f0-da95-4198-9c0f-666b41e21017
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet13 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet14 %}{% raw %}
4c1145e6e294ec6852c0bf1c24b38c7f5af99a8a69423616ebb42af84db74fc903aad99b1632bf51
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet14 language="yaml" can_copy=true %}

### Partially adjudicated claims data sets 

Anyone can access [partially adjudicated claims]({{ '/access-claims-data' | relative_url }}) data sets in the sandbox. However, only organizations participating in the Accountable Care Organizations Realizing Equity, Access, and Community Health (ACO REACH) Model can access partially adjudicated claims data in the production environment. 

#### Extra-small REACH ACO (110 synthetic enrollees)

Client ID:

{% capture Snippet15 %}{% raw %}
7e57394f-eddb-46c7-a87b-a23f14ded95d
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet15 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet16 %}{% raw %}
433982182bf5e7b26da58a292e9a73b641f8711a3061c5c925a57a82478193b86d84cbdd3cf4006f
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet16 language="yaml" can_copy=true %}

#### Large REACH ACO (11,000 synthetic enrollees)

Client ID:

{% capture Snippet17 %}{% raw %}
2121efbd-98d2-4323-84db-974c8864abc7
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet17 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet18 %}{% raw %}
6eed5c5dd69422ca0f7cb0c4912e3e06c3cd043f2d22d71eee22ea224285e4b9e74667c0de004034
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet18 language="yaml" can_copy=true %}
