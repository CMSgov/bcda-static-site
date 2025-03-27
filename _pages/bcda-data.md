---
layout: api-docs
page_title: "BCDA Data"
seo_title: ""
description: ""
permalink: /bcda-data
in-page-nav: true
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
        Various doctors' services, outpatient care, preventive services, and durable medical equipment (DME)
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

The Data Dictionary maps the different data fields and locations between BCDA and Claim and Claim Line Feed (CCLF) files. [Explore all the differences between the data sources]({{ '/bcda-cclf-comparison' | relative_url }}).

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-2 tablet:grid-col-3 text-center">
    <img src="{{ '/assets/img/book.svg' | relative_url }}" alt="book illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
        <p>Download the <a href="{{ 'placeholder' | relative_url }}">BCDA Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}</a> to learn about:</p>
    <ul>
        <li>claim field names and descriptions</li>
        <li>new data field locations</li>
        <li>data types and format</li>
    </ul>
  </div>
</div>

## Partially adjudicated claims data

REACH ACOs can access claims that aren’t fully processed or approved yet. **This reduces the time to access Parts A and B claims data to 2-4 days after submission.**

<div class="grid-row grid-gap margin-y-4">
  <div class="grid-col-2 tablet:grid-col-3 text-center">
    <img src="{{ '/assets/img/medical-history.svg' | relative_url }}" alt="medical history folder illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
    <ul>
        <li>
            <a href="{{ 'partially-adjudicated-claims-data' | relative_url }}">Guide to Partially Adjudicated Claims Data</a>
        </li>
        <li>
            <a href="{{ 'placeholder' | relative_url }}" data-tealium="download">Data Dictionary for Partially Adjudicated Claims Data {% include sprite.html icon="file_download" class="text-middle" %}</a>
        </li>
    </ul>
  </div>
</div>

## Sample files

Download sample data files, which have similar content and structure to production data. [Try the sandbox environment]({{ 'placeholder' | relative_url }}) to access test data from the API.

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-2 tablet:grid-col-3 text-center">
    <img src="{{ '/assets/img/paper.svg' | relative_url }}" alt="paper illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
    <ul>
        <li><a href="{{ 'placeholder' | relative_url }}">ExplanationofBenefit {% include sprite.html icon="file_download" class="text-middle"%}</a></li>
        <li><a href="{{ 'placeholder' | relative_url }}">Patient{% include sprite.html icon="file_download" class="text-middle"%}</a></li>
        <li><a href="{{ 'placeholder' | relative_url }}">Coverage{% include sprite.html icon="file_download" class="text-middle"%}</a></li>
        <li><a href="{{ 'placeholder' | relative_url }}">Claim (partially adjudicated claims data){% include sprite.html icon="file_download" class="text-middle"%}</a></li>
        <li><a href="{{ 'placeholder' | relative_url }}">ClaimResponse (partially adjudicated claims data){% include sprite.html icon="file_download" class="text-middle"%}</a></li>
    </ul>
  </div>
</div>

## Resource types

Claims data is organized by resource types, which are requested at the /Patient and /Group [endpoints]({{ '/api-documentation' | relative_url }}#endpoints). Version 2 has [minor changes]({{ '/placeholder' | relative_url }}) in resource types from V1.

<dl>
  <dt class="font-sans-md text-bold">
    <a href="https://hl7.org/fhir/R4/explanationofbenefit.html" target="blank" rel="noopener noreferrer">Explanation of Benefit (EOB)</a>
  </dt> 
  <dd class="margin-left-0 margin-bottom-4"> 
    <p> Similar to CCLF files 1-7, EOB stores details for episodes of care, including where and when the service was performed, diagnosis codes, provider, and cost.</p>
  </dd>
  
  <dt class="font-sans-md text-bold">
    <a href="https://hl7.org/fhir/R4/patient.html" target="blank" rel="noopener noreferrer">Patient</a>
  </dt>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Similar to CCLF files 8 and 9, Patient stores enrollees' demographic details and updates to their patient identifiers.</p>
  </dd>

  <dt class="font-sans-md text-bold">
    <a href="https://hl7.org/fhir/R4/coverage.html" target="blank" rel="noopener noreferrer">Coverage</a>
  </dt>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Coverage stores enrollees' insurance coverage details, including dual coverage.</p>
  </dd>

  <dt class="font-sans-md text-bold">
    <a href="https://hl7.org/fhir/R4/claim.html" target="blank" rel="noopener noreferrer">Claim</a>
  </dt>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Available for partially adjudicated claims only, Claim stores financial and clinical details on professional and institutional claims. This is typically used for treatment payment planning and reimbursement.</p>
  </dd>

   <dt class="font-sans-md text-bold">
    <a href="https://hl7.org/fhir/R4/claimresponse.html">ClaimResponse</a>
  </dt>
  <dd class="margin-left-0 margin-bottom-4">
    <p>Available for partially adjudicated claims only, ClaimResponse stores details about the adjudication status and processing results for a claim, predetermination, or preauthorization.</p>
  </dd>
</dl>

<div class="usa-alert usa-alert--info">
  <div class="usa-alert__body">
    <h4 class="usa-alert__heading">Confidentiality and medical data sharing</h4>
    <p class="usa-alert__text">
      In accordance with applicable law, including HIPAA and 42 CFR Part 2, substance use disorder records are confidential. BCDA also does not share data on enrollees who have opted out of data sharing.
    </p>
  </div>
</div>