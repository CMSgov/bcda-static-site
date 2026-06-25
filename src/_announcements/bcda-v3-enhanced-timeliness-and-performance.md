---
layout: announcement
page_title: "BCDA v3: Enhanced timeliness and performance for value-based care"
description: "Core improvements to data sources and alignment mean timelier, more person-centered care.    "
show-side-nav: false
in-page-nav: true
lead_paragraph: "Core improvements to data sources and alignment mean timelier, more person-centered care."
published_date: 2026-07-01
---

Centers for Medicare & Medicaid Services (CMS) is excited to announce version 3 (v3) of its [FHIR](http://hl7.org/fhir/) Medicare claims data sharing platform. v3 drives improvements to CMS Beneficiary Claims Data API (BCDA), [Blue Button API](https://bluebutton.cms.gov/), and [Claims Data to Part D Sponsors API (AB2D)](https://ab2d.cms.gov/). [BCDA v3](/v3/introducing-v3.html) helps model entities coordinate care more effectively, track performance on CMS quality measures, and improve patient outcomes.

## BCDA v3 improvements

With BCDA v3, model entities get patient claims data earlier, allowing them to identify issues and intervene sooner. v3 strengthens alignment with Fast Healthcare Interoperability Resources (FHIR) standards and other CMS data sources, reducing time and money spent on integrations and reconciliation. Driving these improvements are:

- A new, single source of Medicare claims data   
- Better alignment with sources such as Claim and Claim Line Feed (CCLF) files

These fundamental changes improve data frequency, tracking, filtering, mapping, and FHIR conformance.

### Timelier, more frequent updates

v3 offers timelier updates to patient and coverage data, meaning:

- Shorter time between full processing (adjudication) and data availability   
- Increased frequency of updates to patient and coverage information

### Easier claims tracking

BCDA v3 makes it easier to track claims through the adjudication cycle. It uses one FHIR resource instead of 3 to represent fully and partially processed versions of a claim. v3 also simplifies the way BCDA denotes claims status.

### Enhanced filtering capabilities

The new [_typeFilter query parameter]({{ '/v3/filter-claims-data-v3.html#the-typefilter-parameter' | relative_url }}) provides additional options for complex data workflows.

### Improved conformance with select FHIR Implementation Guides

v3 standardizes extensions while providing better FHIR conformance. CodeSystems are represented using `StructureDefinition` and `CodeSystem` resources.

### Simplified, reliable data mapping

BCDA v3 data aligns more closely with CCLF files, and generates its Data Dictionary automatically. 

## The IDR: a single source of claims data

v3 consolidates upstream data to a single data source, the Integrated Data Repository (IDR). This change:

- Reduces mismatches between BCDA resources and CCLF files  
- Resolves missing data for newly attributed enrollees  
- Fixes issues for enrollees assigned more than one `BENE_ID`  
- Simplifies linking between partially and fully adjudicated claims  
- Uses consistent claim identifiers across all adjudication phases

## What this means for healthcare organizations

Through a unified data structure and consolidated data sources, BCDA v3 can reduce development time, improve data quality, and ensure providers have up-to-date information about every Medicare patient. 

## What this means for current users

The v1 and v2 endpoints will be disabled in 2027 on a date to be announced. Refer to the [v3 Migration Guide]({{ '/v3/how-to-migrate-v3/' | relative_url }}) for steps and support on upgrading to v3. 