---
layout: api-docs
page_title: "How to Get a Bearer Token"
seo_title: ""
description: ""
in-page-nav: true
---

# {{ page.page_title }}

Bearer tokens, also known as access tokens or JSON web tokens, authorize use of the Beneficiary Claims Data API (BCDA) endpoints. You will need a bearer token to [access claims data]({{ '/access-claims-data.html' | relative_url }}) in the sandbox and production environments.

## Instructions

<!-- Code snippets for instructions section BEGIN -->
{% capture Snippet1 %}{% raw %}
Example Client ID (Extra-Small Model Entities):
2462c96b-6427-4efb-aed7-118e20c2e997

Example Client Secret (Extra-Small Model Entities):
e5bf53ec3a4304ab43c00155cfe1f01a00a6f6003ad07d323b3b6bce9ad4ae5b137ef4e8509d881b
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
  "token_type": "bearer"
}
{% endraw %}{% endcapture %}

{% capture Snippet6 %}{% raw %}
Authorization: Bearer {bearer_token}
{% endraw %}{% endcapture %}

<!-- Code snippets for instructions section END -->


### 1. Get your organization's credentials

BCDA protects its token endpoint with Basic Auth. Your credentials will be formatted as a client ID and client secret.
- If you’re trying to access the **sandbox environment:** Use a sample client ID and secret from the [sandbox credentials section]({{ '/get-a-bearer-token.html' | relative_url }}#sandbox-credentials).
- If you’re trying to access the **production environment:** Use the client ID and secret issued by your model-specific system during [production access]({{ '/production-access.html' | relative_url }}).

### 2. Request a bearer token

Start a request in your terminal window or using a tool like Postman.

#### Request to retrieve a token

{% include copy_snippet.html code=Snippet2 language="yaml" %}

#### Request header

The header has “Authorization: Basic” followed by the credentials. Credentials (clientID:secret) are joined by a colon, then encoded in Base64 format.

{% include copy_snippet.html code=Snippet3 language="yaml" %}

#### Example curl command to request a bearer token

In this example, the authorization in the request header is replaced with `--user {client ID}:{client secret}` 

This command uses curl’s built-in ability to Base-64 encode your credentials, request, and receive your token in a single step.

{% include copy_snippet.html code=Snippet4 language="shell" can_copy=true %}

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold">Remember to use the correct URL for your environment</p>
        <p class="usa-alert__text">
            Use sandbox.bcda.cms.gov to access the sandbox or api.bcda.cms.gov to access the production environment.
        </p>
    </div>
</div>

#### Response example: successful request

If your request succeeds, you’ll receive a 200 response with your bearer token in the response body. It’ll be the full text string that follows “access_token”. The token string below has been abbreviated for readability.

“Expires_in” counts down the seconds remaining before the token expires, which is 20 minutes after it is generated. “Token_type: Bearer” is a fixed value.

{% include copy_snippet.html code=Snippet5 language="json" %}

### 3. Set your bearer token in your request headers

Include your bearer token in the authorization header when requesting data in the sandbox and production environments. “Bearer” must be included in the header with a capital B and followed by a space.

{% include copy_snippet.html code=Snippet6 language="yaml" %}

Now you can begin [accessing claims data]({{ '/access-claims-data.html' | relative_url }}). The production and sandbox environments support the same workflow, endpoints, and resource types.  

## Sandbox credentials

Sandbox credentials allow anyone to access test claims data. These credentials will not work in the production environment. 

Sample data sets vary in size and data complexity, ranging from 50 to 30,000 synthetic enrollees, to best match the needs of your model entity.  

### Adjudicated claims data sets - 5 simple sizes
Use the data sets to test retrieving and downloading data files into your internal ingestion processes. However, the test data may not reflect an accurate distribution of disease and demographic information.

#### Extra-small model entity (50 synthetic enrollees)

Client ID:

{% capture Snippet7 %}{% raw %}
2462c96b-6427-4efb-aed7-118e20c2e997
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet7 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet8 %}{% raw %}
e5bf53ec3a4304ab43c00155cfe1f01a00a6f6003ad07d323b3b6bce9ad4ae5b137ef4e8509d881b
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
97755772b3fb7b3fa2f58c5c3aaaffbc7e346639ff8da371a81adf79889c8fbd4c40398cd39d211d
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
67570807508212a220cc364d4406b9bd560276142d46257f76ba28dd9a0ff969e0c26db21c9d925c
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
c637024fa21adda5a756a2753cf7eb9bd62292e7897fb965a5c7aeeed23e1728ddc9ec6863f09f15
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet14 language="yaml" can_copy=true %}

### Partially adjudicated claims data sets 

Anyone can access [partially adjudicated claims data]({{ '/partially-adjudicated-claims-data.html' | relative_url }}) in the sandbox. Only REACH ACOs can access enrollees' partially adjudicated claims data during production. 

#### Extra-small REACH ACO (110 synthetic enrollees)

Client ID:

{% capture Snippet15 %}{% raw %}
7e57394f-eddb-46c7-a87b-a23f14ded95d
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet15 language="yaml" can_copy=true %}

Client secret:

{% capture Snippet16 %}{% raw %}
3ab22e7faaf69fa2d572831ffc1db12252c6d569d3e1b54aecf56e075ba054c20fee83b2e013c9c3
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
ee1b0609f024a758bf1770ec16f809330d2ba8bb4e9004a7868c0258accfd69ced5b6448188abb7b
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet18 language="yaml" can_copy=true %}
