---
layout: api-docs
page_title: "Support"
seo_title: ""
description: "Browse frequently asked questions, join our Google Group, and contact the BCDA team for help troubleshooting the Medicare claims API."
show-side-nav: false
in-page-nav: true
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
    <img src="{{ '/assets/img/experts.svg' | relative_url }}" alt="customer support illustration" />
  </div>
  <div class="tablet:grid-col tablet:order-1 padding-top-2">
    <h2>We're here to help</h2>
    <p>
        You can contact us by joining the <a href="https://groups.google.com/g/bc-api" target="_blank" rel="noopener noreferrer">Google Group</a> or email <a href="mailto:bcapi@cms.hhs.gov">bcapi@cms.hhs.gov</a> to ask questions and get help. When troubleshooting API requests, please include:
    </p>
    <ul>
        <li>whether this is a sandbox or production API request</li>
        <li>your organization’s 5 character entity ID or sandbox data set</li>
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
    BCDA supports organizations (entities) participating in the following CMS <a href="https://www.cms.gov/priorities/innovation/about/alternative-payment-models">Alternative Payment Models</a>:
    <ul>
        <li><a href="https://www.cms.gov/medicare/payment/fee-for-service-providers/shared-savings-program-ssp-acos"
            target="_blank" rel="noopener noreferrer">Medicare Shared Savings Program (SSP)</a></li>
        <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/kidney-care-choices-kcc-model"
            target="_blank" rel="noopener noreferrer">Kidney Care Choices (KCC) Model</a></li>
        <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/aco-reach" target="_blank"
            rel="noopener noreferrer">Accountable Care Organizations Realizing Equity, Access, and Community Health
            (ACO REACH)
            Model</a></li>
        </ul>
    Only REACH ACOs can access <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">partially adjudicated claims data</a>. 
</p>
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
    It typically takes 2-4 days after submission to receive <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">partially adjudicated claims data</a> and up to 14 days for adjudicated claims data. Even after adjudication, claims may go through additional processing. BCDA provides the latest updates available for each claim. <a href="{{ '/about.html#claims-data-process' | relative_url }}">See a timeline of the claims data process</a>.
</p>
<p>
    According to Section 6404 of the Affordable Care Act, Medicare Fee-for-Service claims must be submitted within 12 months (1 calendar year) of the date of service. <a href="https://www2.ccwdata.org/documents/10280/19002256/medicare-claims-maturity.pdf" target="_blank" rel="noopener noreferrer">Learn about claims submission and approval time frames.</a></p>
{% endcapture %}

{% capture a4AccordionContent %}
<p>
    Adjudicated claims data is loaded from the <a href="https://www2.ccwdata.org/web/guest/home/" target="_blank" rel="noopener noreferrer">Chronic Conditions Data Warehouse (CCW)</a>. Partially adjudicated claims data is loaded from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS).
</p>
{% endcapture %}

{% capture a5AccordionContent %}
<p>
    Adjudicated claims data (ExplanationOfBenefit, Patient, Coverage) is updated weekly and partially adjudicated claims data (Claim, ClaimResponse) is updated daily.
</p>
<p>
    You can export data as often as you like, depending on your needs and how often the data is refreshed. We don’t recommend exporting data more than once a week for adjudicated claims and once a day for partially adjudicated claims. Use the <a href="{{ '/api-documentation/filter-claims-data.html#the-_since-parameter' | relative_url }}">_since parameter</a> when running jobs to avoid downloading duplicate data.
</p>
{% endcapture %}

{% capture a6AccordionContent %}
<p>CCLF files are automatically available monthly using 12 flat files, and can be downloaded weekly upon request. BCDA updates adjudicated claims weekly using 3 NDJSON files and partially adjudicated claims data daily using 2 additional files.</p>
    
<p>Additionally, BCDA is an API that uses the <a href="https://hl7.org/fhir/uv/bulkdata/" target="_blank" rel="noopener noreferrer">Bulk Fast Healthcare Interoperability Resources (FHIR)</a> format, as required by CMS. <a href="{{ '/bcda-data/comparison-bcda-cclf-files.html' | relative_url }}">Learn more about the differences.</a></p>
{% endcapture %}

{% capture a7AccordionContent %}
<p>A status code of 429 indicates “Too Many Requests.” Wait until the period of time specified in the header has passed before making more requests.</p>

<p>This makes sure your client can adapt without manual intervention, even if the rate-limiting parameters change. <a href="{{ '/api-documentation/access-claims-data.html' | relative_url }}#response-example-too-many-requests">Learn more about the 429 status code.</a></p>
{% endcapture %}

{% capture a8AccordionContent %}
<p>
    BCDA requires that all production requests come from a registered IP address. Make sure the IP address(es) you’re using to request data have been added to the Allow List in your model-specific system. Visit <a href="{{ '/production-access.html' | relative_url }}">Production Access</a> for more details.
</p>
{% endcapture %}

{% capture a9AccordionContent %}
<p>Use caution with 3rd party web-based clients. By sharing your credentials, you may be allowing them to make REST calls on your behalf. This is a serious data privacy and security risk. We recommend using secure REST client tools. </p>
{% endcapture %}

{% capture a10AccordionContent %}
<p>
    BCDA V1 (<a href="https://hl7.org/fhir/STU3/" target="_blank" rel="noopener noreferrer">STU3</a>) and V2 (<a href="https://hl7.org/fhir/R4/" target="_blank" rel="noopener noreferrer">R4</a>) differ primarily in their FHIR specification. Version 1 is based on the Blue Button 2.0 Implementation Guide, while version 2 is based on the <a href="https://www.hl7.org/fhir/us/carin-bb/" target="_blank" rel="noopener noreferrer">CARIN Blue Button Implementation Guide</a>.
</p>
<p>There are minor differences in the mapping and values of certain data elements. <a href="{{ '/bcda-data/difference-between-v1-v2.html' | relative_url }}">Review the full summary of changes.</a></p>

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
    heading="What’s the difference between BCDA V1 and V2?"
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