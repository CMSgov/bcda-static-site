---
layout: api-docs
page_title: "BCDA Data"
seo_title: ""
description: ""
permalink: /bcda-data
in-page-nav: true
---

# {{ page.page_title }}

The Beneficiary Claims Data API (BCDA) share large volumes of enrollee data, including:

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-4">
  <caption class="usa-sr-only">Definitions of Part A and Part B claims data</caption>
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
        inpatient hospital stays, care in skilled nursing facilities, and hospice care
      </td>
    </tr>
    <tr>
      <th scope="row">Medicare Part B claims data</th>
      <td>
        various doctors' services, outpatient care, medical supplies, and preventive services
      </td>
    </tr>
    <tr>
      <th scope="row">Medicare Part D claims data</th>
      <td>
         prescription drugs prescribed by healthcare providers
      </td>
    </tr>
  </tbody>
</table>

Model entities can use BCDA to access data files for all attributed enrollees, rather than on a patient-by-patient basis. BCDA automatically updates partially adjudicated claims data daily and fully adjudicated claims data weekly. 

## Partially adjudicated claims data

Accountable Care Organizations participating in the Realizing Equity, Access, and Community Health Model can access partially adjudicated claims data. These are claims that aren’t fully processed or approved. **This reduces the time to access Parts A and B claims data to 2-4 days after submission.**

<div class="grid-row grid-gap margin-y-4">
  <div class="grid-col-2 tablet:grid-col-3 text-center">
    <img src="{{ '/assets/img/medical-history.svg' | relative_url }}" alt="medical history folder illustration">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
    <ul>
        <li>
            <a href="{{ 'placeholder' | relative_url }}">Guide to Partially Adjudicated Claims Data</a>
        </li>
        <li>
            <a href="{{ 'placeholder' | relative_url }}" data-tealium="download">Data Dictionary for Partially Adjudicated Claims Data {% include sprite.html icon="file_download" class="text-middle" %}</a>
        </li>
    </ul>
  </div>
</div>

## Data Dictionary 

Similar to Claim and Claim Line Feed (CCLF) files, BCDA offers access to Medicare Parts A, B, and D claims data. However, BCDA uses the FHIR format with differences in data mapping and field names. [Explore the differences between BCDA and CCLF files.]({{ '/placeholder' | relative_url }})

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

<!-- Opting to use html insteal of jekyll component for simplicity -->
<div class="usa-alert usa-alert--info usa-alert--slim">
  <div class="usa-alert__body">
    <p class="usa-alert__text">
      <strong>Some data fields are not mapped from CCLF to BCDA.</strong> Visit the Notes column in the Data Dictionary for more details.
    </p>
  </div>
</div>

## Resource types

Claims data is organized into resource types, which can be requested by the /Patient and /Group endpoints. 

- [Explanation of Benefit (EOB)](https://hl7.org/fhir/R4/explanationofbenefit.html) (similar to CCLF files 1-7) – details from each episode of care, including where and when the service was performed, diagnosis codes, healthcare provider, and cost of care 
- [Patient](https://hl7.org/fhir/R4/patient.html) (similar to CCLF files 8 and 9) – enrollees' demographic details and updates to their patient identifiers
- [Coverage](https://hl7.org/fhir/R4/coverage.html) – enrollees' insurance coverage details, including dual coverage
- [Claim](https://hl7.org/fhir/R4/claim.html) (partially adjudicated claims only) – financial and clinical details on professional and institutional claims. This is typically used for treatment payment planning and reimbursement by benefit payors, insurers, and national health programs.
- [ClaimResponse](https://hl7.org/fhir/R4/claimresponse.html) (partially adjudicated claims only) –  details about the adjudication status and processing results for a claim, predetermination, or preauthorization.

We recommend using BCDA V2, which has minor changes in specification and resource types from V1. 

## Sample Files

Download sample resource files of BCDA data. These files have similar content and structure to actual production data. [Try out the sandbox environment]({{ 'placeholder' | relative_url }}) to access synthetic data using API requests.  


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