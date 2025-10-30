---
layout: api-docs-v3
page_title: "How to Migrate to BCDA v3"
seo_title: ""
description: "How to Migrate to BCDA v3"
in-page-nav: true
in-page-nav-levels: "h2"
feedback_id: ""
---

# {{ page.page_title }}

## BCDA v3 overview

BCDA version 3 (v3) introduces access to more timely and accurate Medicare claims data, and additional benefits to BCDA users including:

- Reduced discrepancies between partially and fully adjudicated Medicare claims data. This is accomplished by moving to a single source of claims data, the CMS Integrated Data Repository (IDR).
- Improved alignment with sources such as Claim and Claim Line Feed (CCLF) files through more standard claim and patient identifiers. 

### Changes to BCDA in v3

If you are currently using BCDA v1 or BCDA v2, there are changes to the API and FHIR Resources you need to be aware of in v3:

- There is a new v3 endpoint: `https://api.bcda.cms.gov/api/v3/`
- Partially adjudicated claims<sup>1</sup> will be represented as `ExplanationOfBenefit` (EOB) FHIR resources in v3, instead of `Claim`/`ClaimResponse` in v2
- There will be new Extension and Code System URLs to reference
- Resource IDs are different between versions

<sup>1</sup>Medical claims that have been submitted but not fully processed and paid by Medicare

## Requesting data from new v3 endpoints

*Point your app to v3 instead of v2*

BCDA v3 will be located at the same domain as v1 and v2, but will have a new v3 $export and new metadata endpoints. BCDA v3 will still support the [Bulk Data FHIR Implementation Guide](https://github.com/HL7/bulk-data). If you are currently connected to BCDA v1 or v2 endpoints, you can migrate to BCDA v3 by making the following changes.

Point your app to **v3** instead of **v2** to connect to the new endpoint, complete the steps to export the data, check the job status, read the JSON manifest, and download the files.

- v2 Patient $export operation: 
	{% include copy_snippet.html code="https://api.bcda.cms.gov/api/v2/Group/all/$export" language="bash" %}

- v3 Patient $export operation: 
	{% include copy_snippet.html code="https://api.bcda.cms.gov/api/v3/Group/all/$export" language="bash" %}

The /auth and /data URLs will remain the same between versions. You won't need to make any changes to how you request a token or download files.

## Changes to partially adjudicated claims representation

In BCDA v2, fully adjudicated claims were represented by the `ExplanationOfBenefit` FHIR resource while partially adjudicated claims were represented by the `Claim` and `ClaimResponse` resources. BCDA v3 will represent **ALL** claims (fully adjudicated and partially adjudicated) using the `ExplanationOfBenefit` resource. All EOB resources in v3 will have a `meta.tag` element indicating either `Adjudicated` or `PartiallyAdjudicated`.

### Mapping Partially Adjudicated Claims data in v2 vs v3

V3 uses a different resource to access partially adjudicated claims: 

- v2: `Claim`/`ClaimResponse` resource
- v3: `ExplanationOfBenefit` resource 

Using only the `ExplanationOfBenefit` resource allows you to easily compare a claim at different stages in the adjudication process without needing to map between different resource types.

Review the v3 Data Dictionary for a complete list of element definitions and CCLF mappings.

### Exporting claims based on adjudication status

If you have access to partially adjudicated claims, you’ll need to use the new, `_typeFilter` parameter to filter exported claims based on adjudication status in BCDA v3. 

#### How it worked in BCDA v2

In BCDA v2 you exported claims based on adjudication level using the `_type` parameter, and passing the appropriate resource types (`Claim`, `ClaimResponse` for partially adjudicated claims and `ExplanationOfBenefit` for fully adjudicated claims) as the parameter value:

- v2 $export for only partially adjudicated claims:
  {% include copy_snippet.html code="https://api.bcda.cms.gov/api/v2/Patient/$export?_type=Claim,ClaimResponse" language="bash" %}

- v2 $export for only fully adjudicated claims:
	{% include copy_snippet.html code="https://api.bcda.cms.gov/api/v2/Patient/$export?_type=ExplanationOfBenefit" language="bash" %}

#### Changes with BCDA v3

In BCDA v3, you can export claims based on adjudication level using the `_typeFilter` parameter to limit your job request to include only EOB resources where the meta.tag property matches the desired adjudication status. In the following examples, we further limit the request to exclude Coverage and Patient resources by using the `_type` parameter with `ExplanationOfBenefit`.

- v3 $export for only partially adjudicated claims
	{% include copy_snippet.html code="https://api.bcda.cms.gov/api/v3/Patient/$export?_type=ExplanationOfBenefit&_typeFilter=ExplanationOfBenefit?_tag=PartiallyAdjudicated" language="bash" %}

- v3 $export for only fully adjudicated claims
	{% include copy_snippet.html code="https://api.bcda.cms.gov/api/v3/Patient/$export?_type=ExplanationOfBenefit&_typeFilter=ExplanationOfBenefit?_tag=Adjudicated " language="bash" %}

Without using the `_typeFilter` parameter, REACH ACOs using v3 will receive both partially adjudicated and fully adjudicated claims in the export by default. 

## New extension and code system URLs

BCDA v3 utilizes the `StructureDefinition` and `CodeSystem` FHIR resources. This is the standard way to represent these URLs, and will make it easier for implementers to access the metadata going forward. You can access the metadata for each Extension and CodeSystem by hitting the URL, which will return a `StructureDefinition` or `CodeSystem` FHIR resource.

### URLs changing between v2 and v3

Make the following changes to migrate to v3 if you’ve mapped any bluebutton extension or code system URLs:

#### Changes to Extension URLs

- v2 URL:
	{% include copy_snippet.html code="https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd/" language="bash" %}

- v3 URL:
	{% include copy_snippet.html code="https://bluebutton.cms.gov/fhir/StructureDefinition/CLM-NRLN-RIC-CD" language="bash" %}

#### Changes to CodeSystem URLs

- v2 URL:
	{% include copy_snippet.html code="https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd/" language="bash" %}

- v3 URL:
	{% include copy_snippet.html code="https://bluebutton.cms.gov/fhir/CodeSystem/CLM-NRLN-RIC-CD" language="bash" %}

If your BCDA client is using any of the v2 URLs, you’ll need to update your code to look for the v3 version.

## Different resource IDs between versions

In BCDA v3, the FHIR ID (`Patient.id`, `ExplanationOfBenefit.id`, `Coverage.id`) for a given resource will not match the v2 FHIR resource ID. Do not attempt to use the FHIR IDs to match resources between versions. 

**Example:**

If you receive the `Patient` resource from BCDA v3, do not look up an existing patient by expecting the v2 `Patient.id` to equal the v3 `Patient.id` value. These values will not match. They are a different set of identifiers. However, the range of v2 and v3 Patient IDs does overlap, so there are some IDs that represent a v2 Patient and v3 Patient. This would not mean they represent the same beneficiary in real life.  

Instead of matching on `Patient.id`, use the relevant CMS identifier (MBI), along with additional supporting resource info (patient demographics like name, date of birth, etc.). Similarly, `ExplanationOfBenefit.id` and Coverage.id will not match between v2 and v3. 

### Matching beneficiaries between v2 and v3

Because the v2 and v3 Patient IDs will not match, in order to match a v3 patient to a patient you already have in your database, the best way is to use the MBI and demographics. The MBI and demographics should match between versions of BCDA. 

To find the MBI in the FHIR Patient resource, look at the `Patient.identifiers` element for an identifier where the `Identifier.system` is `http://hl7.org/fhir/sid/us-mbi`. The `identifier.value` will be the MBI.

Example v3 `Patient.identifiers` element:

{% capture curlSnippet %}{% raw %}
{
  "identifier": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code": "MB"
          }
        ]
      },
      "system": "http://hl7.org/fhir/sid/us-mbi",
      "value": "1S00E00AA08",
      "period": {
        "start": "2018-01-24T00:00:00+00:00"
      }
    }
  ]
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" can_copy=true %}

