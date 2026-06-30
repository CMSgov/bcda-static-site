---
layout: api-docs-v3
page_title: "How to Migrate to v3"
seo_title: "How to Migrate to BCDA v3 | CMS Beneficiary Claims Data API"
description: "Learn about new endpoints, FHIR resource consolidation, and updated URLs and IDs."
in-page-nav: true
feedback_id: "8a4c0b7b"
---

# {{ page.page_title }} <span class="usa-tag usa-tag--big margin-x-1 bg-accent-warm text-middle">New</span>

## Migration overview

This guide helps you migrate from BCDA v1/v2 to v3. Key changes include:

- New endpoint URL structure
- Unified ExplanationOfBenefit resource for all claims
- Updated extension and code system URLs
- Different resource IDs requiring new matching strategies

[More about v3]({{ '/v3/introducing-v3' | relative_url }})

### Changes to BCDA in v3

If you are currently using BCDA v1 or BCDA v2, there are changes to the API and FHIR Resources you need to be aware of in v3:

- There is a new v3 endpoint: `https://api.bcda.cms.gov/api/v3/`
- Partially adjudicated claims<sup>1</sup> will be represented as `ExplanationOfBenefit` (EOB) FHIR resources in v3, instead of `Claim`/`ClaimResponse` in v2
- There will be new Extension and Code System URLs to reference
- Resource IDs are different between versions

<p class="font-ui-xs text-italic"> <sup>1</sup>Medical claims that have been submitted but not fully processed and paid by Medicare.</p>

### v3 Data Dictionary 

<div class="grid-row grid-gap margin-y-4 flex-align-center">
  <div class="grid-col-12 mobile-lg:grid-col-auto">
    <img src="{{ '/assets/img/book.svg' | relative_url }}" alt="">
  </div>
  <div class="grid-col-fill tablet:grid-col-9">
      <p>Download the <a href="{{ '/assets/downloads/BCDA_v3_Data_Dictionary.xlsx' | relative_url }}" data-tealium="download">BCDA v3 Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a> to learn about:</p>
    <ul>
      <li>Updated information on resource type and claim field names</li>
      <li>Updated mappings between CCLF and BCDA data</li>
      <li>New data available in v3</li>
    </ul>
  </div>
</div>

## Requesting data from new v3 endpoints

### Point your app to v3 instead of v2

BCDA v3 will be located at the same domain as v1 and v2. However, it will have new endpoints for metadata requests and the Group and Patient $export operations. BCDA v3 will still support the [Bulk Data FHIR Implementation Guide](https://hl7.org/fhir/uv/bulkdata/STU2/). If you are currently connected to BCDA v1 or v2 endpoints, you can migrate to BCDA v3 by making the following changes.

Point your app to **v3** instead of **v2** to connect to the new endpoint, complete the steps to export the data, check the job status, read the JSON manifest, and download the files.

- v2 Patient $export operation: 
	{% include copy_snippet.html code="GET /api/v2/Group/all/$export" language="shell" %}

- v3 Patient $export operation: 
	{% include copy_snippet.html code="GET /api/v3/Group/all/$export" language="shell" %}

The /auth and /data URLs will remain the same between versions. You won't need to make any changes to how you request a token or download files.

## Changes to claims representation

In BCDA v3, claims data are still returned in FHIR R4 format, but there are changes to the Patient, Coverage, and ExplanationOfBenefit resources. These changes include:
 - Better conformity with C4BB 2.1.0 profiles
 - New StructureDefenition and CodeSystem URLs for CMS-specific extensions and terminologies
 - New data elements

Refer to the [v3 Data Dictionary]({{ '/v3/how-to-migrate-v3.html#v3-data-dictionary' | relative_url }}) for a list of v3 supported data elements.

### Changes to partially adjudicated claims
 
BCDA v2 represents fully adjudicated claims by the ExplanationOfBenefit FHIR resource and partially adjudicated claims by the Claim and ClaimResponse resources. 

BCDA v3 represents all claims (fully and partially adjudicated) with the ExplanationOfBenefit resource.

 - v2 - `Claim`/`ClaimResponse` resource
 - v3 - `ExplanationOfBenefit` resource 

This change in v3 lets you compare claims at different stages in the adjudication process without mapping between resource types.

### Exporting claims based on adjudication status with v3

If you make requests for `Claim` and/or `ClaimResponse` resources using the `_type` parameter in v2, you'll need to update those requests in v3.

#### How it works in v2

In BCDA v2 you exported claims based on adjudication status using the `_type` parameter, and passing the appropriate resource types (`Claim`, `ClaimResponse` for partially adjudicated claims and `ExplanationOfBenefit` for fully adjudicated claims) as the parameter value:

- v2 $export for only partially adjudicated claims:
  {% include copy_snippet.html code="GET /api/v2/Patient/$export?_type=Claim,ClaimResponse" language="shell" %}

- v2 $export for only fully adjudicated claims:
  {% include copy_snippet.html code="GET /api/v2/Patient/$export?_type=ExplanationOfBenefit" language="shell" %}

In v2, BCDA differentiates "partially adjudicated" from "fully adjudicated" claims based on the data source rather than the claim status. BCDA's partially adjudicated data (Claim and ClaimResponse resources) are populated with data from the Medicare Shared Systems which often includes data for claims that had been fully processed and paid.

#### How it works in v3

We've extended the API with the [`_typeFilter` parameter]({{ '/v3/filter-claims-data-v3.html#the-typefilter-parameter' | relative_url }}) to filter export data more granularly. Because all claims in v3 are represented by the same resource type (`ExplanationOfBenefit`), use this parameter to specify the System-Type _tag, recreating your v2 filtering logic.

Remember when using the _typeFilter parameter:
1. The _typeFilter parameter value must be URL-encoded
2. The _tag subquery parameter requires a token in the form `system|code`

{% capture sampleRequest %}{% raw %}
GET /api/v3/Patient/$export
  ?_type=
    ExplanationOfBenefit
  &_typeFilter=
    ExplanationOfBenefit%3F_tag%3Dhttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CSharedSystem
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=sampleRequest %}

