---
layout: api-docs-v3
page_title: "Introducing BCDA v3"
seo_title: ""
description: "Explore the improvements in BCDA v3, including unified data sources, faster updates, and better FHIR conformance."
in-page-nav: true
feedback_id: "1dd96929"
---

# {{ page.page_title }} <span class="usa-tag usa-tag--big margin-x-1 bg-accent-warm text-middle">New</span>

BCDA version 3 (v3) delivers faster, more reliable access to Medicare claims data with significant improvements for users. These improvements include:

- Moving to a single source of Medicare claims data, the CMS Integrated Data Repository (IDR) 
- Better alignment with other sources such as Claim and Claim Line Feed (CCLF) files

## BCDA v3 improvements

### More frequent and timely updates 

Version 3 offers more timely updates to patient, coverage, and adjudicated claims data. In addition, it:

- Reduces the number of days between the time a claim is fully adjudicated and when it’s made available 
- Increases the frequency of updates to patient and coverage information from once per week to 6 times per week
- Increases the frequency of updates to fully adjudicated Part D claims data from once per week to 5 times per week

### Easier claims tracking 

BCDA v3 makes it easier to track claims through the adjudication process.

- Both adjudicated and partially adjudicated claims are now sourced from a single source system, the IDR
- Both claims now use the same ExplanationOfBenefit FHIR resource

Version 3 enhances tracking by using the claim control number and a simple metadata tag to indicate the adjudication status of the claim.

### Enhanced filtering capabilities

The new [\_typeFilter query parameter](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#_typefilter-experimental-query-parameter) will provide new options to meet needs of complex data workflows. These include filtering BCDA job requests based on resource metadata.

### Simplified, reliable data mapping capabilities 

Data from BCDA will be more closely aligned with data available in CCLF files. Additionally the <a href="{{ '/assets/downloads/BCDA_v3_Data_Dictionary.xlsx' | relative_url }}" data-tealium="download">BCDA v3 Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a> will be automatically derived from upstream data sources.

### Improved conformance with select FHIR Implementation Guides

V3 standardizes and enhances extensions while providing improved conformance with FHIR standards. BCDA v3 continues to follow the [Bulk Data Access IG (STU 2)](https://hl7.org/fhir/uv/bulkdata/STU2/) and BCDA v3's FHIR resources conform with [CARIN Blue Button IG version 2.1.0](https://hl7.org/fhir/us/carin-bb/STU2.1/). Additionally, BCDA v3 retires [Blue Button Resources](https://bluebutton.cms.gov/resources/) to represent extensions and CodeSystems. Instead these will be represented using `StructureDefinition` and `CodeSystem` resources.

## Problems solved in v3

In earlier versions of BCDA, claims data was sourced from the Chronic Conditions Warehouse (CCW). BCDA v2 sourced partially adjudicated claims data from the Replicated Data Access (RDA) API. With v3, the CMS Integrated Data Repository (IDR) replaces both CCW and RDA API. BCDA's switch to sourcing data from IDR addresses the following known issues and limitations of BCDA v2:

- Reduces mismatched data between BCDA resources and CCLF files
- Resolves missing data for newly attributed enrollees 
- Fixes issues for enrollees assigned more than one BENE_ID
- Simplifies linking between partially and fully adjudicated claims
- Uses consistent claim identifiers across all phases of adjudication

### Comparison of claims flows in v1/v2 versus v3

<figure class="width-full margin-y-4 margin-x-0">
  <img
    src="{{ '/assets/img/comparison-claims-flow.svg' | relative_url }}"
    alt="Partially adjudicated claims processing flow diagram."
    class="width-full desktop:padding-x-15 padding-x-8"
    
  >
  <figcaption class="usa-sr-only">
    <ol>
      <li>CMS receives the claim and two separate flows appear for partially versus fully adjudicated claims.</li>
      <li>In v1/v2, fully adjudicated claims route though CCW while partially adjudicated claims route through RDA.</li>
      <li>In v3, all claims route though the IDR.</li>
      <li>Next, all claims route through BFD. This is true of all versions and all types of claims.</li>
      <li>Finally, all claims are available through BCDA.</li>
    </ol>
  </figcaption>
</figure>

## What this means for your organization

- Reduced development time: Unified data structure simplifies integration
- Improved data quality: Single source eliminates inconsistencies
- Better user experience: Faster, more frequent updates
- Enhanced compliance: Better alignment with FHIR standards

### Ready to get started?

#### Next Steps:

- Review the [How to Migrate to v3]({{ '/v3/api-documentation/how-to-migrate-v3.html' | relative_url }}) for step-by-step implementation instructions
- Access BCDA's [API documentation]({{ '/api-documentation.html' | relative_url }}) to view the technical specifications and API details
- Participate in the Office Hours to get personalized support

Questions? Contact our team at <a href="mailto:bcapi@cms.hhs.gov">bcapi@cms.hhs.gov</a> for assistance with your v3 transition. 
