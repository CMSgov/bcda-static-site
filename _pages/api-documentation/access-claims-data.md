---
layout: api-docs
page_title: "How to Access Claims Data"
seo_title: ""
description: "Learn how to access Medicare enrollees' Parts A, B, and D claims data in the BCDA production environment for performance tracking and risk analysis."
in-page-nav: true
---

# {{ page.page_title }}

Learn how to access claims data for both the sandbox and production environments and use Beneficiary Claims Data API (BCDA) endpoints. 

The sandbox and production environments follow similar instructions. They support the same workflow, endpoints, parameters, and resource types. 

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
      <td>Available to everyone via test credentials</td>
      <td>Must <a href="{{ '/production-access.html' | relative_url }}">complete the steps</a> for production credentials</td>
    </tr>
    <tr>
      <td>Contains test claims data</td>
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
        <p class="usa-alert__heading text-bold">BCDA recommends using V2 of the API</p>
        <p class="usa-alert__text">
            This is the latest version which follows the <a href="https://hl7.org/fhir/R4/" target="_blank" rel="noopener noreferrer">FHIR R4 specification</a>. REACH ACOs must use V2 for <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">partially adjudicated claims data</a>.
        </p>
    </div>
</div>

## Instructions

### 1. Get a bearer token 

You will need a [bearer token]({{ '/api-documentation/get-a-bearer-token.html' | relative_url }}) to call the API. The process requires credentials, which are formatted as a client ID and client secret. 

### 2. Start a job 

<div class="usa-alert usa-alert--warning usa-alert--no-icon">
    <div class="usa-alert__body">
        <p class="usa-alert__text text-bold">Remember to use the correct URL for your environment</p>
        <p class="usa-alert__text">Use sandbox.bcda.cms.gov to access the sandbox or api.bcda.cms.gov to access the production environment.</p>
    </div>
</div>

Make a `GET` request to the /Group or /Patient endpoint to start a data export job. The examples below are sandbox curl requests to /Group. Follow along in your terminal or using a tool like Postman.

#### Request all resource types 

By default, the GET request returns all available [resource types]({{ '/bcda-data.html#resource-types' | relative_url }}). 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/Group/all/$export
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

Use the [_type parameter]({{ '/api-documentation/filter-claims-data.html' | relative_url }}) to specify which resource types you'd like returned. 

#### Request header

The header must contain your bearer token. You may receive a 401 response if your credentials are invalid or expired. “Bearer” must be included in the header with a capital B and followed by a space.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

<div class="usa-alert usa-alert--warning usa-alert--slim">
    <div class="usa-alert__body">
        <p class="usa-alert__text">Bearer tokens <a href="{{ '/api-documentation/get-a-bearer-token.html#troubleshooting' | relative_url }}">expire</a> 20 minutes after they are generated.</p>
    </div>
</div>

#### Example curl commands to start a job 

