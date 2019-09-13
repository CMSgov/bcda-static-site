---
layout: home
title:  "Technical Getting Started Guide: Beneficiary Claims Data API"
description: "A Step-by-Step Guide to getting set up in BCDA and making retrieving data from the API."
date:   2019-09-06 09:21:12 -0500
description:
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
sections:
  - Tech User Guide
  - Authentication and Authorization
  - Encryption
  - Environment
  - Examples

button:
  - title: Home
    link: "#"

  - title: Sandbox
    subcategories:
      - subtitle: "Getting Started"
        subhref: "#"
      - subtitle: "Tech Guide"
        subhref: "#"
      - subtitle: "Decryption"
        subhref: "#"

  - title: Production
    subcategories:
      - subtitle: "Getting Started"
        subhref: "#"
      - subtitle: "Tech Guide"
        subhref: "#"
      - subtitle: "Decryption"
        subhref: "#"

  - title: About the Data
    subcategories:
      - subtitle: "Data Dictionary/CCLF crosswalk"
        subhref: "#"
      - subtitle: "Working w/BCDA Data"
        subhref: "#"

---

## Tech User Guide

The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) to retrieve claims data for their Medicare beneficiaries. This includes claims data for instances in which beneficiaries receive care outside of the ACO, allowing a full picture of patient care.

This API follows the workflow outlined by the [FHIR Bulk Data Export Proposal](https://github.com/smart-on-fhir/fhir-bulk-data-docs/blob/master/export.md){:target="_blank"} using the [HL7 FHIR Standard](https://www.hl7.org/fhir/){:target="_blank"}. Claims data is provided as FHIR resources in [NDJSON](http://ndjson.org){:target="_blank"} format.

This guide serves as a starting point for users to begin working with the API. [Comprehensive Swagger documentation about all BCDA endpoints is also available.](https://api.bcda.cms.gov/api/v1/swagger){:target="_blank"}

**Note:** if this documentation is a little too in-depth, you may want to start with our [guide to getting started in production](./user_guide.html) for an overview of APIs and a gentler walk-through.

**Note:** If you have not yet received production credentials, you will not be able to access production endpoints and data. To put your ACO in the queue for access, please send an email to bcapi@cms.hhs.gov with your name and your ACO’s name, ID number, and track. ACOs will be onboarded to production in the order in which requests are received.. While you wait, you can get familiar with the API in the sandbox environment, review the [data structure](./data_guide.html) and join the [BCDA Google Group](https://groups.google.com/forum/#!forum/bc-api){:target="_blank"}, to have your questions answered.

## Authentication and Authorization

This invitation-only production release of the Beneficiary Claims Data API protects its endpoints with OAuth2 access tokens. **Please treat your credentials like data: store them safely and securely.**

Once you have your credentials, you will:

1) `POST` to `https://api.bcda.cms.gov/auth/token` using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication){:target="_blank"}

2) Use the returned access token as the Bearer token for api endpoint requests

3) Repeat step 1 to get a new access token when the access token expires

**Currently, access tokens expire after one hour.**

