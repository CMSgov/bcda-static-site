---
layout: api-docs
page_title: "How to Access Claims Data"
seo_title: ""
description: ""
permalink: /access-claims-data
in-page-nav: true
---

# {{ page.page_title }}

Learn how to access claims data for both the sandbox and production environments or request Beneficiary Claims Data API (BCDA) endpoints. 

The sandbox and production environments follow the same instructions for access. Both environments share the same workflow, endpoints, parameters, and resource types. 

<table class="usa-table usa-table--borderless margin-bottom-6">
  <caption class="usa-sr-only">Sandbox and Production environments comparison</caption>
  <thead>
    <tr>
      <th scope="col">Sandbox</th>
      <th scope="col">Production</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Available to everyone</td>
      <td>Must have completed the steps for <a href="{{ '/production-access' | relative_url }}">production access</a></td>
    </tr>
    <tr>
      <td>Contains synthetic claims data</td>
      <td>Contains real Medicare enrollee data</td>
    </tr>
    <tr>
      <td>sandbox.bcda.cms.gov</td>
      <td>api.bcda.cms.gov</td>
    </tr>
  </tbody>
</table>


<div class="usa-alert usa-alert--info">
    <div class="usa-alert__body">
        <h4 class="usa-alert__heading">    BCDA recommends using V2 of the API</h4>
        <p class="usa-alert__text">
            This is the latest API version which follows the <a href="https://hl7.org/fhir/R4/" target="_blank" rel="noopener">FHIR R4 specification</a>. Accountable Care Organizations participating in the Realizing Equity, Access, and Community Health (ACO REACH) Model must use V2 to access <a href="{{ '/placeholder' | relative_url }}">partially adjudicated claims data</a>.
        </p>
        <p>    
            <a href="https://github.com/CMSgov/ab2d-pdp-documentation/raw/main/AB2D%20STU3-R4%20Migration%20Guide%20Final.xlsx" target="_blank" rel="noopener">Learn more about migrating from V1 to V2</a>.
        </p>
    </div>
</div>

## Instructions

### 1. Get a bearer token 

You will need a [bearer token]({{ '/placeholder' | relative_url }}) to call the API. The process requires credentials, which are formatted as a client ID and client secret. If you’re trying to access test claims data, you can use BCDA’s sandbox credentials. If you’re trying to access production claims data, use the credentials issued from your model-specific system during [onboarding]({{ '/placeholder' | relative_url }}). 

### 2. Start a job 

Make a GET request to either the /Group or /Patient endpoint to start a data export job. The examples below are curl requests to /Group in V2 of the sandbox environment. You can follow along in your terminal or using a tool such as Postman.

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold">Remember to use the correct URL for your environment</p>
        <p class="usa-alert__text">Use sandbox.bcda.cms.gov to access the sandbox or api.bcda.cms.gov to access the production environment.</p>
    </div>
</div>

#### Request all resource types 

By default, the GET request returns all available [resource types]({{ '/bcda-data#resource-types' | relative_url }}). For REACH ACOs who want to access [partially adjudicated claims data]({{ '/placeholder' | relative_url }}), this automatically includes the additional resource types Claim and ClaimResponse. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

You can also use the _type parameter to specify which resource types you’d like returned. [Explore all the parameters and how to use them.]({{ '/placeholder' | relative_url }})

#### Request header

The header must contain your bearer token. You may receive a 401 response if your credentials are invalid or expired. 

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text">Tokens expire 20 minutes after they are generated. </p>
    </div>
</div>

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Example curl commands to start a job 

