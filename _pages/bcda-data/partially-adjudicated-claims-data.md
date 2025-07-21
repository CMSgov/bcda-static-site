---
layout: api-docs
page_title: "Guide to Partially Adjudicated Claims Data"
seo_title: ""
description: "Get early access to enrollee claims data as soon as 2-4 days after Medicare submission with BCDA partially adjudicated claims data."
in-page-nav: true
---

# {{ page.page_title }}

BCDA provides both partially and fully adjudicated claims data. The key differences between these data types are outlined below:

<table class="usa-table usa-table--borderless usa-table--stacked margin-bottom-4">
  <caption class="usa-sr-only">Partially versus fully adjudicated claims data</caption>
  <thead>
    <tr>
      <th scope="col">Partially adjudicated claims</th>
      <th scope="col">Fully adjudicated claims</th>
    </tr>
  </thead>
  <tbody>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
        Update daily
      </td>
      <td data-label="Fully adjudicated claims">
        Update weekly
      </td>
    </tr>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
          Available to <a href="https://www.cms.gov/priorities/innovation/innovation-models/aco-reach" target="_blank" rel="noopener noreferrer">ACO REACH</a> participants only
      </td>
      <td data-label="Fully adjudicated claims">
          Available to all <a href="{{ '/index.html#eligible-model-entities' | relative_url }}">eligible model entities</a>
      </td>
    </tr>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
        Requires V2
      </td>
      <td data-label="Fully adjudicated claims">
        Available with V1 or V2
      </td>
    </tr>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
         <a href="{{ '/assets/downloads/BCDA_Partially_Adjudicated_Data_Dictionary.xlsx' | relative_url }}">Partially Adjudicated Claims Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}</a>
      </td>
      <td data-label="Fully adjudicated claims">
        <a href="{{ '/assets/downloads/BCDA_Data_Dictionary.xlsx' | relative_url }}"> BCDA Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a>
      </td>
    </tr>
  </tbody>
</table>

## What is partially adjudicated claims data?

### A faster way to access claims data

Partially adjudicated claims are not fully paid or processed by Medicare yet when they are received by Beneficiary Claims Data API (BCDA). This reduces the time to access data to just 2-4 days after claims submission. 

In total, this typically takes up to 10 days after the episode of care. The data is subject to change with adjustments expected every 2-4 days during processing.

Visit the resources below to learn more: 

- [Access partially adjudicated claims data in the BCDA Sandbox]({{ '/api-documentation/get-a-bearer-token.html#partially-adjudicated-claims-data-sets' | relative_url }})
- <a href="https://www.medicare.gov/what-medicare-covers" target="_blank" rel="noopener noreferrer">Services covered by Medicare Parts A and B</a>
- <a href="https://4innovation.cms.gov/secure/knowledge-management/view/341" target="_blank" rel="noopener noreferrer">Fee-for-Service (FFS) Claims Processing</a> (requires 4i access)
- <a href="https://4innovation.cms.gov/secure/knowledge-management/view/491" target="_blank" rel="noopener noreferrer">Reporting and Data Sharing Overview</a> (requires 4i access)

## Resource types  

Partially adjudicated claims data is accessed using 2 additional resource types: 

- **<a href="https://www.hl7.org/fhir/claim.html" target="_blank" rel="noopener noreferrer">Claim</a>** – Information about the professional and institutional claims that providers submit for payment (including the services that enrollees receive)
- **<a href="https://www.hl7.org/fhir/claimresponse.html" target="_blank" rel="noopener noreferrer">ClaimResponse</a>** – Information about a claim’s adjudication status and processing results

Claim and ClaimResponse only provide access to Parts A and B Fee-for-Service claims data. They don’t include Part D (drug coverage) and Durable Medical Equipment (DME) claims. Review the [Partially Adjudicated Claims Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}]({{ '/assets/downloads/BCDA_Partially_Adjudicated_Data_Dictionary.xlsx' | relative_url }}) for a complete list and description of the data fields. 

## Use cases 

### Example 1: Improve transition of care

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can check if post-discharge processes are in place for an attributed enrollee shortly after a hospital discharge.</p>

On May 1, 2022, Mrs. Gonzales is doing better after a bout of pneumonia and is released home from the hospital. The hospital submits a claim for her stay to Medicare on May 3, 2022. 

