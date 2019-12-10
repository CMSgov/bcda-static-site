---
layout: home
title:  "Advanced Sandbox User Guide"
date:   2017-10-30 09:21:12 -0500
description: A technical guide to getting set up in BCDA and retrieving data from the API.
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
nav_link: sandbox
permalink: /sandbox/technical-user-guide/
id: sandbox-technical-user-guide
sections:
  - User Guide
  - Authentication and Authorization
  - Environment
  - Examples
  - Beneficiary Explanation of Benefit Data
  - Beneficiary Patient Data
  - Beneficiary Coverage Data
---

## User Guide

The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) to retrieve claims data for their Medicare beneficiaries. This includes claims data for instances in which beneficiaries receive care outside of the ACO, allowing a full picture of patient care.

This API follows the workflow outlined by the [FHIR Bulk Data Export Proposal](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}, using the [HL7 FHIR Standard](https://www.hl7.org/fhir/){:target="_blank"}. Claims data is provided as FHIR resources in [NDJSON](http://ndjson.org/){:target="_blank"} format.

This guide serves as a starting point for users to begin working with the API. [Comprehensive Swagger documentation about all BCDA endpoints is also available](https://sandbox.bcda.cms.gov/api/v1/swagger){:target="_blank"}.

**Note:** if this documentation is a little too in-depth, you may want to start with our [guide to getting started](/sandbox/user-guide/) for an overview of APIs and a gentler walk-through.

## Authentication and Authorization

The Beneficiary Claims Data API is currently accessible as an open sandbox environment, which returns sample NDJSON files with synthetic beneficiary data. You can use the generic credentials below to view our implementation of the API and learn the shape of the data before working with production files that include PII and PHI. There is no beneficiary PII or PHI in the files you can access via the sandbox.

To get a token that can be used with protected endpoints, POST the following credentials using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication){:target="_blank"} to `https://sandbox.bcda.cms.gov/auth/token`:

Client ID:
{%- capture client_id -%}
3841c594-a8c0-41e5-98cc-38bb45360d3c
{%- endcapture -%}

{% include copy_snippet.md code=client_id %}

Client Secret:
{%- capture client_secret -%}
f9780d323588f1cdfc3e63e95a8cbdcdd47602ff48a537b51dc5d7834bf466416a716bd4508e904a
{%- endcapture -%}

{% include copy_snippet.md code=client_secret %}

Encoded Basic authentication:
{%- capture auth_header -%}
Basic Mzg0MWM1OTQtYThjMC00MWU1LTk4Y2MtMzhiYjQ1MzYwZDNjOmY5NzgwZDMyMzU4OGYxY2RmYzNlNjNlOTVhOGNiZGNkZDQ3NjAyZmY0OGE1MzdiNTFkYzVkNzgzNGJmNDY2NDE2YTcxNmJkNDUwOGU5MDRh
{%- endcapture -%}

{% include copy_snippet.md code=auth_header %}

**Request**

`POST /auth/token`

**Headers**

* `Accept: application/json`
* `Authorization: <Encoded Basic authentication>`

**cURL command**

```
curl -X POST "https://sandbox.bcda.cms.gov/auth/token" -H "accept: application/json" -H "authorization: Basic Mzg0MWM1OTQtYThjMC00MWU1LTk4Y2MtMzhiYjQ1MzYwZDNjOm\
Y5NzgwZDMyMzU4OGYxY2RmYzNlNjNlOTVhOGNiZGNkZDQ3NjAy\
ZmY0OGE1MzdiNTFkYzVkNzgzNGJmNDY2NDE2YTcxNmJkNDUwOGU5MDRh"
```
**Response**

You will receive a `200 OK` response and an access token if your credentials were accepted.

## Environment

The examples below include [cURL](https://curl.haxx.se/){:target="_blank"} commands, but may be followed using any tool that can make HTTP GET requests with headers, such as [Postman](https://www.getpostman.com/){:target="_blank"}.

## Examples

Examples are shown as requests to the BCDA sandbox environment.

### BCDA Metadata

Metadata about the Beneficiary Claims Data API is available as a FHIR [CapabilityStatement](https://www.hl7.org/fhir/capabilitystatement.html){:target="_blank"} resource. A token is not required to access this information.

#### 1. Request the metadata

**Request**

`GET /api/v1/metadata`

**cURL command**

`curl https://sandbox.bcda.cms.gov/api/v1/metadata`


**Response**
```
{
  "resourceType": "CapabilityStatement",
  "status": "active",
  "date": "2019-12-09",
  "publisher": "Centers for Medicare & Medicaid Services",
  "kind": "capability",
  "instantiates": [
    "https://fhir.backend.bluebutton.hhsdevcloud.us/baseDstu3/metadata/"
  ],
  "software": {
    "name": "Beneficiary Claims Data API",
    "version": "latest",
    "releaseDate": "2019-12-09"
  },
  "implementation": {
    "url": "https://sandbox.bcda.cms.gov"
  },
  "fhirVersion": "3.0.1",
  "acceptUnknown": "extensions",
  "format": [
    "application/json",
    "application/fhir+json"
  ],
  "rest": [
    {
      "mode": "server",
      "security": {
        "cors": true,
        "service": [
          {
            "coding": [
              {
                "system": "http://hl7.org/fhir/ValueSet/restful-security-service",
                "code": "OAuth",
                "display": "OAuth"
              }
            ],
            "text": "OAuth"
          },
          {
            "coding": [
              {
                "system": "http://hl7.org/fhir/ValueSet/restful-security-service",
                "code": "SMART-on-FHIR",
                "display": "SMART-on-FHIR"
              }
            ],
            "text": "SMART-on-FHIR"
          }
        ]
      },
      "interaction": [
        {
          "code": "batch"
        },
        {
          "code": "search-system"
        }
      ],
      "operation": [
        {
          "name": "export",
          "definition": {
            "reference": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export"
          }
        },
        {
          "name": "jobs",
          "definition": {
            "reference": "https://sandbox.bcda.cms.gov/api/v1/jobs/[jobId]"
          }
        },
        {
          "name": "metadata",
          "definition": {
            "reference": "https://sandbox.bcda.cms.gov/api/v1/metadata"
          }
        },
        {
          "name": "version",
          "definition": {
            "reference": "https://sandbox.bcda.cms.gov/_version"
          }
        },
        {
          "name": "data",
          "definition": {
            "reference": "https://sandbox.bcda.cms.gov/data/[jobID]/[random_UUID].ndjson"
          }
        }
      ]
    }
  ]
}
```

### Beneficiary Data from the Patient endpoint

BCDA provides data via the `Patient` endpoint related to three Resource Types:
* [**Explanation of Benefit**](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"}: this Resource Type provides the same information you’ve previously received in CCLF files 1-7. This file contains the lines within an episode of care, including where and when the service was performed, the diagnosis codes, the provider who performed the service, and the cost of care.
* [**Patient**](https://www.hl7.org/fhir/patient.html){:target="_blank"}: the information in this Resource Type can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.
* [**Coverage**](https://www.hl7.org/fhir/coverage.html){:target="_blank"}: the information in this Resource Type indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

You can make a request to the `Patient` endpoint for all three Resource Types at once, one at a time, or a combination of any two together. This section describes a request for all three Resource Types; information about requesting one at a time follows below.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Patient/$export`

To start a data export job for all three Resource Types, a GET request is made to the Patient endpoint. An access token as well as *Accept* and *Prefer* headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -X GET "https://sandbox.bcda.cms.gov/api/v1/Patient/$export" -H "accept: application/fhir+json" -H "Prefer: respond-async" -H "Authorization: Bearer {token}"
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 42 in the URL represents the ID of the export job.

**Headers**

* Content-Location: https://sandbox.bcda.cms.gov/api/v1/jobs/42

#### 3. Check the status of the export job

**Request**

`GET https://sandbox.bcda.cms.gov/api/v1/jobs/42`

Using the *Content-Location* header value from the Patient data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -X GET "https://sandbox.bcda.cms.gov/api/v1/jobs/42" \
-H "accept: application/fhir+json" \
-H "Authorization: Bearer {token}"
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.
```
{
  "transactionTime": "2019-12-09T20:44:01.705398Z",
  "request": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export",
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
```
  
Claims data can be found at the URLs within the output field. The number 42 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as separate NDJSON files of [ExplanationOfBenefit](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"}, [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"}, and [Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} resources.

**Request**

`GET https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as FHIR resources in NDJSON format.

Examples of data from each Resource Type are available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).


### Requesting Beneficiary Explanation of Benefit Data only

The [**Explanation of Benefit** file](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} provides the same information you’ve previously received in CCLF files 1-7. This file contains the lines within an episode of care, including where and when the service was performed, the diagnosis codes, the provider who performed the service, and the cost of care.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Patient/$export?_type=ExplanationOfBenefit`

To start an explanation of benefit data export job, a GET request is made to the ExplanationOfBenefit  endpoint. An access token as well as *Accept* and *Prefer* headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -X GET "https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=ExplanationOfBenefit \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 43 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://sandbox.bcda.cms.gov/api/v1/jobs/43`

#### 3. Check the status of the export job

**Request**

`GET https://sandbox.bcda.cms.gov/api/v1/jobs/43`

Using the *Content-Location* header value from the ExplanationOfBenefit data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/jobs/43 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.

```
{
  "transactionTime": "2019-12-09T21:20:57.254518Z",
  "request": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=ExplanationOfBenefit",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "ExplanationOfBenefit",
      "url": "https://sandbox.bcda.cms.gov/data/43/472483a6-3aad-422c-beed-694344570548.ndjson"
    }
  ],
  "error": [],
  "JobID": 43
}
```

Claims data can be found at the URLs within the output field. The number 43 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported explanation of benefit data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as NDJSON files of [ExplanationOfBenefit](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} resources.

**Request**

`GET https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR ExplanationOfBenefit resources](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

## Requesting Beneficiary Patient Data only

The [**Patient** file](https://www.hl7.org/fhir/patient.html){:target="_blank"} can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.

**Note the difference between the Patient endpoint and Patient resource type:** the Patient endpoint can return data from any or all of the three resource types. The Patient resource type within the Patient endpoint only returns the information described above.

The process of retrieving Patient data from the Patient endpoint is very similar to exporting Explanation of Benefit data.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

##### Request

`GET /api/v1/Patient/$export?_type=Patient`

To start a Patient data export job, a GET request is made to the Patient export endpoint for the Patient resource type. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -v https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=Patient" \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 44 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://sandbox.bcda.cms.gov/api/v1/jobs/44`

#### 3. Check the status of the export job

**Request**

`GET https://sandbox.bcda.cms.gov/api/v1/jobs/44`

Using the *Content-Location* header value from the Patient resource type data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/jobs/44 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.
```
{
  "transactionTime": "2019-12-09T21:42:54.055223Z",
  "request": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=Patient",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "Patient",
      "url": "https://sandbox.bcda.cms.gov/data/44/4e2cd98c-4746-4138-872b-24778c000b02.ndjson"
    }
  ],
  "error": [],
  "JobID": 44
}
```

Patient demographic data can be found at the URLs within the output field. The number 44 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported patient data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as an NDJSON file of [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"} resources.

**Request**

`GET https://sandbox.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR Patient resources](https://www.hl7.org/fhir/patient.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

## Requesting Beneficiary Coverage Data Only

[**Coverage data**](https://www.hl7.org/fhir/coverage.html){:target="_blank"} indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

The process of retrieving coverage data is very similar to all of the other exporting operations supported by this API.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

##### Request

`GET /api/v1/Patient/$export?_type=Coverage`

To start a coverage data export job, a GET request is made to the Patient endpoint for the Coverage resource type. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -v https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=Coverage \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 45 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://sandbox.bcda.cms.gov/api/v1/jobs/45`

#### 3. Check the status of the export job

**Request**

`GET https://sandbox.bcda.cms.gov/api/v1/jobs/45`

Using the *Content-Location* header value from the Coverage data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/jobs/45 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.
```
{
  "transactionTime": "2019-12-09T21:51:58.182108Z",
  "request": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export?_type=Coverage",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "Coverage",
      "url": "https://sandbox.bcda.cms.gov/data/45/99dbc86f-74e5-4553-88a9-af3e718cb72b.ndjson"
    }
  ],
  "error": [],
  "JobID": 45
}
```

Coverage data can be found at the URLs within the output field. The number 45 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported coverage data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as an NDJSON file of [Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} resources.

**Request**

`GET https://sandbox.bcda.cms.gov/data/45/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/data/45/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR Coverage resources](https://www.hl7.org/fhir/coverage.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).
