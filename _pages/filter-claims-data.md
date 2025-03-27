---
layout: api-docs
page_title: "How to Filter Claims Data "
seo_title: ""
description: ""
permalink: /filter-claims-data
in-page-nav: true
in-page-nav-levels: "h2"
---

# {{ page.page_title }}

The BCDA API uses two parameters to filter or specify the resources returned: 

- _type: limits your requests to 1 or more specific resource types
- _since: applies a date boundary to your requests

Parameters filter or specify the resources returned. You can use parameters in the sandbox or production environment to increase download times and reduce file size. 

## The _type parameter 

The _type query parameter lets you specify which resource types you’d like returned. Otherwise, making a GET request to start a job with the /Group or /Patient endpoint will return all resource types.

You’ll need to use commas when specifying multiple resource types. The examples below are curl requests using the /Group endpoint and _type parameter. 

### Request 2 resource types (e.g., EOB, Patient)

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### [REACH ACOs only] Request 2 partially adjudicated claims resource types (e.g., Claim, ClaimResponse)

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Claim,ClaimResponse 
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request 1 resource type (e.g., Patient)

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

## The _since parameter

The _since parameter lets users filter for claims data last updated after a specified date. It can be used with /Group or /Patient, but each endpoint will return data for newly attributed enrollees differently. When using _since, format dates and times by the FHIR standard instant format (YYYY-MM-DDThh:mm:sss+zz:zz). Explore FHIR data types to learn more. 

- Sample date: February 20, 2020 12:00 PM EST
- Instant format: YYYY-MM-DDThh:mm:sss+zz:zz
- Formatted sample: 2020-02-20T12:00:00.000-05:00

Before using _since for the first time, we recommend running an unfiltered request (without parameters) for all resources using /Group or /Patient. You only need to do this once to retrieve all historical data for your attributed enrollees. On subsequent calls, you can run incremental exports for new data with _since, using the transactionTime from your most recent job request as the specified date.

<div class="usa-alert usa-alert--warning">
    <div class="usa-alert__body">
        <h4 class="usa-alert__heading">Requesting data from before February 12, 2020</h4>
        <p class="usa-alert__text">Due to limitations in BCDA’s data source, claims data before February 12, 2020 is marked with the arbitrary lastUpdated date of January 1, 2020. If you enter dates between January 1, 2020 and February 11, 2020 for the _since parameter, you’ll receive all historical data for your enrollees. Data requests from February 12, 2020 onwards are marked with accurate dates.</p>
    </div>
</div>

### Example request using _since with /Patient 

Using _since with /Patient will return resources updated after the date provided for existing and newly attributed enrollees. Newly attributed enrollees are those who’ve been assigned to your model entity since your last attribution date. If you don’t apply _since, BCDA will return data as early as 2014. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Patient/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Example request using _since with /Group 

Using the _since parameter with /Group will return **resources updated after the date provided** for existing enrollees and **all resources** for newly attributed enrollees. This lets you retrieve all new claims data with a single request.

Given the differences between /Patient and /Group when using _since, this request will return: 

- Claims data last updated since February 13, 2020 for existing enrollees 
- Claims data as far back as 2014 for all new enrollees attributed to your organization in the last month

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request header

Your header must contain your bearer token. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {access_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### curl command using _since with /Patient 

This command combines your GET request with the request header. The dollar sign ($) before "export" in the URL indicates the endpoint is an action rather than a resource.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://api.bcda.cms.gov/api/v2/Patient/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### curl command using _since with /Group 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://api.bcda.cms.gov/api/v2/Group/all/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

## Accessing runouts data from the prior year with `runout` 

The `runout` identifier lets you request runouts data for enrollees who were attributed to your model entity the previous year, but not the current year. The claims data returned will have a service date no later than December 31 of the previous year.

The examples below are GET requests made to the /Group endpoint. 

### Request for all resources using 'runout' 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request for 2 resource types (EOB, Patient) using 'runout'  and _type

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request for 1 resource type (Patient) using 'runout'  and _type

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request header

Your header must contain your bearer token. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {access_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### curl commands to start a job

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://api.bcda.cms.gov/api/v2/Group/runout/\$export" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://api.bcda.cms.gov/api/v2/Group/runout/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://api.bcda.cms.gov/api/v2/Group/runout/\$export?_type=Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}
