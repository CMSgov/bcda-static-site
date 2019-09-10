---
layout: home
title:  "Beneficiary Claims Data API"
date:   2019-09-03 09:21:12 -0500
description: Shared Savings Program ACOs can use this FHIR-based API to retrieve bulk Medicare claims data related to their assignable or prospectively assigned beneficiaries.
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
sections:
  - Getting Started
  - Frequently Asked Questions
  - Bulk FHIR APIs at CMS

button:
  - title: Home
    link: "#"

  - title: Sandbox
    subcategories:
      - subtitle: "Getting Started"
        subhref: "#"
      - subtitle: "Tech Guide"
        subhref: "#"
      - subtitle: "Decryption"
        subhref: "#"

  - title: Production
    subcategories:
      - subtitle: "Getting Started"
        subhref: "#"
      - subtitle: "Tech Guide"
        subhref: "#"
      - subtitle: "Decryption"
        subhref: "#"

  - title: About the Data
    subcategories:
      - subtitle: "Data Dictionary/CCLF crosswalk"
        subhref: "#"
      - subtitle: "Working w/BCDA Data"
        subhref: "#"

---


# Overview

  The Beneficiary Claims Data API (BCDA) enables Accountable Care Organizations (ACOs) participating in the Shared Savings Program to retrieve Medicare Part A, Part B, and Part D claims data for their prospectively assigned or assignable beneficiaries. This includes Medicare claims data for instances in which beneficiaries receive care outside of the ACO, allowing a full picture of patient care. In the production environment, the API provides similar data to Claim and Claim Line Feed (CCLF) files, currently provided monthly to Shared Savings Program ACOs by CMS.
  Representatives of Shared Savings Program ACOs are now invited to express their interest in joining the production environment by sending an email to bcapi@cms.hhs.gov. While you wait to onboard in the production environment, we invite developers, analysts, and administrators at Shared Savings Program ACOs to try out the BCDA sandbox experience [Sandbox getting started guided](https://sandbox.bcda.cms.gov){:target="_blank"}.
  
   * **What’s the difference between the sandbox and production environments?** BCDA’s production environment provides actual patient claims data on an ACO’s prospectively assigned or assignable beneficiaries, while the sandbox uses the same API structure but contains no beneficiary PII or PHI.
   
   * **Why should my ACO try the sandbox first?** ACOs who have gotten used to working in the sandbox have found it easier to make the switch to the production environment. Since beneficiary claims data must be treated with the utmost care, the sandbox environment provides a lower-stress environment for making your first API calls before touching actual patient data.
   
   * **What about my ACO?** BCDA’s initial goal is to provide bulk beneficiary claims data that meets the needs of Shared Savings Program ACOs. In the months ahead, BCDA’s research team will begin learning about the data needs of Innovation Model ACOs, in order to begin accommodating those ACOs in the API  in the future. While the sandbox environment also focuses on the needs of Shared Savings Program ACOs, all ACOs and their vendor partners are invited to explore the sandbox and give their feedback.
   
## Getting Started

  Moving from the CCLF file structure to BCDA’s FHIR-based API is a fairly big change. BCDA provides documentation and user guides to help Shared Savings Program ACOs at any stage of technical understanding learn how to interact with the API and the data.

  * **If BCDA is going to be your first API:** start with the guide to [Getting Started in Sandbox](https://sandbox.bcda.cms.gov){:target="_blank"}.
  * **If you’ve worked with APIs before:** start with the Sandbox Technical Setup Guide [link to sandbox tech guide].
  * **To learn more about the new data structure BCDA will deliver:** review the [Guide to Working with BCDA Data](./data_guide.html){:target="_blank"}.
  * **To join the queue for an invitation to the production environment:** send an e-mail with your name and your SSP ACO’s name, ID number, and track to bcapi@cms.hhs.gov. We will onboard a few ACOs at a time in the order in which requests are received.

## Frequently Asked Questions

  * **Why is CMS making this change?**
    * By using a standards-based API, BCDA furthers CMS’ ongoing commitment to [MyHealthEData](https://www.cms.gov/newsroom/press-releases/cms-finalizes-changes-empower-patients-and-reduce-administrative-burden){:target="_blank"}, a government-wide initiative that emphasizes adopting an API-first approach to modernize how CMS exchanges data with stakeholders across the healthcare system.
    * CMS intends for BCDA to meet four main goals for SSP ACOs:
      * Improve ease of access to bulk beneficiary claims data data
      * Decrease the time for CMS to implement any required or requested updates to support the ACO program
      * Reduce burden on ACOs for changes to the data or data format
      * Enhance efficiency by enabling system-to-system communication and reducing the need for manual intervention to retrieve and manipulate the data
      
  * **Are CCLF files going away?**
    * CCLF files are not going away any time soon. CMS wants to make sure Shared Savings Program ACOs have ample time to work with both formats together and become familiar with the API.
  
  * **Why should my ACO use BCDA?**
    * Based on the goals above, CMS believes that SSP ACOs and their vendor partners will be better able to provide higher quality care to their beneficiaries at lower cost with BCDA.
      * SSP ACOs can retrieve bulk claims data on a weekly, rather than monthly, basis, at a time of their choosing.
      * BCDA allows system-to-system communication and data transfer, reducing the manual intervention currently required to retrieve CCLF files.
    * BCDA is built in accordance with feedback from SSP ACOs and their vendor partners. When you use BCDA in sandbox or production, you are invited to share feedback with CMS and ensure we are creating an API that meets your organization’s needs.
  
  * **Sounds great! Where do I start?** 
    * If your Shared Savings Program ACO is ready to start working with BCDA, the first step is to let us know you’re interested. BCDA will onboard ACOs to the production environment in the order in which they sign up.
    * While you wait, join the [BCDA Google Group](https://groups.google.com/forum/#!forum/bc-api){:target="_blank"} to learn how other ACOs are working with the API, try out the [sandbox environment](https://sandbox.bcda.cms.gov){:target="_blank"}, and get familiar with [how to translate between CCLF and BCDA data fields.](./data_guide.html){:target="_blank"}
   
  * **I’m a vendor who works with Shared Savings Program ACOs. How can I work with BCDA?**
  [need the CMS answer to this]
  
  * **There are so many new acronyms on this page. What do they mean?**
    * **API:** An API (Application Programming Interface) is a set of features and rules that exist inside a software program that allows other software programs to interact with it. For example, you can build an app that uses the Twitter API to get information or data from a user's Twitter account. APIs are used in a wide variety of ways, but for our purposes, you can think of an API as a pipeline that can allow your ACO’s computer systems to receive data directly from CMS’ databases.
    * **FHIR:** FHIR (Fast Healthcare Interoperability Resources) is a specification for exchanging healthcare data electronically, allowing any system to access and consume this data to solve clinical and administrative problems around healthcare-related data. BCDA is built on the Blue Button 2.0 API, which has structured its data using the FHIR standard. BCDA will use three endpoints from the FHIR specification: explanation of benefits, patient, and coverage. Learn more about FHIR in the [guide to working with BCDA data.](./data_guide.html){:target="_blank"}
    * **NDJSON:** [New Line Delimited JSON](http://ndjson.org){:target="_blank"} is the file format used by the bulk FHIR specification. An NDJSON file provides a single record on each line, which makes it easy for various tools to look at and process one record at a time before moving on to the next one. Our [About the Data](./data_guide.html){:target="_blank"} page provides more information on working with the NDJSON files you’ll receive through BCDA

## Bulk FHIR APIs at CMS

   BCDA is one member of a suite of FHIR APIs provided by CMS, which work together to provide claims data that enables higher-quality patient care.

#### [Blue Button 2.0:](https://bluebutton.cms.gov){:target="_blank"}
   * Provides FHIR-formatted data for one individual Medicare beneficiary at a time, to registered applications with beneficiary authorization.
   
#### Beneficiary Claims Data API (BCDA):
   * Uses the bulk FHIR specification to provide data files to an ACO for **all** of the beneficiaries a given Shared Savings Program ACO is eligible to receive.
   * BCDA does not require individual beneficiary authorization to send this information, though beneficiaries can opt out of having their data shared by calling 1800 Medicare.
   
#### [Data at the Point of Care (DPC) pilot:](https://dpc.cms.gov){:target="_blank"}
   * Provides FHIR-formatted bulk data files to **fee-for-service providers** for their active patients as needed for treatment purposes under HIPAA. 
   * Data at the Point of Care does not require individual beneficiary authorization but does allow a process for patients to opt out of data sharing.