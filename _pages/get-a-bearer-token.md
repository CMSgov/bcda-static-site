---
layout: api-docs
page_title: "How to Get a Bearer Token"
seo_title: ""
description: ""
permalink: /get-a-bearer-token
in-page-nav: true
---

# {{ page.page_title }}

Bearer tokens, also known as access tokens or JSON web tokens, authorize use of the Beneficiary Claims Data API (BCDA) endpoints. You will need a bearer token to [access claims data]({{ '/access-claims-data' | relative_url }}) in the sandbox and production environments.

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
- If you’re trying to access the **sandbox environment:** Use a sample client ID and secret from the [sandbox credentials section]({{ '/get-a-bearer-token' | relative_url }}#sandbox-credentials).
- If you’re trying to access the **production environment:** Use the client ID and secret issued by your model-specific system during [production access]({{ '/production-access' | relative_url }}).

### 2. Request a bearer token

Start a request in your terminal window or using a tool like Postman. The examples below use sandbox credentials for the extra-small model entity:

#### Sample credentials

{% include copy_snippet.html code=Snippet1 language="yaml" %}

#### Request to retrieve a token

{% include copy_snippet.html code=Snippet2 language="yaml" %}

#### Request header

The header has “Authorization: Basic” followed by the credentials. Credentials (clientID:secret) are joined by a colon, then encoded in Base64 format.

{% include copy_snippet.html code=Snippet3 language="yaml" %}

#### Example curl command to request a bearer token

In this example, the authorization in the request header is replaced with `--user {client ID}:{client secret}` 

This command uses curl’s built-in ability to Base-64 encode your credentials, request, and receive your token in a single step.

{% include copy_snippet.html code=Snippet4 language="yaml" can_copy=true %}

<div class="usa-alert usa-alert--info">
    <div class="usa-alert__body">
        <h4 class="usa-alert__heading">Remember to use the correct URL for your environment</h4>
        <p class="usa-alert__text">
            Use sandbox.bcda.cms.gov to access the sandbox or api.bcda.cms.gov to access the production environment.
        </p>
    </div>
</div>

#### Response example: successful request

If your request succeeds, you’ll receive a 200 response with your bearer token in the response body. It’ll be the full text string that follows “access_token”. The token string below has been abbreviated for readability.

“Expires_in” counts down the seconds remaining before the token expires, which is 20 minutes after it is generated. “Token_type: Bearer” is a fixed value.

{% include copy_snippet.html code=Snippet5 language="yaml" %}

### 3. Set your bearer token in your request headers

Include your bearer token in the authorization header when requesting data in the sandbox and production environments. “Bearer” must be included in the header with a capital B and followed by a space.

{% include copy_snippet.html code=Snippet6 language="yaml" %}

## Guides

Once you have a bearer token, begin [accessing claims data]({{ '/access-claims-data' | relative_url }}). The production and sandbox environments use the same workflow, endpoints, and resource types.  

## Sandbox credentials

Sandbox credentials allow anyone to access test claims data. These credentials will not work in the production environment. 

Sample data sets vary in size, ranging from 50 to 30,000 synthetic enrollees, to best match the needs of your model entity.  

### Adjudicated claims data sets - 5 simple sizes
The data sets are designed to test the stress of retrieving and downloading large data files into your internal ingestion processes. However, the test data may not reflect an accurate distribution of disease and demographic information.

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

Advanced data sets offer a more accurate representation with the bulk FHIR format and a realistic distribution of disease and demographic information. 

The small data set helps you understand the format of BCDA data. The large data set is better for in-depth exploration or early load testing of your systems.

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

Anyone can access [partially adjudicated claims data]({{ '/partially-adjudicated-claims-data' | relative_url }}) in the sandbox. Only REACH ACOs can access enrollees' partially adjudicated claims data during production. 

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
