---
layout: api-docs
page_title: "Guide to Partially Adjudicated Claims Data"
seo_title: ""
description: ""
permalink: /guide-to-partially-adjudicated-claims-data
in-page-nav: true
---

# {{ page.page_title }}

As of May 2023, model entities participating in the Accountable Care Organization Realizing Equity, Access, and Community Health (ACO REACH) Model can access partially adjudicated claims data with V2 of the API.

## What is partially adjudicated claims data?

### A faster way to access claims data

Unlike most claims, partially adjudicated claims are not fully paid or processed by Medicare yet when they are received by the Beneficiary Claims Data API (BCDA). This reduces the time to access data to just 2-4 days after claims submission. In total, this typically takes up to 10 days after the episode of care. The data is subject to change with adjustments expected every 2-4 days as it goes through processing.

Visit the resources below to learn more: 

- [Access partially adjudicated claims data in the BCDA Sandbox]({{ '/get-a-bearer-token#partially-adjudicated-claims-data-sets' | relative_url }})
- [Fee-for-Service (FFS) Claims Processing](https://4innovation.cms.gov/secure/knowledge-management/ view/341)
- [Services covered by Medicare Parts A and B](https://www.medicare.gov/what-medicare-covers)
- [Reporting and Data Sharing Overview](https://4innovation.cms.gov/secure/knowledge-management/view/491)

## Resource types  

Partially adjudicated claims data are available as 2 unique resource types: 

- **[Claim](https://www.hl7.org/fhir/claim.html)** – Information about the professional and institutional claims that providers submit for payment (including the services that enrollees receive)
- **[ClaimResponse](https://www.hl7.org/fhir/claimresponse.html)** – Information about a claim’s adjudication status and processing results

Claim and ClaimResponse only provide access to Parts A and B Fee-for-Service claims data. They don’t include Part D (drug coverage) and Durable Medical Equipment (DME) claims. Review the [Partially Adjudicated Claims Data Dictionary {% include sprite.html icon="file_download" class="text-middle" %}]({{ '/assets/downloads/BCDA_Partially_Adjudicated_Data_Dictionary.xlsx' | relative_url }}) for a complete list and description of the data fields. 

## Use cases 

### Example 1: Improve transition of care

REACH ACOs can use partially adjudicated claims data to check if post-discharge processes are in place for an attributed enrollee shortly after a hospital discharge. 

On May 1, 2022, Mrs. Gonzales is doing better after a bout of pneumonia and is released home from the hospital. The hospital submits a claim for her stay to Medicare on May 3, 2022. 

- BCDA receives partially adjudicated claims data that reflects this update. This is identified by a Document Control Number (DCN) within a few days. 
- A REACH ACO sets up a dashboard to track newly identified discharges. After receiving an automated care-coordination alert for Mrs. Gonzales, they are able to follow up on her post-discharge care in a timely manner. 
- Using supplemental data, the REACH ACO adds filters into the dashboard for parameters of interest like whether the discharging hospital is in-network.
- BCDA will reflect any status changes to the claim, for example if Mrs. Gonzales’ claim is returned to the provider or adjusted.  
- These changes may involve updates to key variables used for care coordination, like diagnosis codes. The claims data will indicate the final status once a claim finishes adjudication and is submitted for payment. 
- The adjudicated data within BCDA will pick up this claim after several additional processing steps. This is typically up to about 14 days after the initial claim is available. 

REACH ACOs can also flag and identify patients who have a high risk of readmission based on factors like past diagnosis. Early access to claims data can help reduce readmissions and healthcare costs. 

### Example 2: Identify opportunities for intervention

REACH ACOs can use partially adjudicated claims data to monitor outpatient events for follow-up care and track patterns that often indicate future utilization. The data can be used to target case management and deliver clinically appropriate follow-up care.  

On September 6, 2022, Mr. Fritz underwent a duplex scan to evaluate for carotid artery stenosis. The cardiology clinic submits a claim for this procedure to Medicare on September 8, 2022. 

- BCDA receives partially adjudicated claims data that reflects this update. This is identified by an Internal Control Number (ICN) in a few days. 
- A REACH ACO creates a dashboard to track procedures that merit review. Mr. Fritz’s service is flagged because it signals the surgeon may be planning a carotid endarterectomy procedure. 
- However, if Mr. Fritz does not have neurological symptoms, this procedure may not be a recommended course of action. The REACH ACO is able to activate protocols to alert his primary care provider for follow-up care. 
- As with example 1, BCDA will reflect any status changes to the claim. 
- As with example 1, the adjudicated data within BCDA will pick up this claim after approximately 11 days.

REACH ACOs can also track performance on cases where the care may be of limited value. For example, if Mr. Fritz does not have neurologic symptoms, then this kind of scan has been indicated to be more harmful than beneficial. This information could be used by the REACH ACO to reduce the volume of unnecessary procedures. 

### Enhance care coordination

REACH ACOs can use partially adjudicated claims data to get more information on patients’ health histories, build their clinical profile, and improve care coordination. 

Ms. Thompson began treatment for breast cancer on March 8, 2023. She is experiencing nausea and dehydration as a result of chemotherapy. While visiting family on March 14, she drove to an emergency room (ER) 50 miles from home. She was treated with IV fluids and nausea medication.  

- BCDA receives partially adjudicated claims data that reflect this update. This is identified by an Internal Control Number (ICN) in a few days. 
- This emergency room visit may provide useful insights to Ms. Thompson’s health history and chemotherapy journey. If Ms. Thompson is experiencing symptoms, her plan of treatment may need to be adjusted moving forward. 
- REACH ACOs can track procedures and services, including those from a different system, to get a holistic view of patients’ health histories. REACH ACOs can then follow up with the patient and/or provider to improve care coordination.

REACH ACOs can also monitor the rate of emergency services used by patients undergoing active cancer treatment and following transplantation. Clinical teams maintain ongoing improvement projects to maintain health and avoid the need for ER treatment and hospitalization for patients in these high-risk areas. 

In the past, it would take weeks to know whether patients received care outside the network. Partially adjudicated claims data allows REACH ACOs to more quickly identify and investigate out-of-network care. 

### Common questions

<div class="padding-y-1"></div>

{% capture a1AccordionContent %}
Visit <a href="{{ '/production-access' | relative_url }}">Production Access</a> to retrieve synthetic data, authorize your model entity, and get production credentials.
{% endcapture %}

{% capture a2AccordionContent %}
<p>
    No, REACH ACOs don’t need to update their credentials since V2 supports the same functionality as V1 in both the sandbox and production environments. 
</p>
<p>
    All V2 endpoints will work as described in the existing BCDA documentation. <a href="{{ '/placeholder' | relative_url }}">Learn more about the differences between V1 and V2</a>.
</p>
{% endcapture %}

{%  include accordion.html id="a1" 
    heading="How can REACH ACOs access partially adjudicated claims data?" 
    expanded=true 
    bordered=false 
    accordionContent=a1AccordionContent %}

{%  include accordion.html id="a2" 
    heading="Do REACH ACOs on BCDA V1 need to update their credentials to access V2 for partially adjudicated claims data?" 
    expanded=false 
    bordered=false 
    accordionContent=a1AccordionContent %}


