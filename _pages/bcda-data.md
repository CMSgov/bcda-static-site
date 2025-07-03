---
layout: api-docs
page_title: "BCDA Data"
seo_title: ""
description: "Explore BCDA's Medicare Parts A, B, and D data, including the Data Dictionary, sample files, resource types, and partially adjudicated claims data."
in-page-nav: true
sidebar-links: 
  - name: BCDA Data
    url: /bcda-data.html
    
    children:
      - name: Guide to Partially Adjudicated Claims Data
        url: /bcda-data/partially-adjudicated-claims-data.html

      - name: Comparison of BCDA and CCLF
        url: /bcda-data/comparison-bcda-cclf-files.html

      - name: Difference Between V1 and V2
        url: /bcda-data/difference-between-v1-v2.html
---

# {{ page.page_title }}

Beneficiary Claims Data API (BCDA) updates partially adjudicated claims data daily and adjudicated claims data weekly. Data includes:

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-4">
  <caption class="usa-sr-only">Definitions of Part A, B, and D claims data</caption>
  <thead>
    <tr>
      <th scope="col">Data type</th>
      <th scope="col">Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Medicare Part A claims data</th>
      <td>
        Inpatient hospital stays, care in skilled nursing facilities, and hospice care
      </td>
    </tr>
    <tr>
      <th scope="row">Medicare Part B claims data</th>
      <td>
        Doctors' services, outpatient care, preventive services, and durable medical equipment (DME)
      </td>
    </tr>
    <tr>
      <th scope="row">Medicare Part D claims data</th>
      <td>
         Prescription drugs prescribed by healthcare providers
      </td>
    </tr>
  </tbody>
</table>

## Data Dictionary

The Data Dictionary maps the different data fields and locations between BCDA and Claim and Claim Line Feed (CCLF) files. [Explore all the differences between the data sources]({{ '/bcda-data/comparison-bcda-cclf-files.html' | relative_url }}).

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-12 mobile-lg:grid-col-auto">
    <img src="{{ '/assets/img/book.svg' | relative_url }}" alt="book illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
      <p>Download the <a href="{{ '/assets/downloads/BCDA_Data_Dictionary.xlsx' | relative_url }}">BCDA Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a> to learn about:</p>
    <ul>
      <li>claim field names and descriptions</li>
      <li>new data field locations</li>
      <li>data types and format</li>
    </ul>
  </div>
</div>

## Partially adjudicated claims data

REACH ACOs can access claims that aren't fully processed or approved yet. **This reduces the time to access Parts A and B claims data to 2-4 days after submission.**

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-12 mobile-lg:grid-col-auto">
    <img src="{{ '/assets/img/medical-history.svg' | relative_url }}" alt="medical history folder illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
    <ul>
        <li>
            <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">Guide to Partially Adjudicated Claims Data</a>
        </li>
        <li>
            <a href="{{ '/assets/downloads/BCDA_Partially_Adjudicated_Data_Dictionary.xlsx' | relative_url }}" data-tealium="download">Data Dictionary for Partially Adjudicated Claims Data {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a>
        </li>
    </ul>
  </div>
</div>

## Sample files

Download sample data files, which share similar content and structure to production data. [Try the sandbox environment]({{ '/api-documentation.html' | relative_url }}) to access test data from the API.

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-12 mobile-lg:grid-col-auto">
    <img src="{{ '/assets/img/paper.svg' | relative_url }}" alt="paper illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
    <ul>
        <li><a href="{{ '/assets/downloads/ExplanationOfBenefit.ndjson' | relative_url }}">ExplanationOfBenefit.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
        <li><a href="{{ '/assets/downloads/Patient.ndjson' | relative_url }}">Patient.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
        <li><a href="{{ '/assets/downloads/Coverage.ndjson' | relative_url }}">Coverage.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a></li>
        <li><a href="{{ '/assets/downloads/Claim.ndjson' | relative_url }}">Claim.ndjson {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a> (partially adjudicated claims data) </li>
        <li><a href="{{ '/assets/downloads/ClaimResponse.ndjson' | relative_url }}">ClaimResponse.ndjson  {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a> (partially adjudicated claims data)</li>
    </ul>
  </div>
</div>

## Resource types

Claims data is organized by resource types, which are requested at the /Patient and /Group [endpoints]({{ '/api-documentation.html' | relative_url }}#endpoints). Version 2 has [minor changes]({{ '/bcda-data/difference-between-v1-v2.html' | relative_url }}) in resource types from V1.

<div class="usa-alert usa-alert--info margin-top-4">
  <div class="usa-alert__body">
    <h3 class="usa-alert__heading">Confidentiality and medical data sharing</h3>
    <p class="usa-alert__text">
      In accordance with applicable law, including HIPAA and 42 CFR Part 2, substance use disorder records are confidential. BCDA also does not share data on enrollees who have opted out of data sharing.
    </p>
  </div>
</div>


<dl class="margin-top-4">
  <dt class="font-sans-md text-bold" id="explanationofbenefit">
    ExplanationOfBenefit (EOB)
  </dt>
  <dd class="margin-left-0 margin-bottom-4"> 
    <p> Similar to CCLF files 1-7, <a href="https://hl7.org/fhir/R4/explanationofbenefit.html" target="_blank" rel="noopener noreferrer">ExplanationOfBenefit</a> stores details for episodes of care, including where and when the service was performed, diagnosis codes, provider, and cost of care.</p>
  </dd> 
  
  <div id="patient">
  <dt class="font-sans-md text-bold">
  Patient
  </dt></div>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Similar to CCLF files 8 and 9, <a href="https://hl7.org/fhir/R4/patient.html" target="_blank" rel="noopener noreferrer">Patient</a> stores enrollees' demographic details and updates to their patient identifiers.</p>
  </dd>

<div id="coverage">
  <dt class="font-sans-md text-bold">
  Coverage
  </dt> </div>
  <dd class="margin-left-0 margin-bottom-4">
    <p><a href="https://hl7.org/fhir/R4/coverage.html" target="_blank" rel="noopener noreferrer">Coverage</a> stores enrollees' insurance coverage details, including dual coverage.</p>
  </dd>

<div id="claim">
  <dt class="font-sans-md text-bold">
    Claim
  </dt> </div>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Available for partially adjudicated claims only, <a href="https://hl7.org/fhir/R4/claim.html" target="_blank" rel="noopener noreferrer">Claim</a> stores financial and clinical details on professional and institutional claims. This is typically used for treatment payment planning and reimbursement. </p> 
  </dd>

<div id="claimresponse">
   <dt class="font-sans-md text-bold">
   ClaimResponse
  </dt> </div>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Available for partially adjudicated claims only, <a href="https://hl7.org/fhir/R4/claimresponse.html" target="_blank" rel="noopener noreferrer">ClaimResponse</a> stores details about the adjudication status and processing results for a claim, predetermination, or preauthorization.</p>
  </dd>
</dl>