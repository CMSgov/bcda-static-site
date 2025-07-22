---
layout: api-docs
page_title: "Comparison of BCDA and CCLF Files"
seo_title: ""
description: "BCDA files have a different format than CCLF, and offer partially adjudicated claims data which updates more frequently."
in-page-nav: true
---

# {{ page.page_title }}

While Beneficiary Claims Data API (BCDA) and <a href="https://www.cms.gov/files/document/cclf-information-packet.pdf" target="blank" rel="noopener noreferrer">Claim and Claim Line Feed (CCLF)</a> files both offer Medicare Parts A, B, and D claims data, there are some differences including their formatting and the frequency with which they make data available.

Model entities can use either or both source(s) for data insights. It's important to choose what works best for your organization's workflow and needs. <a href="{{ '/assets/downloads/BCDA_Data_Dictionary.xlsx' | relative_url }}">Download the Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}</a> to review how fields map between BCDA and CCLF files.

## What are the differences?

CCLF files are automatically available monthly (using 12 flat files) and can be downloaded weekly upon request. BCDA updates adjudicated claims weekly (using 3 NDJSON files) and partially adjudicated claims data daily (using 2 additional NDJSON files).

BCDA uses the <a href="https://www.cms.gov/priorities/key-initiatives/burden-reduction/interoperability/implementation-guides-and-standards/standards-and-igs-index-and-resources" target="_blank" rel="noopener noreferrer">CMS recommended Bulk FHIR Standards</a>. This results in differences during data mapping.

## Summary of differences

<table class="usa-table usa-table--stacked usa-table--borderless margin-bottom-0">
    <thead>
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Access method</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Programmatically using API requests</td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Manually using portals or programmatically using API requests or Command Line Interface</td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Claims data format</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Interoperable and machine-readable, using FHIR R4 or STU3 format.</td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Human-readable, using <a href="https://www.cms.gov/files/document/cclf-information-packet.pdf" target="_blank" rel="noopener noreferrer">fixed-width tabular files.</a></td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Claims data source</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Adjudicated claims: Chronic Conditions Warehouse (CCW)</li>
                    <li>Partially adjudicated claims: Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS)</li>
                </ul>
            </td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Adjudicated claims: Integrated Data Repository (IDR)</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">CMS models supported</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Medicare Shared Savings Program (SSP)</li>
                    <li>Accountable Care Organizations Realizing Equity, Access, and Community Health (ACO REACH)</li>
                    <li>Kidney Care Choices (KCC)</li>
                </ul>
            </td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Medicare Shared Savings Program (SSP)</li>
                    <li>Accountable Care Organizations Realizing Equity, Access, and Community Health (ACO REACH)</li>
                    <li>Kidney Care Choices (KCC)</li>
                    <li>Vermont All-Payer</li>
                    <li>Primary Care First</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Data fields</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>ExplanationOfBenefit.Status supports 2 values ("active" or "canceled").</li>
                    <li>There are some FHIR-format metadata fields which don't exist in CCLF files*.</li>
                </ul>
            </td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>CLM_ADJSMT_TYPE_CD supports 3 numeric values (0=original, 1=cancellation, or 2=adjustment). </li>
                    <li>There are internal identifiers (e.g., claims processing, payment, auditing) which don't exist in BCDA data.<sup><a href="#fn1">*</a></sup></li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Historical data provided on newly attributed enrollees</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>SSP: all historical data available as far back as 2014</li>
                    <li>KCC: 24 months of historical data from the start of the current performance year</li>
                    <li>ACO REACH: 36 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>SSP: 36 months prior to agreement start date</li>
                    <li>KCC and ACO REACH: 36 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2">Update frequency</th>
        </tr>
        <tr>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Adjudicated claims: weekly</li>
                    <li>Partially adjudicated claims: daily</li>
                </ul>
            </td>
            <td style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                    <li>Adjudicated claims: monthly</li>
                    <li>Adjudicated claim extracts: weekly<sup><a href="#fn2">**</a></sup></li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<ul>
  <li id="fn1" style="scroll-margin-top: 6.25rem;"><a href="{{ '/assets/downloads/unmapped-fields-between-cclf-and-bcda.xlsx' | relative_url }}" data-tealium="download">Review all unmapped data fields between BCDA and CCLF files {% include sprite.html icon="file_download" class="text-middle" %}</a></li>
  <li id="fn2" style="scroll-margin-top: 6.25rem;">CCLF Files include weekly (one-time) extracts upon request.</li>
</ul>


## What are the differences between the data sources?

**CCLF files get data from the Integrated Data Repository (IDR) monthly**. The files are automatically generated monthly to match the cadence of required financial reports. However, weekly extracts are also available upon request.

**BCDA gets adjudicated claims data from CCW weekly**. The data is updated every weekend. Partially adjudicated claims data from FISS and MCS is available daily. BCDA combines CCW data with IDR's alignment data (e.g., suppression assumption, data sharing preferences included) to create claims extracts similar to those in CCLF files.

Since CCW and IDR refresh their data at different rates, there are sometimes minor data discrepancies. Additionally, while they use the same source system, IDR and CCW modify their data elements differently. For example, IDR has expanded data elements for enterprise functioning, while CCW has data structures and fields better suited for research. 

## Which data source is right for me?
Each data source has unique advantages. BCDA is an API, which allows you to automate data requests and streamline workflows for more efficient, secure processes. This lets you act quickly when proactive interventions or changes to your enrollees' care plans are needed. Additionally, the FHIR format makes it easier to bring large amounts of data into existing data models and combine them with EHRs and other sources of clinical data. 

CCLF files are more widely accessible. They're available to more model entities and its files can be downloaded directly from your model-specific portal.

## Can I use both data sources?

Yes, using both data sources provides many benefits:

- **Ensure data accuracy:** Compare and cross-reference both sources to access a wider variety of historical data and identify any discrepancies. 
- **Understand utilization patterns, health outcomes, and cost trends:** Combine CCLF files' enrollment data (e.g., start and end dates, coverage type, demographic details) with BCDA data. This can support population health management, risk stratification, and targeted intervention strategies.
- **Evaluate care coordination and payment processes:** Combine BCDA's insurance coverage details with CCLF files' payment data. This can evaluate the coordination of benefits between Medicare and other insurers, assess the financial impact on all parties, and identify primary or secondary payers.