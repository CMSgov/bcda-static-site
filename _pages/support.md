---
layout: api-docs
page_title: "Support"
seo_title: ""
description: ""
permalink: /support
show-side-nav: false
---

# {{ page.page_title }}

<div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-y-4 flex-align-center">
  <div class="tablet:grid-col tablet:order-2">
    <img src="{{ '/assets/img/experts.svg' | relative_url }}" alt="customer support illustration" />
  </div>
  <div class="tablet:grid-col tablet:order-1 padding-top-2">
    <h2>We're here to help</h2>
    <p>
        The <a href="https://groups.google.com/u/0/g/cms-ab2d-api" target="_blank" rel="noopener">BCDA Google Group</a> is an active community where you can ask questions, give feedback, and get the latest news. Use the topic labels to find relevant posts. You can also email us at <a href="mailto:bcapi@cms.hhs.gov">bcapi@cms.hss.gov</a>
    </p>
    <div class="usa-alert usa-alert--warning usa-alert--slim">
        <div class="usa-alert__body">
            <p class="usa-alert__text">
                Please do not share <a href="https://www.hhs.gov/answers/hhs-administrative/what-is-pii/index.html" target="_blank" rel="noopener">Personally Identifiable Information (PII)</a> or <a href="https://www.hhs.gov/answers/hipaa/what-is-phi/index.html" target="_blank" rel="noopener">Protected Health Information (PHI)</a> in the group or via email.
             </p>
        </div>
    </div>  
    <p>
        When troubleshooting API requests, please include the following details:
        <ul>
            <li>whether this is is a sandbox or production API request</li>
            <li>your organization’s 5 character entity ID or sandbox data set</li>
            <li>the API request that is resulting in the problem (Please cover or label sensitive information as “REDACTED.”)</li>
            <li>any response and additional messaging from the API</li>
        </ul>
    </p>
    <a href="https://groups.google.com/u/0/g/cms-ab2d-api" target="_blank" rel="noopener" class="usa-button margin-top-2">Join the Google Group</a>
  </div>
</div>



## Frequently asked questions

<div class="padding-top-4"></div>

<!-- FAQ content only-->
{% capture a1AccordionContent %}
<p>
    BCDA supports organizations (entities) participating in the following CMS alternative payment models:
        <ul>
            <li>Medicare Shared Savings Program (SSP)</li>
            <li>Kidney Care Choices (KCC) Model</li>
            <li>Accountable Care Organizations Realizing Equity, Access, and Community Health (ACO REACH) Model</li>
        </ul>
    Only REACH ACOs can access <a href="{{ '/placeholder' | relative_url }}">partially adjudicated claims data</a>. 
</p>
{% endcapture %}

{% capture a2AccordionContent %}
<p>
    Label sensitive information as “REDACTED” in emails and editable documents. In screenshots and non-editable documents (e.g., PDFs), completely cover or erase sensitive information. Make sure the mask is 100% opaque and save the final image in a format that supports layers (e.g., PDF).
</p>
<p>
    Examples of PHI and PII: 
    <ul>
        <li>Medicare Beneficiary Identifier (MBI)</li>
        <li>Taxpayer Identification Number (TIN)</li>
        <li>National Provider Identifier (NPI)</li>
        <li>Social Security Number (SSN)</li>
        <li>API keys or access credentials (e.g., client ID, client Secret)</li>
        <li>authorization or bearer tokens</li>
    </ul>
</p>
<p>
    Sensitive information can commonly be found in API requests or response payloads referenced in:
    <ul>
        <li>the text of your Google Group post or emails</li>
        <li>files attached to your Google Group post or emails (e.g. XMLs, JSONs)</li>
        <li>screenshots attached to your Google Group post or emails</li>
    </ul>
</p>
<p>
    Example of a redacted response
</p>
{% capture curlSnippet %}{% raw %}
"taxpayerIdentificationNumber": "REDACTED",
"nationalProviderIdentifier": "REDACTED"
{% endraw %}{% endcapture %}
{% include copy_snippet.html code=curlSnippet language="shell" %}
{% endcapture %}

{% capture a3AccordionContent %}
<p>
    It typically takes 2-4 days after submission for BCDA to receive <a href="{{ '/placeholder' | relative_url }}">partially adjudicated claims data</a> and up to 14 days for adjudicated claims data. Even after adjudication, claims may go through additional processing. BCDA will continue to provide the latest updates available for each claim.
</p>
<p>
    According to Section 6404 of the Affordable Care Act, Medicare Fee-for-Service claims must be submitted within 12 months (1 calendar year) of the date of service.
</p>
<p><a href="https://www2.ccwdata.org/documents/10280/19002256/medicare-claims-maturity.pdf" target="blank" rel="noopener">Learn more about claims submission and approval timeframes.</a></p>
{% endcapture %}

{% capture a4AccordionContent %}
<p>
    Adjudicated claims data is loaded from the <a href="https://www2.ccwdata.org/web/guest/home/" target="blank" rel="noopener">Chronic Conditions Data Warehouse (CCW)</a>. Partially adjudicated claims data is loaded from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS).
</p>
{% endcapture %}

{% capture a5AccordionContent %}
<p>
    Adjudicated claims data (ExplanationOfBenefit, Patient, Coverage) is updated weekly and partially adjudicated claims (Claim, ClaimResponse) is updated daily.
