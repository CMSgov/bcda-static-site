---
layout: api-docs-v3
page_title: "Partially Adjudicated Claims Data"
seo_title: ""
description: "Get earlier access to Medicare enrollee data with BCDA partially adjudicated claims, now available as ExplanationOfBenefit resources in v3."
in-page-nav: true
feedback_id: "355f6ea6"
---

# {{ page.page_title }}

<div
  class="usa-summary-box"
  role="region"
  aria-labelledby="summary-box-key-information"
>
  <div class="usa-summary-box__body">
    <p
      class="usa-summary-box__heading font-ui-md text-bold"
      id="summary-box-key-information"
    >
      What's new in v3?
    </p>
    <div class="usa-summary-box__text">
      <ul>
        <li><a href="#what-s-in-partially-adjudicated-claims-data">Partially adjudicated claims data</a> are now
          represented with 1 FHIR resource type: ExplanationOfBenefit (EOB).</li>
        <li><a href="#how-do-i-know-when-a-claim-has-been-fully-processed">New elements and guidance</a> explain how to
          tell if claims are still processing and identify duplicates.</li>
      </ul>
    </div>
  </div>
</div>

## A faster way to access claims data

Medicare claims processing (adjudication) can take weeks. Through partially adjudicated claims, ACO REACH participants (REACH ACOs) receive patient data only 2-4 days after providers submit claims to Medicare. This helps them provide patients with more effective interventions, transitions, and coordination of care.

Fully adjudicated claims offer the same rich insights, with some small differences including a longer frequency.

### Comparison: partially and fully adjudicated claims

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
        Available to <a
          href="https://www.cms.gov/priorities/innovation/innovation-models/aco-reach"
          target="_blank"
          rel="noopener noreferrer"
        >ACO REACH</a> and <a
          href="https://www.cms.gov/priorities/innovation/innovation-models/iota"
          target="_blank"
          rel="noopener noreferrer"
        >IOTA</a> participants only
      </td>
      <td data-label="Fully adjudicated claims">
        Available to all <a href="{{ '/index.html#eligible-model-entities' | relative_url }}">eligible model
          entities</a>
      </td>
    </tr>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
        Requires BCDA v2 or v3
      </td>
      <td data-label="Fully adjudicated claims">
        Available in all BCDA versions
      </td>
    </tr>
    <tr scope="row">
      <td data-label="Partially adjudicated claims">
        Sourced from Medicare Shared Systems
      </td>
      <td data-label="Fully adjudicated claims">
        Sourced from National Claims History (NCH)
      </td>
    </tr>
  </tbody>
</table>


<div class="display-flex flex-align-center">
  <h3>What's in partially adjudicated claims data?</h3>
  {%- include updated-tag.html -%}
</div>

- In BCDA v3, partially adjudicated claims data:
  - Are represented with 1 FHIR resource type:
    - <a href="https://hl7.org/fhir/R4/explanationofbenefit.html" target="_blank" rel="noopener noreferrer">ExplanationOfBenefit (EOB)</a> - Information about the professional and institutional claims that providers submit for payment and information about a claim's adjudication status and processing results
  - Contain Part A and Part B data from the current performance year and historical claims data from the previous 2 or more performance years, depending on your organization’s Alternative Payment Model.
- In BCDA v2, partially adjudicated claims data:
  - Are represented with 2 FHIR resource types:
    - <a href="https://hl7.org/fhir/R4/claim.html" target="_blank" rel="noopener noreferrer">Claim</a> - Information about the professional and institutional claims that providers submit for payment (including the services that enrollees receive)
    - <a href="https://hl7.org/fhir/R4/claimresponse.html" target="_blank" rel="noopener noreferrer">ClaimResponse</a> - Information about a claim's adjudication status and processing results
  - Contain Part A and Part B data (excluding Durable Medical Equipment) with updates from the past 60 days


### What's in fully adjudicated claims data?
{: .margin-top-4}

In all versions of BCDA, adjudicated claims data:
- Are represented with 3 FHIR resource types:
  - <a href="https://hl7.org/fhir/R4/patient.html" target="_blank" rel="noopener noreferrer">Patient</a> - Enrollees' demographic details and updates to their patient identifiers.
  - <a href="https://hl7.org/fhir/R4/coverage.html" target="_blank" rel="noopener noreferrer"> Coverage</a> - Enrollees' insurance coverage details, including dual coverage.
  - <a href="https://hl7.org/fhir/R4/explanationofbenefit.html" target="_blank" rel="noopener noreferrer"> ExplanationOfBenefit</a> - Details for episodes of care, including where and when the service was performed, diagnosis codes, provider, and cost of care.
- Contain Part A, Part B, and Part D data from the current performance year and historical claims data from the previous 2 or more performance years, depending on your organization's Alternative Payment Model

<div class="display-flex flex-align-center margin-top-4">
  <h3>How do I know when a claim has been fully processed?</h3>
  {%- include new-tag.html -%}
</div>

All EOBs contain the <a href="https://hl7.org/fhir/R4/explanationofbenefit-definitions.html#ExplanationOfBenefit.outcome" target="_blank" rel="noopener noreferrer">ExplanationOfBenefit.outcome</a> element which will indicate if the claim is still processing. If you wish to include only EOBs that have been fully processed and paid in your job requests, see our guidance on <a href="{{ '/v3/filter-claims-data-v3.html#the-typefilter-parameter' | relative_url }}">filtering claims by final action status using _typeFilter</a>.

#### De-duplicating claims and identifying duplicates

