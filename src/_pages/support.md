---
layout: api-docs
page_title: "Support"
seo_title: ""
description: "Browse frequently asked questions, join our Google Group, and contact the BCDA team for help troubleshooting the Medicare claims API."
show-side-nav: false
in-page-nav: true
feedback_id: "e9112e33"
---

# {{ page.page_title }}

<div class="usa-alert usa-alert--warning usa-alert--slim">
  <div class="usa-alert__body">
    <p class="usa-alert__text maxw-desktop-lg">
      Please cover or label <a href="#compliance-and-restrictions">Personally Identifiable Information (PII)</a> as "REDACTED" in the Google Group or email communication.
    </p>
  </div>
</div>

<div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-y-4 flex-align-center">
  <div class="tablet:grid-col tablet:order-2">
    <img src="{{ '/assets/img/experts.svg' | relative_url }}" alt="" />
  </div>
  <div class="tablet:grid-col tablet:order-1 padding-top-2">
    <h2>We're here to help</h2>
    <p>
        You can contact us by joining the <a href="https://groups.google.com/g/bc-api" target="_blank" rel="noopener noreferrer">Google Group</a> or email <a href="mailto:bcapi@cms.hhs.gov">bcapi@cms.hhs.gov</a> to ask questions and get help. When troubleshooting API requests, please include:
    </p>
    <ul>
        <li>whether this is a sandbox or production API request</li>
        <li>your organization's 5 character entity ID or sandbox data set</li>
        <li>the API request that's resulting in the problem </li>
        <li>any response and additional messaging from the API</li>
    </ul> 
    <a href="https://groups.google.com/g/bc-api" target="_blank" rel="noopener noreferrer" class="usa-button margin-top-2">Join the Google Group</a>
  </div>
</div>

## Frequently asked questions

<!-- FAQ content only-->
{% capture a1AccordionContent %}
<p>
   BCDA supports organizations (entities) participating in the following CMS <a href="https://www.cms.gov/priorities/innovation/about/alternative-payment-models" target="_blank" rel="noopener">alternative payment models</a>:
</p>
<ul>
    <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/access" target="_blank" rel="noopener">ACCESS (Advancing Chronic Care with Effective, Scalable Solutions)</a></li>
    <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/aco-reach" target="_blank" rel="noopener">ACO REACH (Accountable Care Organization Realizing Equity, Access, and Community Health)</a></li>
    <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/guide" target="_blank" rel="noopener">GUIDE (Guiding an Improved Dementia Experience)</a></li>
    <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/iota" target="_blank" rel="noopener">IOTA (Increasing Organ Transplant Access)</a></li>
    <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/kidney-care-choices-kcc-model" target="_blank" rel="noopener">KCC (Kidney Care Choices)</a></li>
    <li><a href="https://www.cms.gov/medicare/payment/fee-for-service-providers/shared-savings-program-ssp-acos" target="_blank" rel="noopener">SSP (Shared Savings Program)</a></li>
</ul>
{% endcapture %}

{% capture a2AccordionContent %}
<p>
    Completely cover or label <a href="https://www.hhs.gov/answers/hhs-administrative/what-is-pii/index.html">Personally Identifiable Information (PII)</a> and <a href="https://www.hhs.gov/answers/hipaa/what-is-phi/index.html">Protected Health Information (PHI)</a> as “REDACTED” in emails, screenshots, and documents. Ensure any masks are 100% opaque and in a format that supports layers.
</p>
<p>
    Examples of PII and PHI: 
    <ul>
        <li>Medicare Beneficiary Identifier (MBI)</li>
        <li>Taxpayer Identification Number (TIN)</li>
        <li>National Provider Identifier (NPI)</li>
        <li>Social Security Number (SSN)</li>
        <li>API keys or access credentials (e.g., client ID and secret)</li>
        <li>authorization or bearer tokens</li>
    </ul>
</p>
<p>
    PII and PHI are often found in API requests or response payloads referenced in:
    <ul>
        <li>the text of your Google Group posts or emails</li>
        <li>files attached to your Google Group posts or emails (e.g., XMLs, JSONs)</li>
        <li>screenshots attached to your Google Group posts or emails</li>
    </ul>
</p>
<p>
    Example of a redacted response:
</p>
{% capture curlSnippet %}{% raw %}
{
    "taxpayerIdentificationNumber": "REDACTED",
    "nationalProviderIdentifier": "REDACTED"
}
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="json" %}
{% endcapture %}

{% capture a3AccordionContent %}
<p>
    It typically takes 2-4 days after submission for BCDA to receive <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">partially adjudicated claims data</a> and up to 7 days for adjudicated claims data. Even after adjudication, claims may go through additional processing. BCDA will continue to provide the latest updates available for each claim.
</p>
<p>
    According to Section 6404 of the Affordable Care Act, Original Medicare claims must be submitted within 12 months (1 calendar year) of the date of service.
</p>
{% endcapture %}

{% capture a4AccordionContent %}
<p>BCDA v3 sources data from CMS's Integrated Data Repository (IDR).</p>
<p>For earlier versions of BCDA, adjudicated claims data is loaded from the <a href="https://www2.ccwdata.org/web/guest/home/" target="_blank" rel="noopener noreferrer">Chronic Conditions Data Warehouse (CCW)</a>. Partially adjudicated claims data is loaded from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS). </p>
{% endcapture %}

{% capture a5AccordionContent %}
<p>The following table shows how frequently Medicare claims data is refreshed and potentially available to eligible organizations.</p>

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

