---
layout: home
title:  "Technical Getting Started Guide:"
date:   2017-10-30 09:21:12 -0500
description: A Step-by-Step Guide to getting set up in BCDA and making retrieving data from the API
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
nav_link: sandbox
permalink: /sandbox/technical-user-guide/
id: sandbox-technical-user-guide
sections:
  - Technical User Guide
  - Authentication and Authorization
  - Encryption
  - Environment
  - Examples
  - Beneficiary Explanation of Benefit Data
  - Beneficiary Patient Data
  - Beneficiary Coverage Data
---

## Technical User Guide

The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) to retrieve claims data for their Medicare beneficiaries. This includes claims data for instances in which beneficiaries receive care outside of the ACO, allowing a full picture of patient care.

This API follows the workflow outlined by the [FHIR Bulk Data Export Proposal](https://github.com/smart-on-fhir/fhir-bulk-data-docs/blob/master/export.md), using the [HL7 FHIR Standard](https://www.hl7.org/fhir/). Claims data is provided as FHIR resources in [NDJSON](http://ndjson.org/) format.

This guide serves as a starting point for users to begin working with the API. [Comprehensive Swagger documentation about all BCDA endpoints is also available](https://api.bcda.cms.gov/api/v1/swagger).

**Note:** if this documentation is a little too in-depth, you may want to start with our [guide to getting started](/sandbox/user-guide/) for an overview of APIs and a gentler walk-through.

## Authentication and Authorization

The Beneficiary Claims Data API is currently accessible as an open sandbox environment, which returns sample NDJSON files with synthetic beneficiary data. You can use the generic credentials below to view our implementation of the API, write a process for decrypting the payload, and learn the shape of the data before working with production files that include PII and PHI. There is no beneficiary PII or PHI in the files you can access via the sandbox.

To get a token that can be used with protected endpoints, POST the following credentials using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) to `https://sandbox.bcda.cms.gov/auth/token`:

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

## Encryption

All data files are encrypted. We have provided [an example of how to decrypt using Python](/decryption/).

## Environment

The examples below include [cURL](https://curl.haxx.se/) commands, but may be followed using any tool that can make HTTP GET requests with headers, such as [Postman](https://www.getpostman.com/).

## Examples

Examples are shown as requests to the BCDA sandbox environment.

### BCDA Metadata

Metadata about the Beneficiary Claims Data API is available as a FHIR [CapabilityStatement](https://www.hl7.org/fhir/capabilitystatement.html) resource. A token is not required to access this information.

#### 1. Request the metadata

**Request**

`GET /api/v1/metadata`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/api/v1/metadata
```

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
                        "reference": "https://sandbox.bcda.cms.gov/api/v1/ExplanationOfBenefit/$export"
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
                },
                {
                    "name": "export",
                    "definition": {
                        "reference": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export"
                    }
                },
                {
                    "name": "export",
                    "definition": {
                        "reference": "https://sandbox.bcda.cms.gov/api/v1/Coverage/$export"
                    }
                }
            ]
        }
    ]
}
```

## Beneficiary Explanation of Benefit Data

The [**Explanation of Benefit** file](https://www.hl7.org/fhir/explanationofbenefit.html) provides the same information you’ve previously received in CCLF files 1-7. This file contains the lines within an episode of care, including where and when the service was performed, the diagnosis codes, the provider who performed the service, and the cost of care.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

**Request**

`GET /api/v1/ExplanationOfBenefit/$export`

To start an explanation of benefit data export job, a GET request is made to the ExplanationOfBenefit  endpoint. An access token as well as *Accept* and *Prefer* headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md).

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/ExplanationOfBenefit/\$export \
-H 'Authorization: Bearer {token}' \
-H 'Accept: application/fhir+json' \
-H 'Prefer: respond-async'
```

**Response**

If the request was successful, a `202 Accepted` response code will be returned and the response will include a *Content-Location* header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 42 in the URL represents the ID of the export job.

**Headers**

* `Content-Location: https://sandbox.bcda.cms.gov/api/v1/jobs/42`

#### 3. Check the status of the export job

**Request**

`GET https://sandbox.bcda.cms.gov/api/v1/jobs/42`

Using the *Content-Location* header value from the ExplanationOfBenefit data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

**Headers**

* `Authorization: Bearer {token}`

**cURL Command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/jobs/42 \
-H 'Authorization: Bearer {token}'
```

**Responses**

* `202 Accepted` indicates that the job is processing. Headers will include X-Progress: In Progress (The X-Progress header contains text indicating the job's status in BCDA's workflow. When the status is In Progress, an estimated progress percentage is also included.)
* `200 OK` indicates that the job is complete.

Below is an example of the format of the response body.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://sandbox.bcda.cms.gov/api/v1/ExplanationOfBenefit/$export", "requiresAccessToken": true, "output": [ { "type": "ExplanationOfBenefit", "url": "https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://sandbox.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ] }
```

Claims data can be found at the URLs within the output field. The number 42 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html) resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported explanation of benefit data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as an NDJSON file of [ExplanationOfBenefit](https://www.hl7.org/fhir/explanationofbenefit.html) resources.

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

The response will be the requested data as [FHIR ExplanationOfBenefit resources](https://www.hl7.org/fhir/explanationofbenefit.html) in NDJSON format, encrypted. You can [follow these instructions to decrypt](../../decryption_walkthrough.html).

An unencrypted example of one such resource is shown below. See our [guide to working with BCDA data](../../data_guide.html) for more info.

```
{"billablePeriod":{"end":"2000-10-01","start":"2000-10-01"},"diagnosis":[{"diagnosisCodeableConcept":{"coding":[{"code":"4011","display":"BENIGN HYPERTENSION","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":1,"type":[{"coding":[{"code":"principal","display":"The single medical diagnosis that is most relevant to the patient's chief complaint or need for treatment.","system":"https://bluebutton.cms.gov/resources/codesystem/diagnosis-type"}]}]},{"diagnosisCodeableConcept":{"coding":[{"code":"25000","display":"DMII WO CMP NT ST UNCNTR","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":2},{"diagnosisCodeableConcept":{"coding":[{"code":"9999999","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":3}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/prpayamt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":0}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_num","valueIdentifier":{"system":"https://bluebutton.cms.gov/resources/variables/carr_num","value":"99999"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_clm_pmt_dnl_cd","valueCoding":{"code":"1","display":"Physician/supplier","system":"https://bluebutton.cms.gov/resources/variables/carr_clm_pmt_dnl_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/asgmntcd","valueCoding":{"code":"A","display":"Assigned claim","system":"https://bluebutton.cms.gov/resources/variables/asgmntcd"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_clm_cash_ddctbl_apld_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":10}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_clm_prvdr_pmt_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":20}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_clm_bene_pmt_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":0}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_carr_clm_sbmtd_chrg_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":40}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_carr_clm_alowd_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":40}}],"id":"carrier-10335267275","identifier":[{"system":"https://bluebutton.cms.gov/resources/variables/clm_id","value":"10335267275"},{"system":"https://bluebutton.cms.gov/resources/identifier/claim-group","value":"71914620265"}],"insurance":{"coverage":{"reference":"Coverage/part-b-19990000000136"}},"item":[{"adjudication":[{"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/carr_line_rdcd_pmt_phys_astn_c","display":"Carrier Line Reduced Payment Physician Assistant Code","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"reason":{"coding":[{"code":"0","display":"N/A","system":"https://bluebutton.cms.gov/resources/variables/carr_line_rdcd_pmt_phys_astn_c"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_nch_pmt_amt","display":"Line NCH Medicare Payment Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/line_pmt_80_100_cd","valueCoding":{"code":"0","display":"80%","system":"https://bluebutton.cms.gov/resources/variables/line_pmt_80_100_cd"}}]},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":0},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_pmt_amt","display":"Line Payment Amount to Beneficiary","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_prvdr_pmt_amt","display":"Line Provider Payment Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":10},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_ptb_ddctbl_amt","display":"Line Beneficiary Part B Deductible Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":0},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_prmry_pyr_pd_amt","display":"Line Primary Payer (if not Medicare) Paid Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":10},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_coinsrnc_amt","display":"Line Beneficiary Coinsurance Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":40},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_sbmtd_chrg_amt","display":"Line Submitted Charge Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":40},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_alowd_chrg_amt","display":"Line Allowed Charge Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_prcsg_ind_cd","display":"Line Processing Indicator Code","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"reason":{"coding":[{"code":"A","display":"Allowed","system":"https://bluebutton.cms.gov/resources/variables/line_prcsg_ind_cd"}]}}],"category":{"coding":[{"code":"1","display":"Medical care","system":"https://bluebutton.cms.gov/resources/variables/line_cms_type_srvc_cd"}]},"diagnosisLinkId":[3],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cd","valueCoding":{"code":"3","display":"Services","system":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cnt","valueQuantity":{"value":1}},{"url":"https://bluebutton.cms.gov/resources/variables/betos_cd","valueCoding":{"code":"M1B","display":"Office visits - established","system":"https://bluebutton.cms.gov/resources/variables/betos_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/line_service_deductible","valueCoding":{"code":"0","display":"Service Subject to Deductible","system":"https://bluebutton.cms.gov/resources/variables/line_service_deductible"}}],"locationCodeableConcept":{"coding":[{"code":"99","display":"Other Place of Service. Other place of service not identified above.","system":"https://bluebutton.cms.gov/resources/variables/line_place_of_srvc_cd"}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/prvdr_state_cd","valueCoding":{"code":"99","display":"With 000 county code is American Samoa; otherwise unknown","system":"https://bluebutton.cms.gov/resources/variables/prvdr_state_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/prvdr_zip","valueCoding":{"code":"999999999","system":"https://bluebutton.cms.gov/resources/variables/prvdr_zip"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_prcng_lclty_cd","valueCoding":{"code":"99","system":"https://bluebutton.cms.gov/resources/variables/carr_line_prcng_lclty_cd"}}]},"quantity":{"value":1},"sequence":1,"service":{"coding":[{"code":"99213","system":"https://bluebutton.cms.gov/resources/codesystem/hcpcs","version":"1"}]},"servicedPeriod":{"end":"2000-10-01","start":"2000-10-01"}}],"patient":{"reference":"Patient/19990000000136"},"payment":{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20}},"resourceType":"ExplanationOfBenefit","status":"active","type":{"coding":[{"code":"71","display":"Local carrier non-durable medical equipment, prosthetics, orthotics, and supplies (DMEPOS) claim","system":"https://bluebutton.cms.gov/resources/variables/nch_clm_type_cd"},{"code":"CARRIER","system":"https://bluebutton.cms.gov/resources/codesystem/eob-type"},{"code":"professional","display":"Professional","system":"http://hl7.org/fhir/ex-claimtype"},{"code":"O","display":"Part B physician/supplier claim record (processed by local carriers; can include DMEPOS services)","system":"https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd"}]}}
```

## Beneficiary Patient Data

The [**Patient** file](https://www.hl7.org/fhir/patient.html) can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.

The process of retrieving patient data is very similar to exporting Explanation of Benefit data.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

##### Request

`GET /api/v1/Patient/$export`

To start a patient data export job, a GET request is made to the Patient export endpoint. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/smart-on-fhir/fhir-bulk-data-docs/blob/master/export.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/Patient/\$export \
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

Using the *Content-Location* header value from the Patient data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

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
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://sandbox.bcda.cms.gov/api/v1/Patient/$export", "requiresAccessToken": true, "output": [ { "type": "Patient", "url": "https://sandbox.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://sandbox.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ] }
```

Patient demographic data can be found at the URLs within the output field. The number 43 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html) resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported patient data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as an NDJSON file of [Patient](https://www.hl7.org/fhir/patient.html) resources.

**Request**

`GET https://sandbox.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson`

**Headers**

* `Authorization: Bearer {token}`

**cURL command**

```
curl https://sandbox.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

**Response**

The response will be the requested data as [FHIR Patient resources](https://www.hl7.org/fhir/patient.html) in NDJSON format, encrypted. You can [follow these instructions to decrypt](../../decryption_walkthrough.html).

An unencrypted example of one such resource is shown below. See our [guide to working with BCDA data](../../data_guide.html) for more info.

```
{"address":[{"district":"999","postalCode":"99999","state":"05"}],"birthDate":"1999-06-01","extension":[{"url":"https://bluebutton.cms.gov/resources/variables/race","valueCoding":{"code":"1","display":"White","system":"https://bluebutton.cms.gov/resources/variables/race"}}],"gender":"male","id":"19990000000140","identifier":[{"system":"https://bluebutton.cms.gov/resources/variables/bene_id","value":"19990000000140"},{"system":"https://bluebutton.cms.gov/resources/identifier/hicn-hash","value":"150bc2f50648848909d9e2fa949d007836310c4184fa426fea63f04268c06b1d"}],"name":[{"family":"Doe","given":["John","X"],"use":"usual"}],"resourceType":"Patient"}
```

## Beneficiary Coverage Data

[**Coverage data**](https://www.hl7.org/fhir/coverage.html) indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

The process of retrieving coverage data is very similar to all of the other exporting operations supported by this API.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization){:target="_self"} above.

#### 2. Initiate an export job

##### Request

`GET /api/v1/Coverage/$export`

To start a coverage data export job, a GET request is made to the Coverage export endpoint. An access token as well as `Accept` and `Prefer` headers are required.

The dollar sign ('$') before the word "export" in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec](https://github.com/smart-on-fhir/fhir-bulk-data-docs/blob/master/export.md){:target="_blank"}.

**Headers**

* `Authorization: Bearer {token}`
* `Accept: application/fhir+json`
* `Prefer: respond-async`

**cURL command**

```
curl -v https://sandbox.bcda.cms.gov/api/v1/Coverage/\$export \
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

Using the *Content-Location* header value from the Coverage data export response, you can check the status of the export job. The status will change from `202 Accepted` to `200 OK` when the export job is complete and the data is ready to be downloaded.

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
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://sandbox.bcda.cms.gov/api/v1/Coverage/$export", "requiresAccessToken": true, "output": [ { "type": "Coverage", "url": "https://sandbox.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://sandbox.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ] }
```

Coverage data can be found at the URLs within the output field. The number 44 in the data file URLs is the same job ID from the *Content-Location* header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html) resources.

#### 4. Retrieve NDJSON output file(s)

To obtain the exported coverage data, make a GET request to the output URLs in the job status response when the job reaches the Completed (200 OK) state. The data will be presented as an NDJSON file of [Coverage](https://www.hl7.org/fhir/coverage.html) resources.

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

The response will be the requested data as [FHIR Coverage resources](https://www.hl7.org/fhir/coverage.html) in NDJSON format, encrypted. You can [follow these instructions to decrypt](../../decryption_walkthrough.html).

An unencrypted example of one such resource is shown below. See our [guide to working with BCDA data](../../data_guide.html) for more info.

```
{"beneficiary":{"reference":"Patient/19990000000140"},"contract":[{"id":"ptc-contract1"},{"reference":"Coverage/part-a-contract1 reference"}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/ms_cd","valueCoding":{"code":"10","display":"Aged without end-stage renal disease (ESRD)","system":"https://bluebutton.cms.gov/resources/variables/ms_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/orec","valueCoding":{"code":"0","display":"Old age and survivor’s insurance (OASI)","system":"https://bluebutton.cms.gov/resources/variables/orec"}},{"url":"https://bluebutton.cms.gov/resources/variables/crec","valueCoding":{"code":"0","display":"Old age and survivor’s insurance (OASI)","system":"https://bluebutton.cms.gov/resources/variables/crec"}},{"url":"https://bluebutton.cms.gov/resources/variables/esrd_ind","valueCoding":{"code":"0","display":"the beneficiary does not have ESRD","system":"https://bluebutton.cms.gov/resources/variables/esrd_ind"}},{"url":"https://bluebutton.cms.gov/resources/variables/a_trm_cd","valueCoding":{"code":"0","display":"Not Terminated","system":"https://bluebutton.cms.gov/resources/variables/a_trm_cd"}}],"grouping":{"subGroup":"Medicare","subPlan":"Part A"},"id":"part-a-19990000000140","resourceType":"Coverage","status":"active","type":{"coding":[{"code":"Part A","system":"Medicare"}]}}
```