**If you didn’t use the _type parameter in v2 requests,** you received all claims. 

In v3, specify all System-Type codes:
- SharedSystem
- NationalClaimsHistory
- DDPS

{% capture sampleRequest %}{% raw %}
GET /api/v3/Patient/$export?_type=ExplanationOfBenefit&_typeFilter=ExplanationOfBenefit%3F_tag%3Dhttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CSharedSystem%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CNationalClaimsHistory%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CDDPS
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=sampleRequest language="shell" %}

**If you used the _type parameter for `_type=Claim,ClaimResponse` in v2 requests,** you received SharedSystem claims only.

In v3, specify the SharedSystem System-Type code:
{% capture sampleRequest %}{% raw %}
GET /api/v3/Patient/$export?_type=ExplanationOfBenefit&_typeFilter=ExplanationOfBenefit%3F_tag%3Dhttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CSharedSystem%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CNationalClaimsHistory%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CDDPS
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=sampleRequest language="shell" %}

**If you used the _type parameter for `_type=ExplanationOfBenefit` for v2 requests,** you received NationalClaimsHistory claims and DDPS claims.

In v3, specify the NationalClaimsHistory and DDPS System-Type codes:
{% capture sampleRequest %}{% raw %}
GET /api/v3/Patient/$export?_type=ExplanationOfBenefit&_typeFilter=ExplanationOfBenefit%3F_tag%3Dhttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CSharedSystem%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CNationalClaimsHistory%2Chttps%3A%2F%2Fbluebutton.cms.gov%2Ffhir%2FCodeSystem%2FSystem-Type%7CDDPS
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=sampleRequest language="shell" %}

##### Omitting _typeFilter

In v3, if you make a request without using the `_typeFilter` parameter to filter by System-Type, BCDA will return only NationalClaimsHistory and DDPS claims.

{% capture sampleRequest %}{% raw %}
GET /api/v3/Patient/$export?_type=ExplanationOfBenefit
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=sampleRequest language="shell" %}

## New extension and code system URLs

BCDA v3 uses the StructureDefinition and CodeSystem FHIR resources. This is the standard way to represent code system URLs. It makes it easier to access the metadata. You can access the metadata for each Extension and CodeSystem by hitting the URL. This will return a StructureDefinition or CodeSystem FHIR resource.

### URLs changing between v2 and v3

Make the following changes to migrate to v3 if you’ve mapped any bluebutton extension or code system URLs:

