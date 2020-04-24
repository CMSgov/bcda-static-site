---
layout: home
title:  "Advanced Production User Guide"
description: "A technical guide to getting set up in BCDA and retrieving beneficiary data."
date:   2019-09-06 09:21:12 -0500
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
nav_link: production
permalink: /production/technical-user-guide/
id: prod-technical-user-guide
sections:
  - User Guide
  - Authentication and Authorization
  - Environment
  - Examples
---

## User Guide

The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) to retrieve claims data for their Medicare beneficiaries. This includes claims data for instances in which beneficiaries receive care outside of the ACO, allowing a full picture of patient care.

This API follows the workflow outlined by the [FHIR Bulk Data Export Proposal](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"} using the [HL7 FHIR Standard](https://www.hl7.org/fhir/){:target="_blank"}. Claims data is provided as FHIR resources in [NDJSON](http://ndjson.org){:target="_blank"} format.

This guide serves as a starting point for users to begin working with the API. [Comprehensive Swagger documentation about all BCDA endpoints is also available.](https://api.bcda.cms.gov/api/v1/swagger){:target="_blank"}

**Note:** if this documentation is a little too in-depth, you may want to start with our [guide to getting started in production](/production/user-guide/) for an overview of APIs and a gentler walk-through.

**Note:** If you have not yet received production credentials, you will not be able to access production endpoints and data. To put your ACO in the queue for access, please fill out the [BCDA Production Onboarding Request Form](https://airtable.com/shrMbfFSRZkTcSAof){:target="_blank"}. ACOs will be onboarded to production in the order in which requests are received. While you wait, you can [get familiar with the API in the sandbox environment](/sandbox/user-guide/), review the [data structure](/data-guide/) and join the [BCDA Google Group](https://groups.google.com/forum/#!forum/bc-api){:target="_blank"}, to have your questions answered.

## Authentication and Authorization

This invitation-only production release of the Beneficiary Claims Data API protects its endpoints with OAuth2 access tokens. **Please treat your credentials like data: store them safely and securely.**

Once you have your credentials, you will:

1) `POST` to `https://api.bcda.cms.gov/auth/token` using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication){:target="_blank"}

2) Use the returned access token as the Bearer token for API endpoint requests

3) Repeat step 1 to get a new access token when the access token expires

**Currently, access tokens expire after twenty minutes.**

### Basic Authentication Walkthrough