<ul>
    <li>Combine your GET request for resources with the request header.</li>
    <li>The dollar sign ($) before "export" in the URL indicates the endpoint is an <a href="https://hl7.org/fhir/R4/operations.html" target="_blank" rel="noopener noreferrer">operation</a>, rather than a CRUD interaction. </li>
    <li>PowerShell users will need to replace backslash characters (\) with backticks (`) to properly escape the $export operation.</li>
</ul>

<!-- snippet x3 -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=ExplanationOfBenefit,Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/Group/all/\$export?_type=Patient" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example: successful request

A 202 response with a Content-Location header indicates a successful request.

<!-- Snippet -->
{% capture curlSnippet %}{% raw %}
202 Accepted
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response header example

You'll need the job ID in the Content-Location header to check your job status. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Content-Location: https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Response example: too many requests

A 429 response indicates “Too Many Requests.” This can occur due to 2 reasons:

1. Making too many HTTP requests within a period of time
2. Trying to recreate jobs already marked as "In-Progress.” For reference, you can view both existing and past jobs using the [/jobs endpoint]({{ '/api-documentation/access-claims-data.html' | relative_url }}#request-job-history). 

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

Make a `GET` request to check the status using the job ID from step 2. You may need another bearer token if it's been over 20 minutes since it was generated.

#### Request to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/fhir+json
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

#### curl command to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}" \
    -H "Accept: application/fhir+json" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example: incomplete job

A 202 response indicates your job is still processing. The status will change to 200 OK when the export is complete and the data is ready for download.

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

You'll receive a 200 OK response with the output URL(s) needed to download the data. In the example URLs below, 42 indicates the job ID. 

There is a separate URL for each resource type requested. The following example shows a request for all resource types for adjudicated claims data.

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
{% include copy_snippet.html code=curlSnippet language="json" %}

### 4. Download the data

Make a `GET` request to download your data using the URL(s) from step 3. 

If you're downloading from more than 1 URL, make multiple download requests concurrently to save time. Large files may take significantly longer to download. 

#### Request to download the data

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET https://sandbox.bcda.cms.gov/data/{job_id}/{file_name}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request header: compressed data files

Request compressed data files with the optional `Accept-Encoding: gzip` header in your requests for faster download times. Afterward, decompress (unzip) the files into NDJSON format. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept-Encoding: gzip
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

#### curl command to download the data

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/data/{job_id}/{file_name}" \
    -H "Accept-Encoding: gzip" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

If some of the data can't be exported due to errors, details can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR OperationOutcome resources.

#### Response example

By default, you'll receive the requested data as FHIR resources in NDJSON format. Each resource will appear as a separate, labeled file. 

<div class="usa-alert usa-alert--info usa-alert--slim">
    <div class="usa-alert__body">
        <p class="usa-alert__text">Test data from the sandbox contains only negative Patient IDs.</p>
    </div>
</div>

<ol>
  <li><a href="{{ '/assets/downloads/ExplanationOfBenefit.ndjson' | relative_url }}">ExplanationOfBenefit.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
  <li><a href="{{ '/assets/downloads/Patient.ndjson' | relative_url }}">Patient.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
  <li><a href="{{ '/assets/downloads/Coverage.ndjson' | relative_url }}">Coverage.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
</ol>

## Other BCDA endpoints 

### Cancel a job

Cancel any active job. If the request is successful, you'll receive a 202 response.

#### Request to cancel a job
 
 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
DELETE /api/v2/jobs/{job_id}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request header

 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

#### curl command to cancel a job

 <!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X DELETE "https://sandbox.bcda.cms.gov/api/v2/jobs/{job_id}" \
    -H "Accept: application/fhir+json" \
    -H "Authorization: Bearer {bearer_token}" \
    -i
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

### Request job history

Retrieve details on your organization's historical requests, including the start and end datetime, unique ID, original valueString request, and status. 

#### Request to retrieve all past jobs

If your organization has no jobs to return, you'll receive a 404 ERROR response.

 <!-- snippet -->
 {% capture curlSnippet %}{% raw %}
GET /api/v2/jobs
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request that filters jobs by end state

Supply the _status parameter to filter for jobs with a specific end state. BCDA jobs have 9 possible end states: Completed, Archived, Expired, Failed, FailedExpired, In Progress, Pending, Cancelled, and CancelledExpired. 

These are how the job end states map to the 4 supported values you can receive in the response body:

- `Archived`, `Expired`, `Completed` → `completed`
- `FailedExpired`, `Failed` → `failed`
- `Pending`, `In Progress` → `in-progress`
- `CancelledExpired`, `Cancelled` → `cancelled`

The example below is a filtered request for all past archived jobs. If any are found, the response will list the status as `completed`. Even so, the filter will only return archived jobs; it will exclude expired and completed jobs. 

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/jobs?_status=Archived
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/fhir+json
Prefer: respond-async
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

#### curl command to check the job status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/jobs" \
    -H "Accept: application/fhir+json" \
    -H "Prefer: respond-async" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example: completed job

The response will contain a bundle of resources for each historical job. Each resource section in the response represents a single past job request.  

This example shows 1 historical job with a “Completed” status. Since this was an unfiltered request, the job could either be archived, expired, or completed.

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
  "entry": [
    {
      "resource": {
        "executionPeriod": {
          "end": "2021-08-14T00:07:48+00:00",
          "start": "2021-08-13T00:07:48+00:00"
        },
        "identifier": [
          {
            "system": "https://bcda.cms.gov/api/v2/jobs",
            "use": "official",
            "value": "1"
          }
        ],
        "input": [
          {
            "type": {
              "text": "BULK FHIR Export"
            },
            "valueString": "GET https://bcda.test.gov/this-is-a-test"
          }
        ],
        "intent": "order",
        "resourceType": "Task",
        "status": "completed"
      }
    }
  ],
  "resourceType": "Bundle",
  "total": 1,
  "type": "searchset"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" %}

### Request attribution status

Check your attribution status for a timestamp of when your attribution data was last updated. By comparing the timestamp to the date of your most recent job, you can determine if your organization has new claims data to download.

#### Request to check attribution status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/attribution_status
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### Request header

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
Authorization: Bearer {bearer_token}
Accept: application/json
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="yaml" %}

#### curl command to check attribution status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl -X GET "https://sandbox.bcda.cms.gov/api/v2/attribution_status" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer {bearer_token}"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" can_copy=true %}

#### Response example
If BCDA has never ingested an attribution or runout file for your organization, you'll receive a 404 NOT FOUND response.
<!-- snippet -->
{% capture curlSnippet %}{% raw %}
{
  "ingestion_dates": [
    {
      "type": "last_attribution_update",
      "timestamp": "2020-12-22 22:31:40.397916+00"
    },
    {
      "type": "last_runout_update",
      "timestamp": "2020-12-22 22:31:40.397916+00"
    }
  ]
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" %}

### Check API status

Retrieve metadata to view the current status and release or FHIR version of the API. A bearer token, and therefore a response header, is not required.

#### Request to check API status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
GET /api/v2/metadata
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}

#### curl command to check API status

<!-- snippet -->
{% capture curlSnippet %}{% raw %}
curl "https://sandbox.bcda.cms.gov/api/v2/metadata"
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
    "https://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data"
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
              "definition": "https://hl7.org/fhir/uv/bulkdata/OperationDefinition/patient-export",
              "name": "patient-export"
            }
          ],
          "type": "Patient"
        },
        {
          "operation": [
            {
              "definition": "https://hl7.org/fhir/uv/bulkdata/OperationDefinition/group-export",
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
            "url": "https://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris"
          }
        ],
        "service": [
          {
            "coding": [
              {
                "code": "OAuth",
                "display": "OAuth",
                "system": "https://terminology.hl7.org/CodeSystem/restful-security-service"
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
{% include copy_snippet.html code=curlSnippet language="json" %}

{% include feedback-form.html url="f179685c" %}
