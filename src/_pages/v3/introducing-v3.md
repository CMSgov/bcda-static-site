---
layout: api-docs-v3
page_title: "Introducing BCDA v3"
seo_title: ""
description: "Introducing BCDA v3"
in-page-nav: true
in-page-nav-levels: "h2"
feedback_id: ""
---

# {{ page.page_title }}

In version 3 (v3), BCDA is introducing a more timely, efficient, and granular approach to accessing BCDA data. These improvements, which benefit BCDA users, include:

- Moving to a single source of Medicare claims data, the CMS Integrated Data Repository (IDR) 
- Better alignment with other sources such as Claim and Claim Line Feed (CCLF) files

## BCDA v3 improvements

### More frequent and timely updates 

Version 3 offers more timely updates to patient, coverage, and adjudicated claims data. In addition, it:

- Reduces the number of days between the time a claim is fully adjudicated and when it’s made available 
- Increases the frequency of adjudicated data from once per week to 4 or 5 times per week

### Easier claims tracking 

BCDA v3 makes it easier to track claims through the adjudication process.

- Both adjudicated and partially adjudicated claims are now derived from the same source system
- Both types are represented by a single ExplanationOfBenefit FHIR resource

Version 3 enables enhanced tracking by using the claim control number and identifying adjudication status with additional metadata.

### Enhanced filtering capabilities

The new [\_typeFilter query parameter](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#_typefilter-experimental-query-parameter) will provide new options to meet needs of complex data workflows. These include filtering BCDA job requests based on resource metadata.

### Simplified, reliable data mapping capabilities 

Data from BCDA will be more closely aligned with data available in CCLF files. Additionally the BCDA Data Dictionary will be automatically derived from upstream data. sources.

### Improved conformance with select FHIR Implementation Guides

V3 standardizes and enhances extensions while providing improved conformance with FHIR standards. BCDA v3 continues to follow the [Bulk Data Access IG (STU 2)](https://hl7.org/fhir/uv/bulkdata/STU2/) and BCDA v3's FHIR resources conform with [CARIN Blue Button IG version 2.1.0](https://hl7.org/fhir/us/carin-bb/STU2.1/). Additionally, BCDA v3 retires [Blue Button Resources](http://bluebutton.cms.gov/resources/) to represent extensions and CodeSystems. Instead these will be represented using `StructureDefinition` and `CodeSystem` resources.

## Problems solved in v3

In earlier versions of BCDA, claims data was sourced from the Chronic Conditions Warehouse (CCW). CCW was originally intended for research and condition-specific tracking. BCDA v2 sourced partially adjudicated claims data from the Replicated Data Access (RDA) API. With v3, the CMS Integrated Data Repository (IDR) replaces both CCW and RDA API as data sources. This data is less expensive for CMS to host and maintain, easier to manage, and more timely. BCDA's switch to sourcing data from IDR in addresses following known issues and limitations of BCDA v2:

- Mismatched data between BCDA resources  and CCLF files is reduced by sharing the IDR as an upstream data provider
- BCDA missing data for newly attributed enrollees due to a known issue with CCW
- BCDA missing data for enrollees assigned more than one CCW identifier (BENE_ID)
- Difficulty linking between partially adjudicated and fully adjudicated claims due to different FHIR resource representation and claim identifiers

### More v3 resources

Explore the v3 migration guide and documentation for hands-on information about implementing and troubleshooting BCDA v3. 