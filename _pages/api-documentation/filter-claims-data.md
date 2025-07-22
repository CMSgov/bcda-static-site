---
layout: api-docs
page_title: "How to Filter Claims Data "
seo_title: ""
description: "Use parameters to filter Medicare claims data returned."
in-page-nav: true
in-page-nav-levels: "h2"
feedback_id: "40a078ea"
---

# {{ page.page_title }}

Beneficiary Claims Data API (BCDA) uses 2 parameters to filter or specify the resources returned: 

- **_type**: limits your request to 1 or more specific resource types
- **_since**: applies a date boundary to your request

Use parameters in the sandbox or production environment to speed up download times and reduce file size. 

## The _type parameter 

The _type parameter lets you specify which resource types you'd like returned. Otherwise, making a `GET` request to start a job with the /Group or /Patient endpoint will return all resource types.

You'll need to use commas when specifying multiple resource types. The examples below are curl requests to /Group using _type. 

<h3 class="font-ui-sm">Example request for 1 resource type</h3>

{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<h3 class="font-ui-sm">Example request for 2 resource types</h3>

{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<h3 class="font-ui-sm">Example request for 2 resource types (REACH ACOs only)</h3>

{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Claim,ClaimResponse 
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<h3 class="font-ui-sm">Example curl command using _type</h3>

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

## The _since parameter

The _since parameter lets you filter for claims data last updated after a specified date. Dates must be in the [FHIR standard instant format](https://www.hl7.org/fhir/datatypes.html#instant)`(YYYY-MM-DDThh:mm:sss+zz:zz`. 

- Sample date: February 20, 2020 12:00 PM EST
- Formatted sample: 2020-02-20T12:00:00.000-05:00

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
                <p class="usa-alert__text text-bold">Requesting data from before 02/12/2020</p>
        <p class="usa-alert__text">Due to data source limitations, claims before 02/12/2020 are marked with the arbitrary lastUpdated date of 01/01/2020. </p>
        <p>If you specify a date between 01/01/2020 and 02/11/2020 for _since, you'll receive all historical data for your enrollees. Data requests from February 12, 2020 onwards are marked with accurate dates.</p>
    </div>
</div>

We recommend new model entities run an unfiltered request for all historical data before using _since subsequently for incremental exports of new data. You can use the transactionTime from your most recent job as the specified date.

The _since parameter can be used with /Group or /Patient, but each endpoint will return data for newly attributed enrollees differently.

### Using _since with /Patient 

Using _since with /Patient will return resources updated after the date provided for existing and newly attributed enrollees. 

Newly attributed enrollees are those who've been assigned to your model entity since your last attribution date. If you don't apply _since, BCDA will return data as early as 2014. 

#### Example request using _since with /Patient

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Patient/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Example curl command using _since with /Patient

This command combines the `GET` request and request header. The dollar sign `$` before `export` in the URL indicates the endpoint is an action, not a resource.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Patient/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

### Using _since with /Group 

Using _since with /Group will return resources updated after the date provided for existing enrollees and all resources for newly attributed enrollees. 

This lets you retrieve all new claims data with a single request. If you don't apply _since, BCDA will return data as early as 2014. 

#### Example request using _since with /Group

The request below will return: 

- Claims data last updated since February 13, 2020 for existing enrollees 
- Claims data as far back as 2014 for all new enrollees attributed to your organization in the last month
<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Example curl command using _since with /Group

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

## The \`runout` identifier

The \`runout` identifier lets you request runouts data for enrollees attributed to your model entity the previous year, but not the current year. Claims data returned will have a service date no later than December 31 of the previous year.

The examples below are `GET` requests made to the /Group endpoint. 

<h3 class="font-ui-sm">Example request for 1 resource type using `runout`</h3>

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/runout/\$export?_type=Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

<h3 class="font-ui-sm">Example request for 2 resource types using `runout`</h3>

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/runout/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

<h3 class="font-ui-sm">Request for all resources using `runout`</h3>

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/runout/$export
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/runout/\$export" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}