#### Changes to Extension URLs

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-4">
  <caption class="usa-sr-only">Changes to Extension URLs between v2 and v3</caption>
  <tbody>
    <tr>
      <th scope="row">v2 URL</th>
      <td>
        {% include copy_snippet.html code="https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd/" language="ruby" can_copy=true %}
      </td>
    </tr>
    <tr>
      <th scope="row">v3 URL</th>
      <td>
        {% include copy_snippet.html code="https://bluebutton.cms.gov/fhir/StructureDefinition/CLM-NRLN-RIC-CD" language="ruby" can_copy=true %}
      </td>
    </tr>
  </tbody>
</table>

#### Changes to CodeSystem URLs

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-4">
  <caption class="usa-sr-only">Changes to CodeSystem URLs between v2 and v3</caption>
  <tbody>
    <tr>
      <th scope="row">v2 URL</th>
      <td>
        {% include copy_snippet.html code="https://bluebutton.cms.gov/resources/variables/nch_near_line_rec_ident_cd/" language="ruby" can_copy=true %}
      </td>
    </tr>
    <tr>
      <th scope="row">v3 URL</th>
      <td>
        {% include copy_snippet.html code="https://bluebutton.cms.gov/fhir/CodeSystem/CLM-NRLN-RIC-CD" language="ruby" can_copy=true %}
      </td>
    </tr>
  </tbody>
</table>

If your BCDA client is using any of the v2 URLs, you’ll need to update your code to look for the v3 version.

## Different resource IDs between versions

<div class="usa-alert usa-alert--warning">
  <div class="usa-alert__body">
      <p class="usa-alert__heading text-bold">Do not use FHIR IDs to match resources between versions.</p>
      <p class="usa-alert__text">To match <a href="{{ '/v3/api-documentation/how-to-migrate-v3.html#matching-beneficiaries-between-v2-and-v3-2' | relative_url }}">beneficiaries</a>, use MBI and demographics data. To match <a href="{{ 'v3/api-documentation/how-to-migrate-v3.html#matching-claims-between-v2-and-v3-2' | relative_url }}">claims</a>, use the claim control number.</p>
  </div>
</div>

In BCDA v3, the FHIR ID (`Patient.id`, `ExplanationOfBenefit.id`, `Coverage.id`) for a given resource will not match the v2 FHIR resource ID.

**Example:**

If you receive the `Patient` resource from BCDA v3, do not look up an existing patient by expecting the v2 `Patient.id` to equal the v3 `Patient.id` value. These values will not match. They are a different set of identifiers. However, the range of v2 and v3 Patient IDs does overlap, so there are some IDs that represent a v2 Patient and v3 Patient. This would not mean they represent the same beneficiary in real life.  

Instead of matching on `Patient.id`, use the relevant CMS identifier (MBI), along with additional supporting resource info (patient demographics like name, date of birth, etc.). Similarly, `ExplanationOfBenefit.id` and Coverage.id will not match between v2 and v3. 

### Matching beneficiaries between v2 and v3

Because the v2 and v3 Patient IDs will not match, in order to match a v3 patient to a patient you already have in your database, the best way is to use the MBI and demographics. The MBI and demographics should match between versions of BCDA. 

To find the MBI in the FHIR Patient resource, look at the `Patient.identifier` element for an identifier where the `identifier.system` is `http://hl7.org/fhir/sid/us-mbi`. The `identifier.value` will be the MBI.

Example v3 `Patient.identifier` element:

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

Once you have matched an existing `Patient`, or created a new one, it is ok to store the BCDA v3 `Patient.id`. It is possible for two different MBIs to reference the same beneficiary, and therefore the same BCDA v3 `Patient`. If that happens, you will see multiple instances of `Patient.identifier` where the system is `http://hl7.org/fhir/sid/us-mbi`. This is rare, but you should be prepared for it to happen.

Example of v3 `Patient.identifier` with two MBIs:

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

Because each version of a claim will have a unique claim ID, you should avoid using the unique claim ID to track a claim across versions, or even within a version across the adjudication journey. Instead, use the claim control number. It is the identifier where the `identifier.system` equals [https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM](https://bluebutton.cms.gov/identifiers/CLM-CNTL-NUM).

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