To de-duplicate an enrollee's claims, the `CLM-CNTL-NUM` identifier `ExplanationOfBenefit.identifier.where('system'='https://bluebutton.cms.gov/fhir/CodeSystem/CLM-CNTL-NUM')` can be used to identify which claims are the same within a claim type. Additionally, if a claim receives a new claim control number, the previous claim control number will be available in ExplanationOfBenefit.related, and can be used to de-duplicate claims even if the claim control number has changed.

There may be some instances in which a claim can't be de-duplicated via `CLM-CNTL-NUM`. Review the <a href="https://github.com/CMSgov/beneficiary-fhir-data/wiki/v2-%E2%80%90-v3-Migration-Guide#deduplicating-claims-and-identifying-duplicates" target="_blank" rel="noopener noreferrer">Beneficiary FHIR Data server (BFD) guide</a> for further strategies on deduplicating claims.

## Get started with partially adjudicated claims data

Access partially adjudicated claims data in the <a href="{{ '/api-documentation/get-a-bearer-token.html#partially-adjudicated-claims-data-sets' | relative_url }}">BCDA Sandbox</a>.

Review the <a href="{{ '/assets/downloads/BCDA_v3_Data_Dictionary.xlsx' | relative_url }}" data-tealium="download">Data Dictionary {% include sprite.html icon="file_download" class="text-middle"%}</a> for a complete list and description of the data fields.

## Use cases

### Example 1: Improve transition of care

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can check if post-discharge processes are in place for
  an attributed enrollee shortly after a hospital discharge. Benefits include reduced readmissions and healthcare costs.
</p>

On May 1, 2022, Mrs. Gonzales is doing better after a bout of pneumonia and is released home from the hospital. The hospital submits a claim for her stay to Medicare on May 3, 2022.

1. BCDA receives partially adjudicated claims data that reflects this update. This is identified by a Document Control Number (DCN) within a few days.
2. A REACH ACO sets up a dashboard to track newly identified discharges. After receiving an automated care-coordination alert for Mrs. Gonzales, they're able to follow up on her post-discharge care in a timely manner.
3. Using supplemental data, the REACH ACO adds filters to the dashboard for parameters of interest like whether the discharging hospital is in-network.
4. BCDA will reflect any status changes to the claim, for example if Mrs. Gonzales' claim is returned to the provider or adjusted.
5. These changes may involve updates to key variables used for care coordination, like diagnosis codes. The claims data will indicate the final status once a claim finishes adjudication and is submitted for payment.
6. BCDA's adjudicated data will pick up this claim after several additional processing steps. This is typically up to 14 days after adjudication.

REACH ACOs can also flag and identify patients who have a high risk of readmission based on factors like past diagnosis. Early access to claims data can help reduce readmissions and healthcare costs.

### Example 2: Identify opportunities for intervention

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can monitor outpatient events for follow-up care and
  track patterns that often indicate future utilization. The data can be used to target case management and deliver
  clinically appropriate follow-up care. Additionally it can help reduce the volume of unnecessary procedures.</p>

On September 6, 2022, Mr. Fritz underwent a duplex scan to evaluate for carotid artery stenosis. The cardiology clinic submits a claim for this procedure to Medicare on September 8, 2022.

1. BCDA receives partially adjudicated claims data that reflects this update. This is identified by a Claim Control Number in a few days.
2. A REACH ACO creates a dashboard to track procedures that merit review. Mr. Fritz's service is flagged because it signals the surgeon may be planning a carotid endarterectomy procedure.
3. However, if Mr. Fritz does not have neurological symptoms, this procedure may not be a recommended course of action. The REACH ACO is able to activate protocols to alert Mr. Fritz's primary care provider for intervention.
4. As with example 1, BCDA will reflect any status changes to the claim.
5. Similarly, BCDA's adjudicated data will pick up this claim.

REACH ACOs can also track performance on cases where the care may be of limited value. For example, if Mr. Fritz does not have neurologic symptoms, then this kind of scan has been indicated to be more harmful than beneficial. This information could be used by the REACH ACO to reduce the volume of unnecessary procedures.

### Example 3: Enhance care coordination

<p class="usa-intro font-ui-md text-italic text-base">REACH ACOs can learn more about their patients' health histories, build their clinical profiles, and improve care coordination.</p>

Ms. Thompson began treatment for breast cancer on March 8, 2023. She is experiencing nausea and dehydration as a result of chemotherapy. While visiting family on March 14, she drove to an emergency room (ER) 50 miles from home. She was treated with IV fluids and nausea medication.

1. BCDA receives partially adjudicated claims data that reflects this update. This is identified by a Claim Control Number in a few days.
2. This emergency room visit may provide useful insights into Ms. Thompson's health history and chemotherapy journey. If Ms. Thompson is experiencing symptoms, her plan of treatment may need to be adjusted moving forward.
3. REACH ACOs can track procedures and services, including those from a different system, to get a holistic view of patients' health histories. They can then follow up with the patient and/or provider to improve care coordination.

REACH ACOs can also monitor the rate of emergency services used by patients undergoing active cancer treatment and following transplantation.

In the past, it would take weeks to know whether patients received care outside the network. Partially adjudicated claims data allows REACH ACOs to more quickly identify and investigate out-of-network care.

## Additional resources

- <a href="https://www.medicare.gov/what-medicare-covers" target="_blank" rel="noopener noreferrer">Services covered by Medicare Parts A and B</a>
- <a href="https://4innovation.cms.gov/secure/knowledge-management/view/341" target="_blank" rel="noopener noreferrer">Fee-for-Service (FFS) Claims Processing</a> (requires 4i access)
- <a href="https://4innovation.cms.gov/secure/knowledge-management/view/491" target="_blank" rel="noopener noreferrer">Reporting and Data Sharing Overview</a> (requires 4i access)