<p id="refresh-fn1" class="font-body-2xs" style="scroll-margin-top: 6.25rem;"><sup>1</sup> Data is loaded on the Monday after it's loaded into the source system, 0-7 days from processing or "adjudication."</p>

<p>To stay up to date with the latest claims data for your enrollees, we recommend exporting data from National Claims History once per week, and daily for all other sources. Use the <a href="{{ '/api-documentation/filter-claims-data.html#the-_since-parameter' | relative_url }}">_since parameter</a> when running jobs to avoid downloading duplicate data.</p>
{% endcapture %}

{% capture a6AccordionContent %}
<p>CCLF files are automatically available monthly using 12 flat files, and can be downloaded weekly upon request.</p>
<p>BCDA updates adjudicated claims weekly and partially adjudicated claims 4x/week using 3 NDJSON files (Coverage, Patient, ExplanationOfBenefit).</p>
<p>Additionally, BCDA is an API that uses the <a href="https://hl7.org/fhir/uv/bulkdata/" target="_blank" rel="noopener noreferrer">Bulk Fast Healthcare Interoperability Resources (FHIR)</a> format, as required by CMS. <a href="{{ '/bcda-data/comparison-bcda-cclf-files.html' | relative_url }}">Learn more about the differences</a>.</p>
{% endcapture %}

{% capture a7AccordionContent %}
<p>A status code of 429 indicates “Too Many Requests.” Wait until the period of time specified in the header has passed before making more requests.</p>

<p>This makes sure your client can adapt without manual intervention, even if the rate-limiting parameters change. <a href="{{ '/api-documentation/access-claims-data.html' | relative_url }}#response-example-too-many-requests">Learn more about the 429 status code.</a></p>
{% endcapture %}

{% capture a8AccordionContent %}
<p>
    BCDA requires that all production requests come from a registered IP address. Make sure the IP addresses you're using to request data have been added to the Allow List in your model-specific system. Visit <a href="{{ '/production-access.html' | relative_url }}">Production Access</a> for more details.
</p>
{% endcapture %}

{% capture a9AccordionContent %}
<p>Use caution with 3rd party web-based clients. By sharing your credentials, you may be allowing them to make REST calls on your behalf. This is a serious data privacy and security risk. We recommend using secure REST client tools. </p>
{% endcapture %}

{% capture a10AccordionContent %}
<p>BCDA v3 introduces a number of improvements, including:</p>
<ul>
    <li>More frequent and timely updates</li>
    <li>Easier claims tracking</li>
    <li>Enhanced filtering capabilities</li>
    <li>Simplified, reliable data mapping capabilities</li>
    <li>Improved conformance with select FHIR Implementation Guides</li>
    <li>Simplified linking between partially and fully adjudicated claims</li>
    <li>Uses consistent claim identifiers across all phases of adjudication</li>
</ul>
<p>We’ve also corrected issues some users encountered with v1 and v2 such as:</p>
<ul>
    <li>Mismatched data between BCDA resources and CCLF files</li>
    <li>Missing data for newly attributed enrollees</li>
    <li>Issues for enrollees assigned more than one BENE_ID</li>
</ul>
<p>You can learn more about v3 improvements and problems solved at <a href="{{ '/about/introducing-v3.html' | relative_url }}">Introducing BCDA v3</a>.</p>
{% endcapture %}

{% capture a11AccordionContent %}
<p>Terminated and discontinued organizations lose access to the API, including runouts data, the same day their participation in the model ends.</p>
{% endcapture %}

<!-- FAQ section -->

<h3 class="margin-bottom-2">About the API</h3>

{% include accordion.html
    id="a1"
    expanded=true
    heading="Who is eligible to use Beneficiary Claims Data API (BCDA)?"
    accordionContent=a1AccordionContent
%}

{% include accordion.html 
    id="a11" 
    expanded=false 
    heading="When do terminated and discontinued model entities lose API access?" 
    accordionContent=a11AccordionContent     
%}

{% include accordion.html 
    id="a6" 
    expanded=false 
    heading="What's the difference between BCDA and CCLF files?" 
    accordionContent=a6AccordionContent     
%}

{% include accordion.html
    id="a10"
    expanded=false
    heading="What's the difference between BCDA v2 and v3?"
    accordionContent=a10AccordionContent
%}

<h3 class="margin-bottom-2">Compliance and restrictions</h3>

{% include accordion.html
    id="a2"
    expanded=true
    heading="How do I redact PHI and PII when sharing information?"
    accordionContent=a2AccordionContent
%}

{% include accordion.html
    id="a9"
    expanded=false
    heading="Can I use 3rd party web-based REST clients or tools?"
    accordionContent=a9AccordionContent
%}

<h3 class="margin-bottom-2">Claims processing timeline</h3>

{% include accordion.html
    id="a3"
    expanded=false
    heading="How long does it take BCDA to receive a claim after it is submitted?"
    accordionContent=a3AccordionContent
%}

{% include accordion.html
    id="a4"
    expanded=false
    heading="Where does the data come from?"
    accordionContent=a4AccordionContent
%}

{% include accordion.html
    id="a5"
    expanded=false
    heading="How often is data refreshed?"
    accordionContent=a5AccordionContent
%}
<h3 class="margin-bottom-2">Troubleshooting</h3>

{% include accordion.html
    id="a8"
    expanded=false
    heading="Why do I get connection timeout issues with my production credentials?"
    accordionContent=a8AccordionContent
%}

{% include accordion.html
    id="a7"
    expanded=false
    heading="Why am I getting a 429 error response?"
    accordionContent=a7AccordionContent
%}