You can follow the steps for [authenticating and receiving a token using Swagger](/production/user-guide/#setting-up-your-credentials-in-swagger){:target="_self"}, or follow the walk-through below if you are using the command line or terminal.

To illustrate this cycle, we'll use the published open sandbox credentials. **Note: these credentials will not work in the production environment; please follow along using the credentials you were issued.**

```
Client ID:
09869a7f-46ce-4908-a914-6129d080a2ae

Client Secret:
64916fe96f71adc79c5735e49f4e72f18ff941d0dd62cf43ee1ae0857e204f173ba10e4250c12c48
```

**Request**

`POST /auth/token`

**Headers**

* `Accept: application/json`
* `Authorization: <Encoded Basic authentication>`

**cURL commands**

You can choose one of two cURL commands to use.

**Option 1, which performs Basic authentication by passing in an additional header**

Format:

```
curl -H "authorization: Basic [base64-encoded clientId:secret]"
```

Example:

```
curl -d '' -X POST "https://sandbox.bcda.cms.gov/auth/token" -H "accept: application/json" -H "authorization: Basic Mzg0MWM1OTQtYThjMC00MWU1LTk4Y2MtMzhiYjQ1MzYwZDNjOm\
Y5NzgwZDMyMzU4OGYxY2RmYzNlNjNlOTVhOGNiZGNkZDQ3NjAy\
ZmY0OGE1MzdiNTFkYzVkNzgzNGJmNDY2NDE2YTcxNmJkNDUwOGU5MDRh"
```

**Option 2, which does only requires you to submit your clientId and secret**


Format:

```
curl --user clientId:secret
```

Example:

```
curl --user 3841c594-a8c0-41e5-98cc-38bb45360d3c:f9780d323588f1cdfc3e63e95a8cbdcdd47602ff48a537b51dc5d7834bf466416a716bd4508e904a
```

**Response**

```
{
  “access_token”: “eyJhbGciOiJSUzUxMiIsInR5c ....”,
  ”token_type”:“bearer”
}
```

*Token string abbreviated for readability*

You will receive a `401 Unauthorized` response if your credentials are invalid or if your token has expired. No additional information is returned with a `401` response. When you receive a `401` response for a token you were just using successfully, you should request a new access token as outlined above.

## Environment

The examples below include [cURL](https://curl.haxx.se){:target="_blank"} commands, but may be followed using any tool that can make `HTTP GET` requests with headers, such as [Postman.](https://www.getpostman.com){:target="_blank"}

## Examples

### Sample Code
BCDA provides [test code written in Golang](https://github.com/CMSgov/bcda-app/blob/master/test/smoke_test/bcda_client.go){:target="_blank"} in our GitHub instance that you can use to set up your system to work with the API.
Sample invocation is below:
```
go run bcda_client.go -host=$HOSTNAME -clientID=$CLIENT_ID -clientSecret=$CLIENT_SECRET -endpoint=Patient -resourceType=ExplanationOfBenefit
```
Below we break down step by step each of the actions provided in the test client.

Examples are shown as requests to the BCDA production environment.

### BCDA Metadata

Metadata about the Beneficiary Claims Data API is available as a FHIR [CapabilityStatement](https://www.hl7.org/fhir/capabilitystatement.html){:target="_blank"} resource. A token is not required to access this information.

#### 1. Request the metadata

**Request**

`GET /api/v1/metadata`

**cURL command**

`curl https://api.bcda.cms.gov/api/v1/metadata`

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
    "url": "https://api.bcda.cms.gov"
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
            "reference": "https://api.bcda.cms.gov/api/v1/Patient/$export"
          }
        },
        {
          "name": "jobs",
          "definition": {
            "reference": "https://api.bcda.cms.gov/api/v1/jobs/[jobId]"
          }
        },
        {
          "name": "metadata",
          "definition": {
            "reference": "https://api.bcda.cms.gov/api/v1/metadata"
          }
        },
        {
          "name": "version",
          "definition": {
            "reference": "https://api.bcda.cms.gov/_version"
          }
        },
        {
          "name": "data",
          "definition": {
            "reference": "https://api.bcda.cms.gov/data/[jobID]/[random_UUID].ndjson"
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
curl -X GET "https://api.bcda.cms.gov/api/v1/Patient/$export" -H "accept: application/fhir+json" -H "Prefer: respond-async" -H "Authorization: Bearer {token}"
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 42 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://api.bcda.cms.gov/api/v1/jobs/42`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/42`

Using the *Content-Location* header value from the Patient data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -X GET "https://api.bcda.cms.gov/api/v1/jobs/42" \
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
  "request": "https://api.bcda.cms.gov/api/v1/Patient/$export",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "ExplanationOfBenefit",
      "url": "https://api.bcda.cms.gov/data/42/afd22dfa-c239-4063-8882-eb2712f9f638.ndjson"
    },
    {
      "type": "Coverage",
      "url": "https://api.bcda.cms.gov/data/42/f76a0b76-48ed-4033-aad9-d3eec37e7e83.ndjson"
    },
    {
      "type": "Patient",
      "url": "https://api.bcda.cms.gov/data/42/f92dcf16-63a2-448e-a12a-3bf677f966ed.ndjson"
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

`GET https://api.bcda.cms.gov/data/42/afd22dfa-c239-4063-8882-eb2712f9f638.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/42/afd22dfa-c239-4063-8882-eb2712f9f638.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as FHIR resources in NDJSON format. Each file related to a different resource type will appear separately and labeled as to which resource type it contains.

Examples of data from each Resource Type are available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).


### Requesting Beneficiary Explanation of Benefit Data only

The [**Explanation of Benefit** file](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} provides the same information you’ve previously received in CCLF files 1-7. This file contains the lines within an episode of care, including where and when the service was performed, the diagnosis codes, the provider who performed the service, and the cost of care.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Patient/$export?_type=ExplanationOfBenefit`

To start an explanation of benefit data export job, a GET request is made to the ExplanationOfBenefit endpoint. An access token as well as *Accept* and *Prefer* headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -v https://api.bcda.cms.gov/api/v1/Patient/$export?_type=ExplanationOfBenefit \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 43 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://api.bcda.cms.gov/api/v1/jobs/43`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/43`

Using the *Content-Location* header value from the ExplanationOfBenefit data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://api.bcda.cms.gov/api/v1/jobs/43 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.

```
{
  "transactionTime": "2019-12-09T21:20:57.254518Z",
  "request": "https://api.bcda.cms.gov/api/v1/Patient/$export?_type=ExplanationOfBenefit",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "ExplanationOfBenefit",
      "url": "https://api.bcda.cms.gov/data/43/472483a6-3aad-422c-beed-694344570548.ndjson"
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

`GET https://api.bcda.cms.gov/data/43/472483a6-3aad-422c-beed-694344570548.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/43/472483a6-3aad-422c-beed-694344570548.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR ExplanationOfBenefit resources](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

### Requesting Beneficiary Patient Data only

The [**Patient** file](https://www.hl7.org/fhir/patient.html){:target="_blank"} can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.

**Note the difference between the Patient endpoint and Patient resource type:** the Patient endpoint can return data from any or all of the three resource types. The Patient resource type within the Patient endpoint only returns the information described above.

The process of retrieving Patient data from the Patient endpoint is very similar to exporting Explanation of Benefit data.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Patient/$export?_type=Patient`

To start a Patient data export job, a GET request is made to the Patient export endpoint for the Patient resource type. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -v https://api.bcda.cms.gov/api/v1/Patient/$export?_type=Patient \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 44 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://api.bcda.cms.gov/api/v1/jobs/44`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/44`

Using the *Content-Location* header value from the Patient resource type data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://api.bcda.cms.gov/api/v1/jobs/44 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.
```
{
  "transactionTime": "2019-12-09T21:42:54.055223Z",
  "request": "https://api.bcda.cms.gov/api/v1/Patient/$export?_type=Patient",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "Patient",
      "url": "https://api.bcda.cms.gov/data/44/4e2cd98c-4746-4138-872b-24778c000b02.ndjson"
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

`GET https://api.bcda.cms.gov/data/44/4e2cd98c-4746-4138-872b-24778c000b02.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/44/4e2cd98c-4746-4138-872b-24778c000b02.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR Patient resources](https://www.hl7.org/fhir/patient.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

### Requesting Beneficiary Coverage Data Only

[**Coverage data**](https://www.hl7.org/fhir/coverage.html){:target="_blank"} indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

The process of retrieving coverage data is very similar to all of the other exporting operations supported by this API.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Patient/$export?_type=Coverage`

To start a coverage data export job, a GET request is made to the Patient endpoint for the Coverage resource type. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**
```
curl -v https://api.bcda.cms.gov/api/v1/Patient/$export?_type=Coverage \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 45 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://api.bcda.cms.gov/api/v1/jobs/45`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/45`

Using the *Content-Location* header value from the Coverage data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://api.bcda.cms.gov/api/v1/jobs/45 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.
```
{
  "transactionTime": "2019-12-09T21:51:58.182108Z",
  "request": "https://api.bcda.cms.gov/api/v1/Patient/$export?_type=Coverage",
  "requiresAccessToken": true,
  "output": [
    {
      "type": "Coverage",
      "url": "https://api.bcda.cms.gov/data/45/99dbc86f-74e5-4553-88a9-af3e718cb72b.ndjson"
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

`GET https://api.bcda.cms.gov/data/45/99dbc86f-74e5-4553-88a9-af3e718cb72b.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/45/99dbc86f-74e5-4553-88a9-af3e718cb72b.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR Coverage resources](https://www.hl7.org/fhir/coverage.html){:target="_blank"} in NDJSON format.

An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

### Filtering Your Data with `_since`
#### About `_since` 
The `_since` parameter grants you the ability to apply a date parameter to your bulk data requests. Instead of receiving the full record of historical data every time you request data from an endpoint, you will be able to use `_since` to submit a date. BCDA will then produce claims data from the bulk data endpoints that have been loaded since the entered date.

For more information on `_since`, please consult the [FHIR standard on query parameters](https://hl7.org/Fhir/uv/bulkdata/export/index.html#query-parameters){:target="_blank"}.

#### Usage
There are a couple of helpful points to keep in mind when using `_since`.

#### Before Using `_since` 
Before using `_since` for the first time, we recommend that you retrieve all historical data. Once you have retrieved your historical data and begun using `_since`, you should use [`transactionTime`](https://hl7.org/Fhir/uv/bulkdata/export/index.html#response---complete-status){:target="_blank"} from your last bulk data request as the date for following `_since` calls.

**Note: Due to limitations in the Beneficiary FHIR Data (BFD) Server, data from before 02-12-2020 is marked with the arbitrary [lastUpdated](https://www.hl7.org/fhir/search.html#lastUpdated){:target="_blank"} date of 01-01-2020. If you input dates between 01-01-2020 and 02-11-2020 in the `_since` parameter, you will receive all historical data for your beneficiaries. Data loads from 02-12-2020 onwards have been marked with accurate dates.**

#### Date and Timezone Formatting
Dates and times submitted in `_since` must be listed in the FHIR _dateTime_ format (`YYYY-MM-DDThh:mm:ss+zz:zz`). Notice that, if you need to include a time, a timezone must also be specified (`+zz:zz`).

* _Sample Date:_ February 20, 2020 12:00 PM EST
* _dateTime Format:_ YYYY-MM-DDThh:mm:ss+zz:zz
* _Formatted Sample:_ 2020-02-20T12:00:00.00-05:00

More information about the FHIR _dateTime_ format can be found in the [FHIR Datatypes page](https://www.hl7.org/fhir/datatypes.html#dateTime){:target="_blank"}.

#### Usage Examples
See the [Authentication and Authorization section](/production/technical-user-guide/#authentication-and-authorization){:target="_blank"} above to obtain the API token needed before requesting data from any of the BCDA bulk data endpoints. 

Here are examples of how to initiate an export job using `_since` to augment `/Patient`. We are seeking data from the `/Patient` endpoint for the Patient resource type since 8PM EST on February 13th, 2020. The steps and format would work similarly for other endpoints and resource types.

**Request**

`GET /api/v1/Patient/$export?_type=Patient?_since=2020-02-13T08:00:00.000-05:00`

**Headers**
* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL Command**
```
curl -X GET "https://api.bcda.cms.gov/api/v1/Patient/$export?_type=Patient?_since=2020-02-13T08:00:00.000-05:00
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**cURL Commands for Subsequent Steps**

Instructions for checking the status of the export job and retrieving NDJSON output file(s) can be found in previous sections. See _3. Checking the status of the export job_ and _4. Retrieving NDJSON output file(s)_.

For ease of use, we have listed the `Curl` commands below. The job ID (48) and file name for the NDJSON file (`4e2cd98c-4746-4138-872b-24778c000b02.ndjson`) will be different for your job.

**Check the status of the export job:**
```
curl -v https://api.bcda.cms.gov/api/v1/jobs/48 \
-H 'Authorization: Bearer {token}'
```

**Retrieve NDJSON output file(s):**
```
curl https://api.bcda.cms.gov/data/48/4e2cd98c-4746-4138-872b-24778c000b02.ndjson \
-H 'Authorization: Bearer {token}'
```