#### Authentication Walk-through
You can follow the steps for [authenticating and receiving a token using Swagger](./user_guide.html#setting-up-your-credentials-in-swagger){:target="_blank"}, or follow the walk-through below if you are using the command line or terminal.

To illustrate this cycle, we'll use the published open sandbox credentials. **Note: these credentials will not work in the production environment; please follow along using the credentials you were issued.**

```
Client ID: 
09869a7f-46ce-4908-a914-6129d080a2ae

Client Secret: 
64916fe96f71adc79c5735e49f4e72f18ff941d0dd62cf43ee1ae0857e204f173ba10e4250c12c48
```

#### Encoded Basic authentication:
**Request**

```POST /auth/token```

**Headers**
* ```Accept: application/json```
* ```Authorization: <Encoded Basic authentication>```

In the following cURL command, notice that we have concatenated the base64 encoding of the 'Client ID":" Client Secret' as the argument to the -H flag.

```
curl -X POST "https://api.bcda.cms.gov/auth/token" -H "accept: application/json" -H "authorization: Basic MDk4NjlhN2YtNDZjZS00OTA4LWE5MTQtNjEyOWQwODBhMmFlOjY0OTE2ZmU5NmY3MWFkYzc5YzU3MzVlNDlmNGU3MmYxOGZmOTQxZDBkZDYyY2Y0M2VlMWFlMDg1N2UyMDRmMTczYmExMGU0MjUwYzEyYzQ4"
```

**Response**

You will receive a ```200 OK``` response and an access token if your credentials were accepted, with a body like so:

```
{
  “access_token”: “eyJhbGciOiJSUzUxMiIsInR5c ....”,
  ”token_type”:“bearer”
}
```
Token string abbreviated for readability

You will receive a ```401 Unauthorized``` response if your credentials are invalid or if your token has expired. No additional information is returned with a ```401``` response. When you receive a ```401``` response for a token you were just using successfully, you should request a new access token as outlined above.

## Encryption
All data files are encrypted. We have provided an [example of how to decrypt using Python.](decryption_walkthrough.html#how-to-decrypt-bcda-data-files){:target="_blank"}

## Environment
The examples below include [cURL](https://curl.haxx.se){:target="_blank"} commands, but may be followed using any tool that can make `HTTP GET` requests with headers, such as [Postman.](https://www.getpostman.com){:target="_blank"}

## Examples
Examples are shown as requests to the BCDA production environment.

### BCDA Metadata
Metadata about the Beneficiary Claims Data API is available as a FHIR [CapabilityStatement](https://www.hl7.org/fhir/capabilitystatement.html){:target="_blank"} resource. A token is not required to access this information.

#### 1. Request the metadata

##### Request

```GET /api/v1/metadata```

##### cURL command

```curl https://api.bcda.cms.gov/api/v1/metadata```

##### Response
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

#### Request

```GET /api/v1/ExplanationOfBenefit/$export```

To start an explanation of benefit data export job, a GET request is made to the ExplanationOfBenefit  endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

##### Headers
* ```Authorization: Bearer {token}```
* ```Accept: application/fhir+json```
* ```Prefer: respond-async```

##### cURL command
```
curl -v "https://api.bcda.cms.gov/api/v1/ExplanationOfBenefit/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

##### Response
If the request was successful, a ```202 Accepted``` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 42 in the URL represents the ID of the export job.

##### Headers
```Content-Location: https://api.bcda.cms.gov/api/v1/jobs/42```

#### 3. Check the status of the export job

##### Request

```GET https://api.bcda.cms.gov/api/v1/jobs/42```

Using the Content-Location header value from the ExplanationOfBenefit data export response, you can check the status of the export job. The status will change from ``202 Accepted`` to ``200 OK`` when the export job is complete and the data is ready to be downloaded.

##### Headers

* ```Authorization: Bearer {token}```

##### cURL command

```
curl -v https://api.bcda.cms.gov/api/v1/jobs/42 \
-H 'Authorization: Bearer {token}'
```

##### Responses
* ```202 Accepted``` indicates that the job is processing. Headers will include X-Progress: In Progress
* ```200 OK``` indicates that the job is complete.

Below is an example of the format of the response body.
```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/ExplanationOfBenefit/$export", "requiresAccessToken": true, "output": [ { "type": "ExplanationOfBenefit", "url": "https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":42}
```
**Take note:** There will also be an encryptedKey field as well as a KeyMap field containing the key values for decrypting both the .ndjson and error.ndjson files. 

Claims data can be found at the URLs within the output field. The number 42 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve NDJSON output file(s)
To obtain the exported explanation of benefit data, make a `GET` request to the output URLs in the job status response when the job reaches the Completed ```(200 OK)``` state. The data will be presented as an NDJSON file of [ExplanationOfBenefit](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} resources.

##### Request
```GET https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson```

##### Headers
* ```Authorization: Bearer {token}```

##### cURL command

```
curl https://api.bcda.cms.gov/data/42/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
   -H 'Authorization: Bearer {token}'
```
Take note of the {token}, be sure to not include the brackets {} for your request.

##### Response
The response will be the requested data as [FHIR ExplanationOfBenefit resources](https://www.hl7.org/fhir/explanationofbenefit.html){:target="_blank"} in NDJSON format, encrypted. You can [follow these instructions to decrypt.](decryption_walkthrough.html#how-to-decrypt-bcda-data-files){:target="_blank"}

An unencrypted example of one such resource is shown below. See about [about the data](./data_guide.html){:target="_blank"} for more information.

```
{"billablePeriod":{"end":"2000-10-01","start":"2000-10-01"},"diagnosis":[{"diagnosisCodeableConcept":{"coding":[{"code":"4011","display":"BENIGN HYPERTENSION","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":1,"type":[{"coding":[{"code":"principal","display":"The single medical diagnosis that is most relevant to the patient's chief complaint or need for treatment.","system":"https://bluebutton.cms.gov/resources/codesystem/diagnosis-type"}]}]},{"diagnosisCodeableConcept":{"coding":[{"code":"25000","display":"DMII WO CMP NT ST UNCNTR","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":2},{"diagnosisCodeableConcept":{"coding":[{"code":"9999999","system":"http://hl7.org/fhir/sid/icd-9-cm"}]},"sequence":3}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/prpayamt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":0}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_num","valueIdentifier":{"system":"https://bluebutton.cms.gov/resources/variables/carr_num","value":"99999"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_clm_pmt_dnl_cd","valueCoding":{"code":"1","display":"Physician/supplier","system":"https://bluebutton.cms.gov/resources/variables/carr_clm_pmt_dnl_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/asgmntcd","valueCoding":{"code":"A","display":"Assigned claim","system":"https://bluebutton.cms.gov/resources/variables/asgmntcd"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_clm_cash_ddctbl_apld_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":10}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_clm_prvdr_pmt_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":20}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_clm_bene_pmt_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":0}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_carr_clm_sbmtd_chrg_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":40}},{"url":"https://bluebutton.cms.gov/resources/variables/nch_carr_clm_alowd_amt","valueMoney":{"code":"USD","system":"urn:iso:std:iso:4217","value":40}}],"id":"carrier-10335267275","identifier":[{"system":"https://bluebutton.cms.gov/resources/variables/clm_id","value":"10335267275"},{"system":"https://bluebutton.cms.gov/resources/identifier/claim-group","value":"71914620265"}],"insurance":{"coverage":{"reference":"Coverage/part-b-19990000000136"}},"item":[{"adjudication":[{"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/carr_line_rdcd_pmt_phys_astn_c","display":"Carrier Line Reduced Payment Physician Assistant Code","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"reason":{"coding":[{"code":"0","display":"N/A","system":"https://bluebutton.cms.gov/resources/variables/carr_line_rdcd_pmt_phys_astn_c"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_nch_pmt_amt","display":"Line NCH Medicare Payment Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/line_pmt_80_100_cd","valueCoding":{"code":"0","display":"80%","system":"https://bluebutton.cms.gov/resources/variables/line_pmt_80_100_cd"}}]},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":0},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_pmt_amt","display":"Line Payment Amount to Beneficiary","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_prvdr_pmt_amt","display":"Line Provider Payment Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":10},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_ptb_ddctbl_amt","display":"Line Beneficiary Part B Deductible Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":0},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_bene_prmry_pyr_pd_amt","display":"Line Primary Payer (if not Medicare) Paid Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":10},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_coinsrnc_amt","display":"Line Beneficiary Coinsurance Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":40},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_sbmtd_chrg_amt","display":"Line Submitted Charge Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":40},"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_alowd_chrg_amt","display":"Line Allowed Charge Amount","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]}},{"category":{"coding":[{"code":"https://bluebutton.cms.gov/resources/variables/line_prcsg_ind_cd","display":"Line Processing Indicator Code","system":"https://bluebutton.cms.gov/resources/codesystem/adjudication"}]},"reason":{"coding":[{"code":"A","display":"Allowed","system":"https://bluebutton.cms.gov/resources/variables/line_prcsg_ind_cd"}]}}],"category":{"coding":[{"code":"1","display":"Medical care","system":"https://bluebutton.cms.gov/resources/variables/line_cms_type_srvc_cd"}]},"diagnosisLinkId":[3],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cd","valueCoding":{"code":"3","display":"Services","system":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_mtus_cnt","valueQuantity":{"value":1}},{"url":"https://bluebutton.cms.gov/resources/variables/betos_cd","valueCoding":{"code":"M1B","display":"Office visits - established","system":"https://bluebutton.cms.gov/resources/variables/betos_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/line_service_deductible","valueCoding":{"code":"0","display":"Service Subject to Deductible","system":"https://bluebutton.cms.gov/resources/variables/line_service_deductible"}}],"locationCodeableConcept":{"coding":[{"code":"99","display":"Other Place of Service. Other place of service not identified above.","system":"https://bluebutton.cms.gov/resources/variables/line_place_of_srvc_cd"}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/prvdr_state_cd","valueCoding":{"code":"99","display":"With 000 county code is American Samoa; otherwise unknown","system":"https://bluebutton.cms.gov/resources/variables/prvdr_state_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/prvdr_zip","valueCoding":{"code":"999999999","system":"https://bluebutton.cms.gov/resources/variables/prvdr_zip"}},{"url":"https://bluebutton.cms.gov/resources/variables/carr_line_prcng_lclty_cd","valueCoding":{"code":"99","system":"https://bluebutton.cms.gov/resources/variables/carr_line_prcng_lclty_cd"}}]},"quantity":{"value":1},"sequence":1,"service":{"coding":[{"code":"99213","system":"https://bluebutton.cms.gov/resources/codesystem/hcpcs","version":"1"}]},"servicedPeriod":{"end":"2000-10-01","start":"2000-10-01"}}],"patient":{"reference":"Patient/19990000000136"},"payment":{"amount":{"code":"USD","system":"urn:iso:std:iso:4217","value":20}},"resourceType":"ExplanationOfBenefit","status":"active","type":{"coding":[{"code":"71","display":"Local carrier non-durable medical equipment, prosthetics, orthotics, and supplies (DMEPOS) claim","system":"https://bluebutton.cms.gov/resources/variables/nch_clm_type_cd"},{"code":"CARRIER","system":"https://bluebutton.cms.gov/resources/codesystem/eob-type"},{"code":"professional","display":"Professional","system":"http://hl7.org/fhir/ex-claimtype"},{"code":"O","display":"Part B physician/supplier claim record (processed by local carriers; can include DMEPOS services)","system":"https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd"}]}}
```

### Beneficiary Patient Data
The [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"} file can be thought of as your CCLF files 8 and 9: this is where you get your information about who your beneficiaries are, their demographic information, and updates to their patient identifiers.

The process of retrieving patient data is very similar to exporting Explanation of Benefit data.

#### 1. Obtain an access token

See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2.  Initiate an export job

##### Request

```GET /api/v1/Patient/$export```

To start a patient data export job, a GET request is made to the Patient endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

##### Headers

* ```Authorization: Bearer {token}```
* ```Accept: application/fhir+json```
* ```Prefer: respond-async```

##### cURL command
```
curl -v "https://api.bcda.cms.gov/api/v1/Patient/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

##### Response
If the request was successful, a ```202 Accepted``` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 43 in the URL represents the ID of the export job.

##### Headers
```Content-Location: https://api.bcda.cms.gov/api/v1/jobs/43```

#### 3. Check the status of the export job

##### Request
```GET https://api.bcda.cms.gov/api/v1/jobs/43```

Using the Content-Location header value from the Patient data export response, you can check the status of the export job. The status will change from ```202 Accepted to 200 OK``` when the export job is complete and the data is ready to be downloaded.

##### Headers
* ```Authorization: Bearer {token}```

##### cURL command
```
curl -v https://api.bcda.cms.gov/v1/jobs/43 \
-H 'Authorization: Bearer {token}'
```

##### Responses
* ```202 Accepted``` indicates that the job is processing. Headers will include X-Progress: In Progress
* ```200 OK``` indicates that the job is complete. Below is an example of the format of the response body.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/Patient/$export", "requiresAccessToken": true, "output": [ { "type": "Patient", "url": "https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":43 }
```
**Take note:** There will also be an encryptedKey field as well as a KeyMap field containing the key values for decrypting both the .ndjson and error.ndjson files. 

Patient demographic data can be found at the URLs within the output field. The number 43 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve the NDJSON output file(s)
To obtain the patient data, a ```GET``` request is made to the output URLs in the job status response when the job reaches the Completed state. The data will be presented as an NDJSON file of [Patient](https://www.hl7.org/fhir/patient.html){:target="_blank"} resources.

##### Request
```GET https://api.bcda.cms.gov/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson```

##### Headers
* ```Authorization: Bearer {token}```

##### cURL command
```
curl https://api.bcda.cms.gov/v/data/43/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

##### Response
The response will be the requested data as FHIR Patient resources in NDJSON format, encrypted. An unencrypted example of one such resource is shown below. You can [follow these instructions to decrypt.](decryption_walkthrough.html#how-to-decrypt-bcda-data-files){:target="_blank"}

```
{"address":[{"district":"999","postalCode":"99999","state":"05"}],"birthDate":"1999-06-01","extension":[{"url":"https://bluebutton.cms.gov/resources/variables/race","valueCoding":{"code":"1","display":"White","system":"https://bluebutton.cms.gov/resources/variables/race"}}],"gender":"male","id":"19990000000140","identifier":[{"system":"https://bluebutton.cms.gov/resources/variables/bene_id","value":"19990000000140"},{"system":"https://bluebutton.cms.gov/resources/identifier/hicn-hash","value":"150bc2f50648848909d9e2fa949d007836310c4184fa426fea63f04268c06b1d"}],"name":[{"family":"Doe","given":["John","X"],"use":"usual"}],"resourceType":"Patient"}
```

### Beneficiary Coverage Data
[Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} data indicates the beneficiary’s enrollment record. It includes information on a beneficiary’s Part A, Part B, Part C, and Part D coverage, as well as markers for End-stage Renal Disease (ESRD) and Old Age and Survivors Insurance (OASI).

The process of retrieving coverage data is very similar to all of the other exporting operations supported by this API.

#### 1. Obtain an access token
See [Authentication and Authorization](#authentication-and-authorization) above.

#### 2. Initiate an export job

##### Request
```GET /api/v1/Coverage/$export```

To start a coverage data export job, a GET request is made to the Coverage export endpoint. An access token as well as Accept and Prefer headers are required.

The dollar sign (‘$’) before the word “export” in the URL indicates that the endpoint is an action rather than a resource. The format is defined by the [FHIR Bulk Data Export spec.](https://github.com/HL7/bulk-data/blob/master/spec/export/index.md){:target="_blank"}

##### Headers

* ```Authorization: Bearer {token}```
* ```Accept: application/fhir+json```
* ```Prefer: respond-async```

##### cURL command
```
curl -v "https://api.bcda.cms.gov/api/v1/Coverage/\$export" \
-H "accept: application/fhir+json" \
-H "Prefer: respond-async" \
-H "Authorization: Bearer {token}"
```

##### Response
If the request was successful, a ```202 Accepted``` response code will be returned and the response will include a Content-Location header. The value of this header indicates the location to check for job status and outcome. In the example header below, the number 44 in the URL represents the ID of the export job.

##### Headers
* ```Content-Location: https://api.bcda.cms.gov/api/v1/jobs/44```

#### 3. Check the status of the export job

##### Request

```GET https://api.bcda.cms.gov/api/v1/jobs/44```

Using the Content-Location header value from the Coverage data export response, you can check the status of the export job. The status will change from ```202 Accepted to 200 OK``` when the export job is complete and the data is ready to be downloaded.

##### Headers
* ```Authorization: Bearer {token}```

##### cURL command

```
curl -v https://api.bcda.cms.gov/v1/jobs/44 \
-H 'Authorization: Bearer {token}'
```

##### Responses
* ```202 Accepted``` indicates that the job is processing. Headers will include X-Progress: In Progress
* ```200 OK``` indicates that the job is complete.

```
{ "transactionTime": "2018-10-19T14:47:33.975024Z", "request": "https://api.bcda.cms.gov/api/v1/Coverage/$export", "requiresAccessToken": true, "output": [ { "type": "Coverage", "url": "https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson" } ], "error": [ { "type": "OperationOutcome", "url": "https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3-error.ndjson" } ],"JobID":44 }
```
**Take note:** There will also be an encryptedKey field as well as a KeyMap field containing the key values for decrypting both the .ndjson and error.ndjson files. 

Coverage demographic data can be found at the URLs within the output field. The number 44 in the data file URLs is the same job ID from the Content-Location header URL in the previous step. If some of the data cannot be exported due to errors, details of the errors can be found at the URLs in the error field. The errors are provided in an NDJSON file as FHIR [OperationOutcome](https://www.hl7.org/fhir/operationoutcome.html){:target="_blank"} resources.

#### 4. Retrieve the NDJSON output file(s)
To obtain the exported coverage data, a GET request is made to the output URLs in the job status response when the job reaches the Completed state. The data will be presented as an NDJSON file of [Coverage](https://www.hl7.org/fhir/coverage.html){:target="_blank"} resources.

##### Request
```GET https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson```

##### Headers
* ```Authorization: Bearer {token}```

##### cURL command
```
curl https://api.bcda.cms.gov/data/44/DBBD1CE1-AE24-435C-807D-ED45953077D3.ndjson \
-H 'Authorization: Bearer {token}'
```

##### Response
The response will be the requested data as FHIR Coverage resources in NDJSON format. An example of one such resource is shown below. You can [follow these instructions to decrypt.](decryption_walkthrough.html#how-to-decrypt-bcda-data-files){:target="_blank"}

```
{"beneficiary":{"reference":"Patient/19990000000140"},"contract":[{"id":"ptc-contract1"},{"reference":"Coverage/part-a-contract1 reference"}],"extension":[{"url":"https://bluebutton.cms.gov/resources/variables/ms_cd","valueCoding":{"code":"10","display":"Aged without end-stage renal disease (ESRD)","system":"https://bluebutton.cms.gov/resources/variables/ms_cd"}},{"url":"https://bluebutton.cms.gov/resources/variables/orec","valueCoding":{"code":"0","display":"Old age and survivor’s insurance (OASI)","system":"https://bluebutton.cms.gov/resources/variables/orec"}},{"url":"https://bluebutton.cms.gov/resources/variables/crec","valueCoding":{"code":"0","display":"Old age and survivor’s insurance (OASI)","system":"https://bluebutton.cms.gov/resources/variables/crec"}},{"url":"https://bluebutton.cms.gov/resources/variables/esrd_ind","valueCoding":{"code":"0","display":"the beneficiary does not have ESRD","system":"https://bluebutton.cms.gov/resources/variables/esrd_ind"}},{"url":"https://bluebutton.cms.gov/resources/variables/a_trm_cd","valueCoding":{"code":"0","display":"Not Terminated","system":"https://bluebutton.cms.gov/resources/variables/a_trm_cd"}}],"grouping":{"subGroup":"Medicare","subPlan":"Part A"},"id":"part-a-19990000000140","resourceType":"Coverage","status":"active","type":{"coding":[{"code":"Part A","system":"Medicare"}]}}
```