</p>
<p>
    Model entities can export data as often as they like, depending on their needs and how often the claims data is refreshed. We don’t recommend exporting data more than once a week for adjudicated claims and no more than once a day for partially adjudicated claims. Use the <a href="{{ '/placeholder' | relative_url }}">_since parameter</a> when running jobs to avoid downloading duplicate data.
</p>
{% endcapture %}

{% capture a6AccordionContent %}
<p>
    BCDA and CCLF files both offer access to Medicare Parts A, B, and D claims data. However, there are some key differences:
    <ul>
        <li>Update timing: CCLF files update monthly while BCDA updates adjudicated claims weekly. REACH ACOs can use BCDA to access partially adjudicated claims, which update daily.</li>
        <li>Format: While CCLF files include more detailed demographic and claims processing context in their 12 flat files, BCDA provides a snapshot of enrollees’ claims database across 3 data types. Additionally, BCDA uses the <a href="https://hl7.org/fhir/uv/bulkdata/" target="blank" rel="noopener">Bulk Fast Healthcare Interoperability Resources (FHIR)</a> format, which results in differences in data mapping. Visit the <a href="{{ '/assets/downloads/bcda_data_dictionary.xlsx' | relative_url }}">Data Dictionary</a> to review how fields map between BCDA and CCLF files.</li>
    </ul>
</p>
<p>Each data source has unique advantages. You can even use both for a more accurate and wider variety of data. <a href="{{ '/placeholder' | relative_url }}">Learn more about the differences between BCDA and CCLF files.</a></p>
{% endcapture %}

{% capture a7AccordionContent %}
<p>A status code of 429 indicates “Too Many Requests.” There are 2 reasons this can happen:</p>
<ol>
    <li>Making too many HTTP requests within a short period of time</li>
    <li>Trying to recreate jobs already marked as "In-Progress.” For reference, you can view both existing and past jobs using the /Jobs endpoint.</li>
</ol>
<p>In all cases you’ll see a Retry-After response in the header. Wait until the period of time specified in the header has passed before making more requests. This makes sure your client can adapt without manual intervention, even if the rate-limiting parameters change.</p>
{% endcapture %}

{% capture a8AccordionContent %}
<p>
    BCDA requires that all production requests come from a registered IP Address. Make sure the IP address(es) you’re using to request data have been added to the allow list in your model-specific system. <a href="{{ '/production-access' | relative_url }}">Visit Production Access for more details.</a>
</p>
{% endcapture %}

{% capture a9AccordionContent %}
<p>Use caution with 3rd party web-based clients. By sharing your credentials, you may be allowing them to make REST calls on your behalf. This is a serious data privacy and security risk. We recommend using secure REST client tools. </p>
{% endcapture %}

{% capture a10AccordionContent %}
<p>
    BCDA V1 (<a href="https://hl7.org/fhir/STU3/" target="blank" rel="noopener">STU3</a>) and V2 (<a href="https://hl7.org/fhir/R4/" target="blank" rel="noopener">R4</a>) differ primarily in their FHIR specification. Version 1 is based on the Blue Button 2.0 Implementation Guide, while version 2 is based on the CARIN CDPDE Implementation Guide.
</p>
<p>There are minor differences in the mapping and values of certain data elements: 
    <ul>
        <li>Slicing/discriminator rules can be different, and some value sets will be bound to CARIN or HL7 value sets instead of BlueButton.</li>
        <ul>
            <li>Example 1: Patient.identifier.type in V2 is bound to the <a href="http://www.hl7.org/fhir/us/carin-bb/ValueSet-C4BBPatientIdentifierType.html" target="blank" rel="noopener">C4BB Patient Identifier type value set</a>.</li>
            <li>Example 2: EOB.Type is bound to the <a href="http://www.hl7.org/fhir/us/carin-bb/ValueSet-C4BBPayeeType.html" target="blank" rel="noopener">C4BB Payee Type value set</a> and the associated value will be one of the codes in that value set.</li>
        </ul>
    </ul>
</p>
<p><a href="{{ '/difference-between-v1-v2' | relative_url }}">Read the full summary of changes {% include sprite.html icon="arrow_forward" class="text-middle" %}</a></p>

{% endcapture %}

<!-- FAQ section -->
<div class="grid-col-8">
{% include accordion.html 
    id="a1" 
    expanded=true 
    heading="Who is eligible to use Beneficiary Claims Data API (BCDA)?" 
    accordionContent=a1AccordionContent     
%}

{% include accordion.html 
    id="a2" 
    expanded=true 
    heading="How do I redact PHI and PII when sharing information with the BCDA Team?" 
    accordionContent=a2AccordionContent     
%}

{% include accordion.html 
    id="a3" 
    expanded=false 
    heading="How long does it take BCDA to receive a claim after it is filed?" 
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

{% include accordion.html 
    id="a6" 
    expanded=false 
    heading="What is the difference between BCDA and CCLF files?" 
    accordionContent=a6AccordionContent     
%}

{% include accordion.html 
    id="a7" 
    expanded=false 
    heading="Why am I getting a 429 error response?" 
    accordionContent=a7AccordionContent     
%}

{% include accordion.html 
    id="a8" 
    expanded=false 
    heading="Why do I get connection timeout issues with my production credentials?" 
    accordionContent=a8AccordionContent     
%}

{% include accordion.html 
    id="a9" 
    expanded=false 
    heading="Can I use 3rd party web-based REST clients or tools?" 
    accordionContent=a9AccordionContent     
%}

{% include accordion.html 
    id="a10" 
    expanded=false 
    heading="What’s the difference between BCDA V1 and V2?" 
    accordionContent=a10AccordionContent     
%}

</div>