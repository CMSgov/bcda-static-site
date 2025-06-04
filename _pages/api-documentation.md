---
layout: api-docs
page_title: "API Documentation"
seo_title: ""
description: ""
in-page-nav: true
---

# {{ page.page_title }}

Beneficiary Claims Data API (BCDA) uses <a href="https://hl7.org/fhir/uv/bulkdata/" target="_blank" rel="noopener noreferrer">Bulk Fast Healthcare Interoperability Resources (FHIR)</a> to share claims data. You can use a variety of tools or client software programs to access the sandbox and production environments.

## Getting started

<ol class="usa-process-list margin-top-1 docs-process-list">
  <li class="usa-process-list__item">
    <p class="usa-process-list__heading">Learn about BCDA</p>
    <p>
      Explore the documentation, <a href="{{ '/bcda-data.html#data-dictionary' | relative_url }}">Data Dictionary</a>, and <a href="{{ '/bcda-data.html#sample-files' | relative_url }}">sample files</a>.
    </p>
  </li>
  <li class="usa-process-list__item">
    <p class="usa-process-list__heading">Use the sandbox</p>
    <p>
      The sandbox environment allows anyone to try the API and download test claims data. Learn how to <a href="{{ '/get-a-bearer-token.html' | relative_url }}">get a bearer token</a> and <a href="{{ '/access-claims-data.html' | relative_url }}">access the sandbox</a>.  
    </p>
  </li>
  <li class="usa-process-list__item docs-final-item">
    <p class="usa-process-list__heading">Get production access</p>
    <p>
      <a href="{{ '/index.html#eligible-model-entities' | relative_url }}">Eligible model entities</a> must have <a href="{{ '/production-access.html' | relative_url }}">production credentials</a> to access their enrollees’ claims data. 
    </p>
  </li>
</ol>

## Endpoints

Endpoints request data by [resource type]({{ '/bcda-data.html' | relative_url }}#resource-types). Data is returned for enrollees attributed to your organization, but you can't make requests for individual patient data. 

### /metadata

Request the [FHIR CapabilityStatement](https://hl7.org/fhir/R4/capabilitystatement.html) for basic information on the API, like its version and whether it’s currently active. This does not require authorization. 

### /Group
Use the [/Group endpoint](https://build.fhir.org/ig/HL7/bulk-data/export.html#endpoint---group-of-patients) to request the ExplanationOfBenefit, Patient, and Coverage resource types. For partially adjudicated claims, this includes Claim and ClaimResponse. Provide the `all` or `runout` identifier to indicate whose data you’d like returned: 

- **/Group/all**: returns data for all Medicare enrollees currently attributed to your model entity
- **/Group/runout**: returns data for Medicare enrollees attributed to your model entity during the previous year, but not the current year. The data will have a service date no later than December 31 of the previous year.

Using the [_since parameter]({{ '/filter-claims-data.html#the-_since-parameter' | relative_url }}) with /Group will return resources updated after the date provided for existing enrollees and all resources for newly attributed enrollees. 

This lets you retrieve all new claims data with a single request. If you don’t apply _since, BCDA will return data as early as 2014.

### /Patient

Similar to /Group/all, use the <a href="https://build.fhir.org/ig/HL7/bulk-data/export.html#endpoint---all-patients" target="_blank" rel="noopener noreferrer">/Patient endpoint</a> to request data for all Medicare enrollees currently attributed to your model entity.

Using the _since parameter with /Patient will return resources updated after the date provided for existing and newly attributed enrollees. 

Newly attributed enrollees are those who’ve been assigned to your model entity since your last attribution date. If you don’t apply _since, BCDA will return data as early as 2014.

### /jobs

Request information about previous job requests, including the job ID, creation time, completion time, and original job request. 

If you can’t remember the job ID after starting a job, use this endpoint to retrieve the ID. Each entry in the resource bundle is in the <a href="https://www.hl7.org/fhir/task.html" target="_blank" rel="noopener noreferrer">FHIR Task</a> format.

### /attribution_status

Request a datetime and timestamp for when your enrollee list or runout files were last updated. 

Attribution files are updated once per month. It can be useful to retrieve all claims data for newly attributed enrollees to get a full picture of their health histories. 

## Parameters

Use parameters during job requests to filter or specify the resources returned:

- **The _type parameter**: Limit your request to specific resource types. Instead of receiving data from all available resource types, specify 1 or more. 

- **The _since parameter**: Apply a date boundary to your requests. Instead of receiving the full record of historical data, filter for resources last updated after a specified date. 

[Explore how to filter claims data.]({{ '/filter-claims-data.html' | relative_url }})

## Additional resources

BCDA provides Medicare claims data using the NDJSON format.

- <a href="https://www.hl7.org/fhir/" target="_blank" rel="noopener noreferrer">FHIR/HL7</a>
- <a href="http://build.fhir.org/ig/HL7/VhDir/bulk-data.html" target="_blank" rel="noopener noreferrer">Bulk FHIR specification</a>
- <a href="https://bluebutton.cms.gov/assets/ig/index.html" target="_blank" rel="noopener noreferrer">Blue Button Implementation Guide</a>
- Intro to the <a href="https://www.json.org/json-en.html" target="_blank" rel="noopener noreferrer">JSON Format</a> and <a href="https://github.com/ndjson/ndjson-spec/" target="_blank" rel="noopener noreferrer">NDJSON</a>
- <a href="https://jsonlint.com/" target="_blank" rel="noopener noreferrer">JSON format viewer/validator</a> (raw text/JSON format converter)
- <a href="https://hl7.org/fhir/R4/validation.html" target="_blank" rel="noopener noreferrer">Intro to valid FHIR formats</a>