- BCDA receives partially adjudicated claims data that reflects this update. This is identified by a Document Control Number (DCN) within a few days. 
- A REACH ACO sets up a dashboard to track newly identified discharges. After receiving an automated care-coordination alert for Mrs. Gonzales, they are able to follow up on her post-discharge care in a timely manner. 
- Using supplemental data, the REACH ACO adds filters into the dashboard for parameters of interest like whether the discharging hospital is in-network.
- BCDA will reflect any status changes to the claim, for example if Mrs. Gonzales’ claim is returned to the provider or adjusted.  
- These changes may involve updates to key variables used for care coordination, like diagnosis codes. The claims data will indicate the final status once a claim finishes adjudication and is submitted for payment. 
- BCDA's adjudicated data will pick up this claim after several additional processing steps. This is typically up to 14 days after submission.

REACH ACOs can also flag and identify patients who have a high risk of readmission based on factors like past diagnosis. Early access to claims data can help reduce readmissions and healthcare costs. 

### Example 2: Identify opportunities for intervention

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can monitor outpatient events for follow-up care and track patterns that often indicate future utilization. The data can be used to target case management and deliver clinically appropriate follow-up care.</p>

On September 6, 2022, Mr. Fritz underwent a duplex scan to evaluate for carotid artery stenosis. The cardiology clinic submits a claim for this procedure to Medicare on September 8, 2022. 

- BCDA receives partially adjudicated claims data that reflects this update. This is identified by an Internal Control Number (ICN) in a few days. 
- A REACH ACO creates a dashboard to track procedures that merit review. Mr. Fritz’s service is flagged because it signals the surgeon may be planning a carotid endarterectomy procedure. 
- However, if Mr. Fritz does not have neurological symptoms, this procedure may not be a recommended course of action. The REACH ACO is able to activate protocols to alert his primary care provider for intervention. 
- As with example 1, BCDA will reflect any status changes to the claim. 
- As with example 1, BCDA's adjudicated data will pick up this claim.

REACH ACOs can also track performance on cases where the care may be of limited value. For example, if Mr. Fritz does not have neurologic symptoms, then this kind of scan has been indicated to be more harmful than beneficial. This information could be used by the REACH ACO to reduce the volume of unnecessary procedures. 

### Example 3: Enhance care coordination

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can learn more about their patients’ health histories, build their clinical profile, and improve care coordination.</p>

Ms. Thompson began treatment for breast cancer on March 8, 2023. She is experiencing nausea and dehydration as a result of chemotherapy. While visiting family on March 14, she drove to an emergency room (ER) 50 miles from home. She was treated with IV fluids and nausea medication.  

- BCDA receives partially adjudicated claims data that reflects this update. This is identified by an Internal Control Number (ICN) in a few days. 
- This emergency room visit may provide useful insights into Ms. Thompson’s health history and chemotherapy journey. If Ms. Thompson is experiencing symptoms, her plan of treatment may need to be adjusted moving forward. 
- REACH ACOs can track procedures and services, including those from a different system, to get a holistic view of patients’ health histories. REACH ACOs can then follow up with the patient and/or provider to improve care coordination.

REACH ACOs can also monitor the rate of emergency services used by patients undergoing active cancer treatment and following transplantation. 

In the past, it would take weeks to know whether patients received care outside the network. Partially adjudicated claims data allows REACH ACOs to more quickly identify and investigate out-of-network care. 

### Common questions

<div class="padding-y-1"></div>

<!-- Accordion content -->
{% capture a0AccordionContent %}
REACH ACOs can visit <a href="{{ '/production-access.html' | relative_url }}">Production Access</a> to get credentials and use V2 of the API to begin accessing data.
{% endcapture %}

{% capture a1AccordionContent %}
Adjudication is Medicare’s process of reviewing and approving claims. It involves submission, validation, review, and approval. <a href="{{ '/about.html#claims-data-process' | relative_url }}">Learn more about the claims data process</a>. 
{% endcapture %}

{% capture a2AccordionContent %}
<p>
    No, REACH ACOs don’t need to update their credentials since V2 supports the same functionality as V1 in both the sandbox and production environments. 
</p>
<p>
    All V2 endpoints will work as described in the existing BCDA documentation. <a href="{{ '/bcda-data/difference-between-v1-v2.html' | relative_url }}">Learn more about the differences between V1 and V2</a>.
</p>
{% endcapture %}

{% capture a3AccordionContent %}
BCDA receives partially adjudicated claims data after it’s submitted to Medicare. BCDA only has access to actual claims, not pre-authorization or pre-determination data.
{% endcapture %}

