---
layout: support
page_title: "Frequently Asked Questions"
seo_title: ""
description: "Frequently asked questions about BCDA."
in-page-nav: true
---

# {{ page.page_title }}

## About the API

### Who is eligible to use Beneficiary Claims Data API (BCDA)?

BCDA supports organizations (entities) participating in the following CMS [alternative payment models](https://www.cms.gov/priorities/innovation/about/alternative-payment-models){:target="_blank" rel="noopener"}:

- [ACCESS (Advancing Chronic Care with Effective, Scalable Solutions)](https://www.cms.gov/priorities/innovation/innovation-models/access){:target="_blank" rel="noopener"}
- [ACO REACH (Accountable Care Organization Realizing Equity, Access, and Community Health)](https://www.cms.gov/priorities/innovation/innovation-models/aco-reach){:target="_blank" rel="noopener"}
- [GUIDE (Guiding an Improved Dementia Experience)](https://www.cms.gov/priorities/innovation/innovation-models/guide){:target="_blank" rel="noopener"}
- [IOTA (Increasing Organ Transplant Access)](https://www.cms.gov/priorities/innovation/innovation-models/iota){:target="_blank" rel="noopener"}
- [KCC (Kidney Care Choices)](https://www.cms.gov/priorities/innovation/innovation-models/kidney-care-choices-kcc-model){:target="_blank" rel="noopener"}
- [SSP (Shared Savings Program)](https://www.cms.gov/medicare/payment/fee-for-service-providers/shared-savings-program-ssp-acos){:target="_blank" rel="noopener"}

### When do terminated and discontinued model entities lose API access?

Terminated and discontinued organizations lose access to the API, including runouts data, the same day their participation in the model ends.

### What's the difference between BCDA and CCLF files?

CCLF files are automatically available monthly using 12 flat files, and can be downloaded weekly upon request.

BCDA updates adjudicated claims weekly and partially adjudicated claims 4x/week using 3 NDJSON files (Coverage, Patient, ExplanationOfBenefit).

Additionally, BCDA is an API that uses the [Bulk Fast Healthcare Interoperability Resources (FHIR)](https://hl7.org/fhir/uv/bulkdata/){:target="_blank" rel="noopener noreferrer"} format, as required by CMS. [Learn more about the differences]({{ '/bcda-data/comparison-bcda-cclf-files.html' | relative_url }}).

### What's the difference between BCDA v2 and v3?

BCDA v3 introduces a number of improvements, including:

- More frequent and timely updates
- Easier claims tracking
- Enhanced filtering capabilities
- Simplified, reliable data mapping capabilities
- Improved conformance with select FHIR Implementation Guides
- Simplified linking between partially and fully adjudicated claims
- Uses consistent claim identifiers across all phases of adjudication

We’ve also corrected issues some users encountered with v1 and v2 such as:

- Mismatched data between BCDA resources and CCLF files
- Missing data for newly attributed enrollees
- Issues for enrollees assigned more than one BENE_ID

You can learn more about v3 improvements and problems solved at [Introducing BCDA v3]({{ '/about/introducing-v3.html' | relative_url }}).

## Compliance and restrictions
{: .margin-bottom-2}

### How do I redact PHI and PII when sharing information?

Completely cover or label [Personally Identifiable Information (PII)](https://www.hhs.gov/answers/hhs-administrative/what-is-pii/index.html) and [Protected Health Information (PHI)](https://www.hhs.gov/answers/hipaa/what-is-phi/index.html) as “REDACTED” in emails, screenshots, and documents. Ensure any masks are 100% opaque and in a format that supports layers.

Examples of PII and PHI:

- Medicare Beneficiary Identifier (MBI)
- Taxpayer Identification Number (TIN)
- National Provider Identifier (NPI)
- Social Security Number (SSN)
- API keys or access credentials (e.g., client ID and secret)
- authorization or bearer tokens

PII and PHI are often found in API requests or response payloads referenced in:

- the text of your Google Group posts or emails
- files attached to your Google Group posts or emails (e.g., XMLs, JSONs)
- screenshots attached to your Google Group posts or emails

Example of a redacted response:

{% capture curlSnippet %}{% raw %}
{
    "taxpayerIdentificationNumber": "REDACTED",
    "nationalProviderIdentifier": "REDACTED"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" %}

### Can I use 3rd party web-based REST clients or tools?

Use caution with 3rd party web-based clients. By sharing your credentials, you may be allowing them to make REST calls on your behalf. This is a serious data privacy and security risk. We recommend using secure REST client tools.

## Claims processing timeline

### How long does it take BCDA to receive a claim after it is submitted?

It typically takes 2-4 days after submission for BCDA to receive [partially adjudicated claims data]({{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}) and up to 7 days for adjudicated claims data. Even after adjudication, claims may go through additional processing. BCDA will continue to provide the latest updates available for each claim.

According to Section 6404 of the Affordable Care Act, Original Medicare claims must be submitted within 12 months (1 calendar year) of the date of service.

### Where does the data come from?

BCDA v3 sources data from CMS's Integrated Data Repository (IDR).

For earlier versions of BCDA, adjudicated claims data is loaded from the [Chronic Conditions Data Warehouse (CCW)](https://www2.ccwdata.org/web/guest/home/){:target="_blank" rel="noopener noreferrer"}. Partially adjudicated claims data is loaded from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS).

### How often is data refreshed?

The following table shows how frequently Medicare claims data is refreshed and potentially available to eligible organizations.

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-2">
  <thead>
    <tr>
      <th scope="col">FHIR Resource</th>
      <th scope="col">BCDA v3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Patient</th>
      <td>6x/week, Sunday to Friday</td>
    </tr>
    <tr>
      <th scope="row">Coverage</th>
      <td>6x/week, Sunday to Friday</td>
    </tr>
    <tr>
      <th scope="row">ExplanationOfBenefit - Part A/B (National Claims History)</th>
      <td>Weekly, on Monday<sup><a href="#refresh-fn1">1</a></sup></td>
    </tr>
    <tr>
      <th scope="row">ExplanationOfBenefit - Part D</th>
      <td>5x/week, Sunday to Thursday</td>
    </tr>
    <tr>
      <th scope="row">ExplanationOfBenefit - Part A/B (Shared Systems)</th>
      <td>4x/week, Sunday and Tuesday to Thursday</td>
    </tr>
  </tbody>
</table>

<sup>1</sup> Data is loaded on the Monday after it's loaded into the source system, 0-7 days from processing or "adjudication."
{: #refresh-fn1 .font-body-2xs style="scroll-margin-top: 6.25rem;"}

To stay up to date with the latest claims data for your enrollees, we recommend exporting data from National Claims History once per week, and daily for all other sources. Use the [_since parameter]({{ '/api-documentation/filter-claims-data.html#the-_since-parameter' | relative_url }}) when running jobs to avoid downloading duplicate data.

## Troubleshooting

### Why do I get connection timeout issues with my production credentials?

BCDA requires that all production requests come from a registered IP address. Make sure the IP addresses you're using to request data have been added to the Allow List in your model-specific system. Visit [Production Access]({{ '/production-access.html' | relative_url }}) for more details.

### Why am I getting a 429 error response?

A status code of 429 indicates “Too Many Requests.” Wait until the period of time specified in the header has passed before making more requests.

This makes sure your client can adapt without manual intervention, even if the rate-limiting parameters change. [Learn more about the 429 status code.]({{ '/api-documentation/access-claims-data.html' | relative_url }}#response-example-too-many-requests)
