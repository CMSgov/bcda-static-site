---
layout: api-docs
page_title: "How to Get a Bearer Token"
seo_title: ""
description: "Get a bearer token to authenticate requests to BCDA for secure access to Medicare enrollee claims data."
in-page-nav: true
feedback_id: "ea9de8b3"
---

# {{ page.page_title }}

Bearer tokens, also known as access tokens or JSON web tokens, authorize use of the Beneficiary Claims Data API (BCDA) endpoints. You will need a bearer token to [access claims data]({{ '/api-documentation/access-claims-data.html' | relative_url }}) in the sandbox and production environments.

## Instructions

### 1. Get your organization's credentials

BCDA protects its token endpoint with Basic Auth. Your credentials will be formatted as a client ID and client secret.
- **Sandbox environment**: Use a sample client ID and secret from the [sandbox credentials section]({{ '/api-documentation/get-a-bearer-token.html' | relative_url }}#sandbox-credentials).
- **Production environment**: Use the client ID and secret issued by your model-specific system during [production access]({{ '/production-access.html' | relative_url }}). Credentials must be rotated (renewed) every 90 days. 

### 2. Request a bearer token

<div class="usa-alert usa-alert--warning usa-alert--slim">
    <div class="usa-alert__body">
        <p class="usa-alert__text">Bearer tokens <a href="{{ '/api-documentation/get-a-bearer-token.html#troubleshooting' | relative_url }}">expire</a> 20 minutes after they are generated.</p>
    </div>
</div>

Start a request for a bearer token in your terminal window or using a tool such as Postman. The following example uses the credentials of the extra-small model entity in BCDA's sandbox environment:

#### Sample Credentials

Example client ID (Extra-Small Model Entities):

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_small.client_id language="yaml" can_copy=true %}

Example client secret (Extra-Small Model Entities):

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_small.client_secret language="yaml" can_copy=true %}

#### Request header

The header has `Authorization: Basic` followed by the credentials. Credentials (`client_id:client_secret`) are joined by a colon, then encoded in Base64 format.

{% capture Snippet3 %}{% raw %}
Authorization: Basic {base64_encoded_credentials}
Accept: application/json
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet3 language="yaml" %}

#### Example curl command to request a bearer token

In this example, the authorization in the request header is replaced with `--user {client_id}:{client_secret}`. 

This command uses curl's built-in ability to Base-64 encode your credential to request and receive your token in a single step.

{% capture Snippet4 %}
curl -d "" -X POST "https://sandbox.bcda.cms.gov/auth/token" \
	--user {{site.data.credentials.sandbox.extra_small.client_id}}:{{site.data.credentials.sandbox.extra_small.client_secret}} \
	-H "Accept: application/json"
{% endcapture %}
{% include copy_snippet.html code=Snippet4 language="shell" can_copy=true %}

<div class="usa-alert usa-alert--info usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold">Remember to use the correct URL for your environment</p>
        <p class="usa-alert__text">
            Use <code>sandbox.bcda.cms.gov</code> to access the sandbox or <code>api.bcda.cms.gov</code> to access the production environment.
        </p>
    </div>
</div>

#### Response example: successful request

If your request succeeds, you'll receive a 200 response with your bearer token in the response body. It'll be the full text string that follows "access_token." The token string below has been abbreviated for readability.

“expires_in” counts down the seconds remaining before the token expires, which is 20 minutes after it is generated. “token_type: bearer” is a fixed value.

{% capture Snippet5 %}{% raw %}
{
  "access_token": "eyJhbGciOiJSUzUxMiIsInR...",
  "expires_in": "1200",
  "token_type": "bearer"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=Snippet5 language="json" %}

### 3. Set your bearer token in your request headers

Include your bearer token in the authorization header when requesting data in the sandbox and production environments. “Bearer” must be included in the header with a capital B and followed by a space.

{% include copy_snippet.html code="Authorization: Bearer {bearer_token}" language="yaml" %}

Now you can begin [accessing claims data]({{ '/api-documentation/access-claims-data.html' | relative_url }}). The production and sandbox environments support the same workflow, endpoints, and resource types.  

## Sandbox credentials

Sandbox credentials allow anyone to access synthetic test claims data. These credentials will not work in the production environment. 

Sample data sets vary in size and data complexity, ranging from 50 to 30,000 synthetic enrollees, to best match the needs of your model entity.  

### Adjudicated claims data sets – 2 simple sizes
Use the data sets to test retrieving and downloading data files into your internal ingestion processes. However, the test data may not reflect an accurate distribution of disease and demographic information.

#### Extra-small model entity (50 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_small.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_small.client_secret language="yaml" can_copy=true %}

#### Extra-large model entity (30,000 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_large.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.sandbox.extra_large.client_secret language="yaml" can_copy=true %}

### Adjudicated claims data sets – 2 advanced sizes

Advanced data sets offer a more accurate representation with the bulk FHIR format and a realistic distribution of disease and demographic information. 

The small data set helps you understand the format of BCDA data. The large data set is better for in-depth exploration or early load testing of your systems.

#### Extra-small model entity (100 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.adv.small.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.adv.small.client_secret language="yaml" can_copy=true %}

#### Large advanced model entity (10,000 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.adv.large.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.adv.large.client_secret language="yaml" can_copy=true %}

### Partially adjudicated claims data sets 

Anyone can access [partially adjudicated claims data]({{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}) in the sandbox. Only REACH ACOs can access enrollees' partially adjudicated claims data in production. 

#### Extra-small REACH ACO (110 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.enhancement.small.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.enhancement.small.client_secret language="yaml" can_copy=true %}

#### Large REACH ACO (11,000 synthetic enrollees)

Client ID:

{% include copy_snippet.html code=site.data.credentials.enhancement.large.client_id language="yaml" can_copy=true %}

Client secret:

{% include copy_snippet.html code=site.data.credentials.enhancement.large.client_secret language="yaml" can_copy=true %}

## Troubleshooting

### Ensure that your bearer token is not expired.

- Bearer tokens expire after 20 minutes.
- Jobs will not be interrupted when the bearer token expires. In progress and queued jobs will continue to run.
- You do *not* need to start a new job if your bearer token expires and your job was completed in the last 24 hours. You can download these files using a new bearer token. After 24 hours, the files will expire and you will need to restart the job. 

### Ensure that your production credentials are not expired.

Credentials must be rotated (renewed) every 90 days. <a href="{{ '/production-access.html' | relative_url }}">Learn more about credentials and production access.</a>

### Remember to use the correct URL for your environment. 

Use <code>sandbox.bcda.cms.gov</code> to access the sandbox or <code>api.bcda.cms.gov</code> to access the production environment.
