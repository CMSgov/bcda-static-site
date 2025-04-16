---
layout: api-docs
page_title: "Comparison of BCDA and CCLF Files"
seo_title: ""
description: ""
in-page-nav: true
---
# {{ page.page_title }}

While Beneficiary Claims Data API (BCDA) and Claim and Claim Line Feed (CCLF) files both offer Medicare Parts A, B, and D claims data, there are some differences between the format and update frequency. 

Model entities can use either or both source(s) for data insights. It’s important to choose what works best for your organization's workflow and needs. <a href="{{ '/assets/downloads/BCDA_Data_Dictionary.xlsx' | relative_url }}">Download the Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}</a> to review how fields map between BCDA and CCLF files.

## What are the differences?

### Update frequency: 

CCLF files update monthly using 12 flat files. BCDA updates adjudicated claims weekly using 3 files and partially adjudicated claims data (REACH ACOs only) daily using 2 additional files. 

### Format: 

CCLF files focus more on detailed demographic and claims processing context, while BCDA provides a snapshot of enrollees’ claims database. 

BCDA uses the <a href="https://hl7.org/fhir/uv/bulkdata/" target="blank" rel="noopener noreferrer">Bulk Fast Healthcare Interoperability Resources (FHIR)</a> format as required by Medicare. This results in differences during data mapping. 

## Summary of differences

<table class="usa-table usa-table--stacked usa-table--borderless">
    <thead>
        <tr>
            <th scope="col"></th>
            <th scope="col">BCDA</th>
            <th scope="col">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>Access method</th>
            <td data-label="BCDA">Programmatically using API requests</td>
            <td data-label="CCLF">Manually using portals or programmatically using API requests or Command Line Interface</td>
        </tr>
        <tr>
            <th>Claims data format</th>
            <td data-label="BCDA">Interoperable and machine-readable, using FHIR R4 or STU3 format.</td>
            <td data-label="CCLF">Human-readable, using <a href="https://www.cms.gov/files/document/cclf-information-packet.pdf" target="blank" rel="noopener noreferrer">fixed-width tabular files.</a></td>
        </tr>
        <tr>
            <th>Claims data source</th>
            <td data-label="BCDA">
                <ul>
                    <li>Adjudicated claims: Chronic Conditions Warehouse (CCW)</li>
                    <li>Partially adjudicated claims: Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS)</li>
                </ul>
            </td>
            <td data-label="CCLF">Adjudicated claims: Integrated Data Repository (IDR)</td>
        </tr>
        <tr>
            <th>CMS models supported</th>
            <td data-label="BCDA">
                <ul>
                    <li>Medicare Shared Savings Program (SSP)</li>
                    <li>ACO REACH</li>
                    <li>Kidney Care Choices (KCC)</li>
                </ul>
            </td>
            <td data-label="CCLF">
                <ul>
                    <li>Medicare Shared Savings Program (SSP)</li>
                    <li>ACO REACH</li>
                    <li>Kidney Care Choices (KCC)</li>
                    <li>Vermont All-Payer</li>
                    <li>Primary Care First</li>
                </ul>
            </td>
        </tr>
        <tr>
            <th>Data fields</th>
            <td data-label="BCDA">
                <ul>
                    <li>ExplanationOfBenefit.Status supports 2 values ("active" or "canceled").</li> 
                    <li>There are some FHIR-format metadata fields which don’t exist in CCLF files*.</li>
                </ul>
            </td>
            <td data-label="CCLF">
                <ul>
                    <li>CLM_ADJSMT_TYPE_CD supports 3 numeric values (0=original, 1=cancellation, or 2=adjustment). </li>
                    <li>There are internal identifiers (e.g., claims processing, payment, auditing) which don’t exist in BCDA data*.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <th>Historical data provided on<br> newly attributed enrollees</th>
            <td data-label="BCDA">
                <ul>
                    <li>SSP: all historical data available as far back as 2014</li>
                    <li>KCC: 24 months of historical data from the start of the current performance year</li>
                    <li>ACO REACH: 36 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
            <td data-label="CCLF">
                <ul>
                    <li>SSP: 36 months prior to agreement start date</li>
                    <li>KCC and ACO REACH: 36 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
        </tr>
        <tr>
            <th>Update frequency</th>
            <td data-label="BCDA">
                <ul>
                    <li>Adjudicated claims: weekly</li>
                    <li>Partially adjudicated claims: daily</li>
                </ul>
            </td>
            <td data-label="CCLF">Adjudicated claims: monthly</td>
        </tr>
    </tbody>
</table>

*[Review all unmapped data fields between BCDA and CCLF files {% include sprite.html icon="file_download" class="text-middle" %}]({{ '/assets/downloads/unmapped-fields-between-cclf-and-bcda.xlsx' | relative_url }})

## What are the differences between the data sources?

CCLF files get data from IDR monthly once its financial reports are complete. BCDA gets adjudicated claims data from CCW every weekend and partially adjudicated claims data from FISS and MCS daily. BCDA combines CCW data with IDR’s alignment data (e.g., suppression assumption, data sharing preferences included) to create claims extracts similar to those in CCLF files.

Since CCW and IDR refresh their data at different rates, there are sometimes minor data discrepancies. Additionally, while they use the same source system, IDR and CCW modify their data elements differently. For example, IDR has expanded data elements for enterprise functioning, while CCW has data structures and fields better suited for research. 

## Which data source is right for me?
Each data source has unique advantages. BCDA updates data faster, resulting in earlier notice of the claims submitted. This lets you act quickly when proactive interventions or changes to your enrollees’ care plans are needed. Additionally, the FHIR format makes it easier to bring claims data into existing data models.

CCLF files are more widely accessible. It’s available to more model entities and its files can be downloaded directly from your model-specific portal. 

## Can I use both data sources?

Yes, using both data sources provides many benefits:

- **Ensure data accuracy:** Compare and cross-reference both sources to access a wider variety of historical data and identify any discrepancies. 
- **Understand utilization patterns, health outcomes, and cost trends:** Combine CCLF files' enrollment data (e.g., start and end dates, coverage type, demographic details) with BCDA data. This can support population health management, risk stratification, and targeted intervention strategies.
- **Evaluate care coordination and payment processes:** Combine BCDA’s insurance coverage details with CCLF Files' payment data. This can evaluate the coordination of benefits between Medicare and other insurers, assess the financial impact on all parties, and identify primary or secondary payers.