{% capture a4AccordionContent %}
<p>
    Partially adjudicated claims data won’t provide much benefit for simple, single-stage events (e.g., vitamin D testing) since the event is complete and the payment has been made.
</p>
<p>
    However, the data is useful for tracking completed stages of multi-events. With Claim and ClaimResponse, you’ll have earlier notice of the multi-event. This lets you intervene sooner and mitigate high or recurring costs.
</p>
{% endcapture %}

{% capture a5AccordionContent %}
<p>
    In general, the volume of claims data you're going to receive depends on how many enrollees are attributed to your model entity and the number of updates a given claim receives. You can perform a database query on your attributed enrollees for more information.
</p>
<p>
    You can expect a higher number of updates with partially adjudicated claims data. It’s subject to more changes since there may be multiple rounds of processing and adjustments. You'll get updates when this occurs, resulting in a seemingly larger amount of data than adjudicated claims, which are final-action.
</p>
{% endcapture %}

{% capture a6AccordionContent %}
<p>
    No, Claim and ClaimResponse only contain a subset of the data elements available in EOB. They are also subject to more changes. Claim and ClaimResponse are only available for 60 days after their most recent update.
</p>
<p>
    By that time, the claim is typically adjudicated and details on the episode of care will be available to your organization in EOB. EOB provides the full set of data elements and is more accurate for long-term records.
</p>
{% endcapture %}

{% capture a7AccordionContent %}
Every Claim has only 1 ClaimResponse. Version numbers aren’t currently provided. <a href="https://groups.google.com/forum/#!forum/bc-api" target="_blank" rel="noopener noreferrer">Contact us</a> if you’d like us to explore versioning in the future.
{% endcapture %}

{% capture a8AccordionContent %}
No, these 2 fields are not currently available. Join our<a href="https://groups.google.com/forum/#!forum/bc-api" target="_blank" rel="noopener noreferrer"> Google Group</a> if you have feedback to improve the availability of data elements. 
{% endcapture %}

{% capture a9AccordionContent %}
BCDA is continuously working to source and add new data fields. Message us in our <a href="https://groups.google.com/forum/#!forum/bc-api" target="_blank" rel="noopener noreferrer">Google Group</a> if there are any fields you’d like added.
{% endcapture %}

<!-- Insert accordions -->
{%  include accordion.html id="a0" 
    heading="How can REACH ACOs access partially adjudicated claims data?"
    expanded=true 
    bordered=false 
    accordionContent=a0AccordionContent %}

{%  include accordion.html id="a1" 
    heading="What is claims adjudication?"
    expanded=false 
    bordered=false 
    accordionContent=a1AccordionContent %}

{%  include accordion.html id="a2" 
    heading="Do REACH ACOs on V1 need to update their credentials to access partially adjudicated claims data on V2?"
    expanded=false 
    bordered=false 
    accordionContent=a2AccordionContent %}

{%  include accordion.html id="a3" 
    heading="Is partially adjudicated claims data received after a supplier’s orders are completed and the claims are submitted for payment? Or is it received in a pre-authorization form?"
    expanded=false 
    bordered=false 
    accordionContent=a3AccordionContent %}

{%  include accordion.html id="a4" 
    heading="Is there any benefit to partially adjudicated claims data if the event is already complete?"
    expanded=false 
    bordered=false 
    accordionContent=a4AccordionContent %}
    
{%  include accordion.html id="a5" 
    heading="What’s the estimated amount of data REACH ACOs will receive through partially adjudicated claims? How does that compare to adjudicated claims?"
    expanded=false 
    bordered=false 
    accordionContent=a5AccordionContent %}

{%  include accordion.html id="a6" 
    heading="Do the Claim and ClaimResponse resource types negate the need for ExplanationOfBenefit (EOB)?"
    expanded=false 
    bordered=false 
    accordionContent=a6AccordionContent %}

{%  include accordion.html id="a7" 
    heading="Does every Claim have a corresponding ClaimResponse? Are there version numbers?"
    expanded=false 
    bordered=false 
    accordionContent=a7AccordionContent %}

{%  include accordion.html id="a8" 
    heading="Does partially adjudicated claims data have Claim ID and Claim Group ID fields?"
    expanded=false 
    bordered=false 
    accordionContent=a8AccordionContent %}

{%  include accordion.html id="a9" 
    heading="Will you release additional data elements for partially adjudicated claims data in the future?"
    expanded=false 
    bordered=false 
    accordionContent=a9AccordionContent %}