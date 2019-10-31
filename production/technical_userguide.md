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

2) Use the returned access token as the Bearer token for api endpoint requests

3) Repeat step 1 to get a new access token when the access token expires

**Currently, access tokens expire after one hour.**

#### Authentication Walkthrough

You can follow the steps for [authenticating and receiving a token using Swagger](/production/user-guide/#setting-up-your-credentials-in-swagger){:target="_self"}, or follow the walk-through below if you are using the command line or terminal.

To illustrate this cycle, we'll use the published open sandbox credentials. **Note: these credentials will not work in the production environment; please follow along using the credentials you were issued.**

```
Client ID:
09869a7f-46ce-4908-a914-6129d080a2ae

Client Secret:
64916fe96f71adc79c5735e49f4e72f18ff941d0dd62cf43ee1ae0857e204f173ba10e4250c12c48
```

#### Encoded Basic authentication:

**Request**

`POST /auth/token`

**Headers**

* `Accept: application/json`
* `Authorization: <Encoded Basic authentication>`

In the following cURL command, notice that we have concatenated the base64 encoding of the 'Client ID":" Client Secret' as the argument to the -H flag.

```
curl -X POST "https://api.bcda.cms.gov/auth/token" -H "accept: application/json" -H "authorization: Basic MDk4NjlhN2YtNDZjZS00OTA4LWE5MTQtNjEyOWQwODBhMmFlOjY0OTE2ZmU5NmY3MWFkYzc5YzU3MzVlNDlmNGU3MmYxOGZmOTQxZDBkZDYyY2Y0M2VlMWFlMDg1N2UyMDRmMTczYmExMGU0MjUwYzEyYzQ4"
```

**Response**

You will receive a `200 OK` response and an access token if your credentials were accepted, with a body like so:

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
    "date": "2019-05-30",
    "publisher": "Centers for Medicare & Medicaid Services",
    "kind": "capability",
    "instantiates": [
        "https://blob-pdcw16Tv76-1352124321.us-east-1.elb.amazonaws.com/baseDstu3/metadata/"
    ],
    "software": {
        "name": "Beneficiary Claims Data API",
        "version": "latest",
        "releaseDate": "2019-05-30"
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
                        "reference": "https://api.bcda.cms.gov/api/v1/ExplanationOfBenefit/$export"
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
                },
                {
                    "name": "export",
                    "definition": {
                        "reference": "https://api.bcda.cms.gov/api/v1/Patient/$export"
                    }
                },
                {
                    "name": "export",
                    "definition": {
                        "reference": "https://api.bcda.cms.gov/api/v1/Coverage/$export"
                    }
                }
            ]
        }
    ]
}
```

### Beneficiary Explanation of Benefit Data
The [Explanation of Benefit](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} file provides the same information you’ve previously received in CCLF files 1-7. This file contains the lines within an episode of care, including where and when the service was performed, the diagnosis codes, the provider who performed the service, and the cost of care.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/ExplanationOfBenefit/$export`

To start an explanation of benefit data export job, a GET request is made to the ExplanationOfBenefit  endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v "https://api.bcda.cms.gov/api/v1/ExplanationOfBenefit/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 42 in the URL represents the ID of the export job.

**Headers**

`Content-Location: https://api.bcda.cms.gov/api/v1/jobs/42`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/42`

Using the Content-Location header value from the ExplanationOfBenefit data export response, you can check the status of the export job. The status will change from ``202 Accepted`` to ``200 OK`` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl -v https://api.bcda.cms.gov/api/v1/jobs/42 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/ExplanationOfBenefit/$export", "requiresAccessToken": true, "output": [ { "type": "ExplanationOfBenefit", "url": "https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":42}
```

Claims data can be found at the URLs within the output field. The number 42 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)
To obtain the exported explanation of benefit data, make a `GET` request to the output URLs in the job status response when the job reaches the Completed `(200 OK)` state. The data will be presented as an NDJSON file of [ExplanationOfBenefit](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} resources.

**Request**

`GET https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
   -H 'Authorization: Bearer {token}'
```

Take note of the {token}, be sure to not include the brackets {} for your request.

**Response**

The response will be the requested data as [FHIR ExplanationOfBenefit resources](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} in NDJSON format. An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

### Beneficiary Patient Data
The [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"} file can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.

The process of retrieving patient data is very similar to exporting Explanation of Benefit data.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2.  Initiate an export job

**Request**

`GET /api/v1/Patient/$export`

To start a patient data export job, a GET request is made to the Patient endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v "https://api.bcda.cms.gov/api/v1/Patient/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 43 in the URL represents the ID of the export job.

**Headers**

`Content-Location: https://api.bcda.cms.gov/api/v1/jobs/43`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/43`

Using the Content-Location header value from the Patient data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl -v https://api.bcda.cms.gov/v1/jobs/43 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress
* `200 OK` indicates that the job is complete. Below is an example of the format of the response body.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/Patient/$export", "requiresAccessToken": true, "output": [ { "type": "Patient", "url": "https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":43 }
```

Patient demographic data can be found at the URLs within the output field. The number 43 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve the NDJSON output file(s)
To obtain the patient data, a `GET` request is made to the output URLs in the job status response when the job reaches the Completed state. The data will be presented as an NDJSON file of [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"} resources.

**Request**

`GET https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/v/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as FHIR Patient resources in NDJSON format. An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).

### Beneficiary Coverage Data
[Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} data indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

The process of retrieving coverage data is very similar to all of the other exporting operations supported by this API.

#### 1. Obtain an access token
See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/Coverage/$export`

To start a coverage data export job, a GET request is made to the Coverage export endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v "https://api.bcda.cms.gov/api/v1/Coverage/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 44 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://api.bcda.cms.gov/api/v1/jobs/44`

#### 3. Check the status of the export job

**Request**

`GET https://api.bcda.cms.gov/api/v1/jobs/44`

Using the Content-Location header value from the Coverage data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl -v https://api.bcda.cms.gov/v1/jobs/44 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress
* `200 OK` indicates that the job is complete.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/Coverage/$export", "requiresAccessToken": true, "output": [ { "type": "Coverage", "url": "https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":44 }
```

Coverage demographic data can be found at the URLs within the output field. The number 44 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve the NDJSON output file(s)

To obtain the exported coverage data, a GET request is made to the output URLs in the job status response when the job reaches the Completed state. The data will be presented as an NDJSON file of [Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} resources.

**Request**

`GET https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as FHIR Coverage resources in NDJSON format. An example of one such resource is available in the [guide to working with BCDA data](/data-guide/#sample-bcda-files).
