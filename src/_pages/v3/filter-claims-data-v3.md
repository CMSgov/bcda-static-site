---
layout: api-docs-v3
page_title: "How to Filter Claims Data"
seo_title: ""
description: "How to Filter Claims Data"
in-page-nav: true
in-page-nav-levels: "h2"
feedback_id: "72cee024"
---

# {{ page.page_title }}

<div
  class="usa-summary-box"
  role="region"
  aria-labelledby="summary-box-key-information"
>
  <div class="usa-summary-box__body">
    <p class="usa-summary-box__heading font-ui-md text-bold" id="summary-box-key-information">
      What's new in v3?
    </p>
    <div class="usa-summary-box__text">
        <ul>
            <li><a href="#the-typefilter-parameter">The _typeFilter parameter</a></li>
        </ul>
    </div>
  </div>
</div>

BCDA offers 3 query parameters to filter or specify the resources returned:
- **_since:** applies a date boundary to your request
- **_type:** limits your request to 1 or more specific resource types
- **_typeFilter:** limits your request to resources matching the provided criteria

Use parameters in the sandbox or production environment to speed up download times and reduce file size.

## The _since parameter

The _since parameter lets you filter for claims data last updated after a specified date. Dates must be in the [FHIR standard instant format](https://www.hl7.org/fhir/datatypes.html#instant): `(YYYY-MM-DDThh:mm:sss+zz:zz`. 

- Sample date: February 20, 2020 12:00 PM EST
- Formatted sample: `2020-02-20T12:00:00.000-05:00`

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

Newly attributed enrollees are those who’ve been assigned to your model entity since your last attribution date. If you don’t apply _since, BCDA will return data as early as 2014.

#### Example request using _since with /Patient

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v3/Patient/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Example curl command using _since with /Patient

This command combines the `GET` request and request header. The dollar sign `$` before `export` in the URL indicates the endpoint is an action, not a resource.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Patient/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
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

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/all/$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Example curl command using _since with /Group

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Group/all/\$export?_type=Patient&_since=2020-02-13T08:00:00.000-05:00" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

## The _type parameter 

The _type parameter lets you specify which resource types you'd like returned. Otherwise, making a `GET` request to start a job with the /Group or /Patient endpoint will return all resource types.

### Using _type

You'll need to use commas when specifying multiple resource types. The examples below are curl requests to /Group using _type. 

<h3 class="font-ui-sm">Example request for 1 resource type</h3>

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/all/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<h3 class="font-ui-sm">Example request for 2 resource types</h3>

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/all/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

<h3 class="font-ui-sm">Example curl command using _type</h3>

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Group/all/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

<div class="display-flex flex-align-center"> 
    <h2 class="display-inline">The _typeFilter parameter </h2>
    {%- include new-tag.html -%} 
</div>

<div class="usa-alert usa-alert--success usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold font-ui-lg">Only available in v3</p>
        <p class="usa-alert__text">The _typeFilter parameter is only available in v3. If you are using v2, use the _since and _type parameters to filter claims data.</p>
    </div>
</div>

The _typeFilter parameter lets you use resource metadata to create finer-grained filtering criteria. BCDA will only return claims data that meets the specified criteria provided as a URL Encoded FHIR REST API query.

### Using _typeFilter

Currently, _typeFilter only supports queries using the meta.tag element of ExplanationOfBenefit resources.

#### Example request using _typeFilter

The request below will return:
- All Patient and Coverage resources
- ExplanationOfBenefit resources of only partially adjudicated claims only

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/all/$export?_typeFilter=ExplanationOfBenefit?_tag=PartiallyAdjudicated
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Example curl command using _typeFilter


{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v32/Group/all/\$export?_typeFilter=ExplanationOfBenefit%3F_tag%3DPartiallyAdjudicated" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

### Filtering claims by adjudication status using _typeFilter

By default, any unfiltered request made to either BCDA v2 or v3 by a REACH ACO will include both partially adjudicated and fully adjudicated claims data.

In BCDA v3, the ExplanationOfBenefit Resource represents both partially adjudicated and fully adjudicated claims data. You can differentiate adjudication status by using the _tag property for the values "Adjudicated" or "PartiallyAdjudicated".

## The \`runout` identifier

The \`runout` identifier lets you request runouts data for enrollees attributed to your model entity the previous year, but not the current year. Claims data returned will have a service date no later than December 31 of the previous year.

### Using the `runout` identifier

The examples below are `GET` requests made to the /Group endpoint. 

#### Example request for 1 resource type using `runout`

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/runout/$export?_type=Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Group/runout/\$export?_type=Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Example request for 2 resource types using `runout` 

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/runout/$export?_type=ExplanationOfBenefit,Patient
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Group/runout/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request for all resources using `runout`

{% capture curlSnippet %}{% raw %}
GET /api/v3/Group/runout/$export
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v3/Group/runout/\$export" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}