<ul>
    <li>This command combines your GET request for resources with the request header.</li>
    <li>The dollar sign ($) before "export" in the URL indicates the endpoint is an <a href="https://hl7.org/fhir/R4/operations.html" target="blank" rel="noopener">operation</a>, rather than a CRUD interaction. </li>
    <li>PowerShell users will need to replace backslash characters (\) with backticks (`) to properly escape the $export operation.</li>
</ul>

<!-- snippet x3 -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response example: successful request

A 202 response with a Content-Location header indicates a successful job request.

<!-- Snippet -->
{% capture curlSnippet %}{% raw %}
202 Accepted
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response header example

You’ll need the URL and job ID in the Content-Location header to check on your job status in step 3. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Content-Location: https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response example: too many requests

A 429 response indicates “Too Many Requests.” This can occur due to 2 reasons:

1. Making too many HTTP requests within a period of time
2. Trying to recreate jobs already marked as "In-Progress.” For reference, you can view both existing and past jobs using the [/Jobs endpoint]({{ '/access-claims-data#request-jobs-history' | relative_url }}). 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
429 Too Many Requests
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

Wait until the period of time specified in the “Retry-After” header passes before making any more requests. This makes sure your client can adapt without manual intervention, even if the rate-limiting parameters change.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Retry-After: <delay-seconds>
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### 3. Check job status

Make a GET request to check the status of the job. You’ll need the URL found in the Content-Location header from step 2. You may need another bearer token if it’s been more than 20 minutes since it was last generated.

#### Request to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/fhir+json
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### curl command to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}" \
    -H "accept: application/fhir+json" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example: incomplete job

A 202 response indicates your job is still processing. The status will change to 200 OK when the export is complete and the data is ready to be downloaded.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
202 Accepted
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response header example: incomplete job

The X-Progress will have a percentage indicating your estimated progress. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
X-Progress: In Progress, 80%
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response example: completed job

You’ll receive a 200 OK response with the output URL(s) needed to download the data. In the example URLs below, 42 indicates the job ID. 

There is a separate URL for each resource type requested. The example below requested all resource types for adjudicated claims data.

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold">Files expire after 24 hours</p>
        <p class="usa-alert__text">You will have 24 hours after a job completes to download the data. Otherwise, the file(s) will expire and you will need to restart the job.</p>
    </div>
</div>

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
  "transactionTime": "2019-12-09T20:44:01.705398Z",
  "request": "https://sandbox.bcda.cms.gov/api/v2/Group/all/$export",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "ExplanationOfBenefit",
      "url": "https://sandbox.bcda.cms.gov/data/42/afd22dfa-c239-4063-8882-eb2712f9f638.ndjson"
    },
    {
      "type": "Coverage",
      "url": "https://sandbox.bcda.cms.gov/data/42/f76a0b76-48ed-4033-aad9-d3eec37e7e83.ndjson"
    },
    {
      "type": "Patient",
      "url": "https://sandbox.bcda.cms.gov/data/42/f92dcf16-63a2-448e-a12a-3bf677f966ed.ndjson"
    }
  ],
  "error": [],
  "JobID": 42
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### 4. Download the data

Make a GET request to download your data using the URL(s) from the completed response in step 3. If you're downloading from more than 1 URL, make multiple download requests concurrently to save time. Large files may take significantly longer to download. 

#### Request to download the data

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET https://sandbox.bcda.cms.gov/data/{job_id}/{file_name}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request header

Requesting compressed data can help increase your download speed. You can request compressed data files by specifying the optional `Accept-Encoding: gzip` header in your download requests. Afterward, decompress (unzip) the files into NDJSON format. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept-Encoding: gzip
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

curl command to download the data

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/data/{job_id}/{file_name}" \
    -H "Accept-Encoding: gzip" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

If some of the data can’t be exported due to errors, details can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR OperationOutcome resources.

#### Response example

You’ll receive the requested data as FHIR resources in NDJSON format. Each resource will appear as a separate, labeled file. 

1. [Explanation of Benefit](https://bcda.cms.gov/assets/data/ExplanationOfBenefit.ndjson)
2. [Patient](https://bcda.cms.gov/assets/data/Patient.ndjson)
3. [Coverage](https://bcda.cms.gov/assets/data/Coverage.ndjson)

## Other BCDA endpoints 

### Cancel a job

Send a request to cancel any active job, for example, if it has been taking too long to complete. If the request is successful, the active job will be terminated and a 202 response will be returned.

#### Request to cancel a job
 
 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
DELETE /api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request header

 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### curl command to cancel a job

 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X DELETE "https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}" \
    -H "accept: application/fhir+json" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

### Request job history

Send a request to retrieve details on your organization’s historical requests, including the job’s start datetime, end datetime, unique identifier, original valueString request, and status. 

#### Request to retrieve data on job history

This is an unfiltered request for all past jobs. If your organization has no jobs to return, you’ll receive a 404 ERROR response.

 <!-- snippet -->
 {% capture curlSnippet %}{% raw %}
GET /api/v2/jobs
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request that filters jobs by end state

You can supply the _status parameter to filter for jobs with a specific end state. BCDA jobs have 9 possible end states: Completed, Archived, Expired, Failed, FailedExpired, In Progress, Pending, Cancelled, and CancelledExpired. 

However, the _status parameter only supports 4 possible values. These are how the job end states map to the supported values you’ll receive in your response:

- Archived, Expired, Completed → Completed
- FailedExpired, Failed → Failed
- Pending, In Progress → In Progress
- CancelledExpired, Cancelled → Cancelled

The example below is a filtered request for all past archived jobs. If any are found, the response will list the status as “Completed." Even so, the filter will only return archived jobs; it will exclude expired and completed jobs. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Jobs?_status=Archived
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {access_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### curl command to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/jobs" \
    -H "accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example: completed job

The response will contain a bundle of resources for each historical job requested by your organization. Each resource section in the response represents a single past job request.  

The example below shows 1 historical job with a “Completed” status. Since this is in response to an unfiltered request, the job could either be archived, expired, or completed.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
    "entry":[
        {
            "resource":{
                "executionPeriod":{
                    "end":"2021-08-14T00:07:48+00:00",
                    "start":"2021-08-13T00:07:48+00:00"
                },
                "identifier":[
                    {
                        "system":"http://bcda.cms.gov/api/v2/jobs",
                        "use":"official",
                        "value":"1"
                    }
                ],
                "input":[
                    {
                        "type":{
                            "text":"BULK FHIR Export"
                        },
                        "valueString":"GET https://bcda.test.gov/this-is-a-test"
                    }
                ],
                "intent":"order",
                "resourceType":"Task",
                "status":"completed"
            }
        }
    ],
    "resourceType":"Bundle",
    "total":1,
    "type":"searchset"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Request attribution status

Send a request to check your attribution status. You’ll get a timestamp of the last time your attribution data was updated in the BCDA system. By comparing this timestamp to the date of your most recent job, you can determine if your organization has new claims data to download.

If BCDA has never ingested an attribution or runout file for your organization, you’ll receive a 404 NOT FOUND response.

#### Request to check when your attribution data was last updated

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/attribution_status
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {access_token}
Accept: application/json
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### curl command to retrieve the attribution status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/attribution_status" \
    -H "accept: application/json" \
    -H "Authorization: Bearer {access_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
    “Ingestion_dates”: [
        {
            “type”: “last_attribution_update”,
            “timestamp”: “2020-12-22 22:31:40.397916+00”
        },
        {
            “type”: “last_runout_update”,
            “timestamp”: “2020-12-22 22:31:40.397916+00”
        }
    ]
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

### Check API status

You can retrieve metadata to view what release or FHIR version of the API is currently active and check on the current status. A bearer token, and therefore a response header, is not required for this request.

#### Request to check API status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/metadata
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### curl command to check API status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl https://sandbox.bcda.cms.gov/api/v2/metadata
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example

The response will contain a FHIR Capability Statement resource in JSON format. The example below shows the API is active, using FHIR Release 4.0.1, and that the API release version is r231. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
  "date": "2024-09-09T13:35:05+00:00",
  "fhirVersion": "4.0.1",
  "format": [
    "application/json",
    "application/fhir+json"
  ],
  "implementation": {
    "description": "The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) participating in the Shared Savings Program to retrieve Medicare Part A, Part B, and Part D claims data for their prospectively assigned or assignable beneficiaries.",
    "url": "https://sandbox.bcda.cms.gov"
  },
  "instantiates": [
    "https://prod.bfd.cms.gov/v2/fhir/metadata",
    "http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data"
  ],
  "kind": "instance",
  "publisher": "Centers for Medicare & Medicaid Services",
  "resourceType": "CapabilityStatement",
  "rest": [
    {
      "interaction": [
        {
          "code": "batch"
        },
        {
          "code": "search-system"
        }
      ],
      "mode": "server",
      "resource": [
        {
          "operation": [
            {
              "definition": "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/patient-export",
              "name": "patient-export"
            }
          ],
          "type": "Patient"
        },
        {
          "operation": [
            {
              "definition": "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/group-export",
              "name": "group-export"
            }
          ],
          "type": "Group"
        }
      ],
      "security": {
        "cors": true,
        "extension": [
          {
            "extension": [
              {
                "url": "token",
                "valueUri": "https://sandbox.bcda.cms.gov/auth/token"
              }
            ],
            "url": "http://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris"
          }
        ],
        "service": [
          {
            "coding": [
              {
                "code": "OAuth",
                "display": "OAuth",
                "system": "http://terminology.hl7.org/CodeSystem/restful-security-service"
              }
            ],
            "text": "OAuth"
          }
        ]
      }
    }
  ],
  "software": {
    "name": "Beneficiary Claims Data API",
    "releaseDate": "2024-09-09T13:35:05+00:00",
    "version": "r231"
  },
  "status": "active"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}