It is always good practice to have some kind of validation based on patient demographics, like supplementing the MBI exact match with some subset of name, date of birth, and gender matching.

Once you have matched an existing `Patient`, or created a new one, it is ok to store the BCDA v3 `Patient.id`. It is possible for two different MBIs to reference the same beneficiary, and therefore the same BCDA v3 `Patient`. If that happens, you will see multiple `Patient.identifiers` where the system is `http://hl7.org/fhir/sid/us-mbi`. This is rare, but you should be prepared for it to happen.

Example of v3 `Patient.identifiers` with two MBIs:

{% capture curlSnippet %}{% raw %}
{
  "identifier": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code": "MB"
          }
        ]
      },
      "system": "http://hl7.org/fhir/sid/us-mbi",
      "value": "1S00E00AA08",
      "period": {
        "start": "2022-04-05T00:00:00+00:00",
        "end": "2022-04-12T00:00:00+00:00"
      }
    },
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code": "MB"
          }
        ]
      },
      "system": "http://hl7.org/fhir/sid/us-mbi",
      "value": "1S00E00AE22",
      "period": {
        "start": "2022-04-12T00:00:00+00:00"
      }
    }
  ]
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" can_copy=true %}

### Matching claims between v2 and v3

Because the v3 `ExplanationOfBenefit` FHIR ID will not match the v2 `ExplanationOfBenefit` or `Claim`/`ClaimResponse` FHIR IDs, in order to match a v3 claim to a claim you already have in your database, the best way is to use the claim control number.

Because each version of a claim will have a unique claim ID, you should avoid using the unique claim ID to track a claim across versions, or even within a version across the adjudication journey. Instead, use the claim control number. It is the identifier where the system is [https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM](https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM).

Example `ExplanationOfBenefit.identifier` element:

{% capture curlSnippet %}{% raw %}
{
  "identifier": [
    {
      "type": {
        "coding": [
          {
            "system": "http://hl7.org/fhir/us/carin-bb/CodeSystem/C4BBIdentifierType",
            "code": "uc",
            "display": "Unique Claim ID"
          }
        ]
      },
      "value": "-9422919134190"
    },
    {
      "system": "https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM",
      "value": "05968201612271KJS"
    }
  ]
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" can_copy=true %}

FHIRPath for claim identifier: 

{% include copy_snippet.html code="ExplanationOfBenefit.identifier.where(system = 'https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM').value" language="ruby" can_copy=true %}
