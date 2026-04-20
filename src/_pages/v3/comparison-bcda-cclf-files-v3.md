---
layout: api-docs-v3
page_title: "Comparison of BCDA v3 and CCLF Files"
seo_title: ""
description: ""
in-page-nav: true
---

# {{ page.page_title }}

Beneficiary Claims Data API (BCDA) and [Claim and Claim Line Feed (CCLF)](https://www.cms.gov/files/document/cclf-information-packet.pdf) files both offer Medicare Parts A, B, and D claims data. While the data sources overlap, there are some differences including their formatting and the frequency with which they make data available.

## Overview of similarities and differences

BCDA and CCLF files differ in how and when Medicare claims data is made available.

### BCDA: frequent access and standardization

As an API, BCDA lets you automate data requests and streamline workflows for more efficient, secure processes. The API uses Fast Healthcare Interoperability Resources ([FHIR](https://www.hl7.org/fhir/)) standards. It also supports frequent and early access to Medicare enrollees' claims data. This includes access to claims that would otherwise be unavailable during processing ("adjudication"). Earlier access to claims helps your organization build near real-time workflows and coordinate care for your patients.

FHIR breaks claims data into discrete blocks of recognizable data called `Resources`. These use information categories such as Patient, Explanation of Benefit, and Coverage to organize files, which make them easy to share and interpret. BCDA uses the [CMS recommended Bulk FHIR Standards](https://www.cms.gov/priorities/key-initiatives/burden-reduction/interoperability/implementation-guides-and-standards/standards-and-igs-index-and-resources) to export larger amounts of data across systems and populations.

### CCLF: ease of access and direct delivery

CCLF files provide adjudicated claims data delivered on a regular cadence, which may be useful for organizations with established file-based workflows or analyses that depend on fields unavailable in BCDA. You can download CCLF files directly from your model-specific portal.

## Who can use BCDA and CCLF files?

BCDA and CCLF claims data are available to organizations participating in some [Alternative Payment Models](https://www.cms.gov/priorities/innovation/key-concepts/alternative-payment-models-apms). These are programs that reward health care providers for high-quality, coordinated care. BCDA and CCLF files are currently available to organizations in these models:

- Medicare Shared Savings Program
- Realizing Equity, Access, and Community Health (ACO REACH)
- Kidney Care Choices (KCC)
- Increasing Organ Transplant Access (IOTA)

## Differences in access, format, content, and timing

{% assign unique = 1 %}
<table class="usa-table usa-table--stacked usa-table--borderless margin-bottom-0">
    <thead>
        <tr>
            <th scope="col" id="col-bcda-{{unique}}">BCDA</th>
            <th scope="col" id="col-cclf-{{unique}}">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2" id="colgroup-{{unique}}">Access method</th>
        </tr>
        <tr>
            <td headers="col-bcda-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Programmatically using API requests</td>
            <td headers="col-cclf-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Manually using portals or programmatically using API requests or Command Line Interface</td>
        </tr>
    </tbody>
</table>

{% assign unique = 2 %}
<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col" id="col-bcda-{{unique}}">BCDA</th>
            <th scope="col" id="col-cclf-{{unique}}">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2" id="colgroup-{{unique}}">Claims data format</th>
        </tr>
        <tr>
            <td headers="col-bcda-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Interoperable and machine-readable, using <a href="https://hl7.org/fhir/R4/">FHIR R4</a>.</td>
            <td headers="col-cclf-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">Human-readable, using <a href="https://www.cms.gov/files/document/cclf-information-packet.pdf">fixed-width tabular files</a>.</td>
        </tr>
    </tbody>
</table>

{% assign unique = 3 %}
<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col" id="col-bcda-{{unique}}">BCDA</th>
            <th scope="col" id="col-cclf-{{unique}}">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2" id="colgroup-{{unique}}">Claims data source</th>
        </tr>
        <tr>
            <td headers="col-bcda-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">National Claims History and CMS Shared Systems data from the Integrated Data Repository (IDR)</td>
            <td headers="col-cclf-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">National Claims History data from the Integrated Data Repository (IDR)</td>
        </tr>
    </tbody>
</table>

{% assign unique = 4 %}
<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col" id="col-bcda-{{unique}}">BCDA</th>
            <th scope="col" id="col-cclf-{{unique}}">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2" id="colgroup-{{unique}}">Historical data provided on newly attributed enrollees</th>
        </tr>
        <tr>
            <td headers="col-bcda-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                  <li>Shared Savings Program: all historical data available as far back as 2014</li>
                  <li>ACO REACH: 36 months of historical data from the start of the current performance year</li>
                  <li>KCC: 24 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
            <td headers="col-cclf-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                  <li>Shared Savings Program: 36 months prior to agreement start date</li>
                  <li>ACO REACH: 36 months of historical data from the start of the current performance year</li>
                  <li>KCC: 36 months of historical data from the start of the current performance year</li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

{% assign unique = 5 %}
<table class="usa-table usa-table--stacked usa-table--borderless margin-y-0">
    <thead class="usa-sr-only">
        <tr>
            <th scope="col" id="col-bcda-{{unique}}">BCDA</th>
            <th scope="col" id="col-cclf-{{unique}}">CCLF</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="colgroup" colspan="2" id="colgroup-{{unique}}">Update frequency</th>
        </tr>
        <tr>
            <td headers="col-bcda-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                  <li>Adjudicated claims (Medicare Part A and Part B): weekly</li>
                  <li>Adjudicated claims (Medicare Part D): 6x/week</li>
                  <li>Partially adjudicated claims: 4 to 5x/week</li>
                </ul>
            </td>
            <td headers="col-cclf-{{unique}} colgroup-{{unique}}" style="vertical-align: baseline; padding: 1rem; width:50%; border-bottom:0;">
                <ul style="margin: 0; padding-left: 1rem;">
                  <li>Adjudicated claims: monthly</li>
                  <li>Adjudicated claim extracts: weekly<sup><a href="#fn1">*</a></sup></li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

<ul>
  <li id="fn1" style="scroll-margin-top: 6.25rem;">CCLF Self-Service is only available to ACOs in the Medicare Shared Savings Program. Visit the <a href="https://acoms.cms.gov/knowledge-management/view/8321">ACO-MS Knowledge Library</a> to learn more about CCLF Self-Service.</li>
</ul>

## Which data source is right for me?

Both sources support model entities' use cases, and can even be used together. When choosing between them, consider the frequency, source, and level of automation most suited to your needs. You can also consider your organization's existing healthcare analytics and actuarial tools. A benefit of BCDA is its conformance with FHIR standards. This saves time and money on integrations with EHRs and off-the-shelf FHIR data clients.

BCDA aligns with CCLF partly by using shared claim identifiers. This alignment makes it easy to use both CCLF files and BCDA's standards-based format.

### Can I use both CCLF and BCDA as sources of Medicare claims data?

Yes. Using both data sources provides many benefits:

- Ensure data accuracy: Compare and cross-reference both sources to access a wider variety of historical data and identify any discrepancies.
- Evaluate care coordination and payment processes: Combine BCDA's insurance coverage details with CCLF files' payment data. This can evaluate the coordination of benefits between Medicare and other insurers, assess the financial impact on all parties, and identify primary or secondary payers.

## How soon will I receive claims data from BCDA v3 and CCLF files?

Depending on the model your organization participates in, claims data can be available:

- 2-4 days after the claim is **submitted to CMS** via BCDA v3                              
- 1-7 days after the claim is **adjudicated by CMS** via CCLF   

The following diagram illustrates these differences while providing more detail about the claims process.

<figure class="width-full margin-y-4 margin-x-0" style="border: 1px solid #f0f0f0; border-radius: 4px; overflow:hidden; padding: 12px;">
  <img
    src="{{ '/assets/img/bcda-vs-cclf.svg' | relative_url }}"
    alt="Partially adjudicated claims processing flow diagram."
    class="width-full"
  >
  <figcaption class="usa-sr-only">
  </figcaption>
</figure>

## Which data fields in BCDA v3 are not available from CCLF files?

The BCDA v3 Data Dictionary contains a comprehensive list of all data fields available in BCDA v3 and includes a mapping to the equivalent or related CCLF file and element.

<p>For an exhaustive list of fields available only in BCDA v3, look for rows where the <code class="language-plaintext highlighter-rouge">cclfMapping</code> column is blank in the "Data Dictionary" worksheet in the <a href="{{ '/assets/downloads/BCDA_v3_Data_Dictionary.xlsx' | relative_url }}" data-tealium="download">BCDA v3 Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a>.</p>

## Which data fields in CCLF files are not available from BCDA v3?

The majority of data elements found in CCLF files are also available from BCDA v3. There are some elements not available from BCDA v3 including:

- Legacy HICN identifiers
- Certain beneficiary demographic information
- CCLF metadata
- Data fields from inactive programs

Review the "CCLF fields absent from BCDA v3" worksheet in the BCDA v3 Data Dictionary for a comprehensive list of fields found in CCLF files which are unavailable in BCDA v3.
