---
layout: default
page_title: "About BCDA"
seo_title: ""
description: "Learn about BCDA claims data. Organizations participating in Alternative Payment Models use BCDA to aid in care coordination and risk prediction."
show-side-nav: false
feedback_id: "7d0c54c6"
---

<div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-top-7">
  <div class="desktop:order-last desktop:grid-col-4 display-flex flex-align-center desktop:flex-justify-center">
    <img class="width-auto height-full" style="object-fit: contain;"
      src="{{ '/assets/img/data-consult.svg' | relative_url }}" 
      alt=""
    />
  </div>
  <div class="desktop:grid-col-8 padding-top-4 desktop:padding-top-0 display-flex flex-align-center">
    <div>
      <h1>{{ page.page_title }}</h1>
      <p class="usa-intro">Healthcare innovation to support value-based care</p>
      <p class="usa-intro">Every claim submitted to Medicare contains parts of a bigger story. These insights can get lost as patients move through a complex healthcare system.</p>
      <p>
        Beneficiary Claims Data API (BCDA) helps organizations participating in <a href="https://www.cms.gov/priorities/innovation/about/alternative-payment-models" target="_blank" rel="noopener">Alternative Payment Models</a> reach <a href="https://www.cms.gov/priorities/innovation/key-concepts/value-based-care" target="_blank" rel="noopener">value-based care</a> incentives through accountable, integrated, and person-centered care. 
      </p>
      <p>
        BCDA is an Application Programming Interface (API) that helps organizations integrate Medicare claims data into their tracking, reporting, and performance systems. When providers learn about services their patients receive across the healthcare landscape, they provide more coordinated care. 
      </p>
    </div>
  </div>
</div>

##  What’s in the data

Similar to [Claim and Claim Line Feeds (CCLF)](https://www.cms.gov/files/document/cclf-information-packet.pdf), [BCDA data]({{ '/bcda-data' | relative_url }}) offers Medicare Parts A, B, and D data, but with key differences in file formatting and update frequency based partly on its foundation in [Fast Healthcare Interoperability Resources](https://hl7.org/fhir/) (FHIR). FHIR standardizes data delivery into more universal categories that are easier for different systems to absorb and understand.

Learn more about [using BCDA and CCLF files]({{ '/bcda-data/comparison-bcda-cclf-files' | relative_url }}) and mapping data between them with the [Data Dictionary]({{ '/bcda-data#data-dictionary' | relative_url }}).

## How BCDA fits into the claims data process

<ol class="usa-process-list margin-top-2 about-process-list">
  <li class="usa-process-list__item about-connector">
      <h3 class="usa-process-list__heading">Medicare enrollee receives care</h3>
  </li>
  <li class="usa-process-list__item">
      <h3 class="usa-process-list__heading">Provider submits Medicare claim</h3>
  </li>
  <li class="usa-process-list__item">
      <h3 class="usa-process-list__heading">BCDA shares partially adjudicated claims data </h3>
      <p class="usa-intro font-ui-md text-bold text-italic text-base margin-top-1">2-4 days after submission</p>
      <p>
        Partially adjudicated claims haven’t been fully processed and approved yet. BCDA updates this data daily from the Integrated Data Repository (IDR).
      </p>
  </li>
  <li class="usa-process-list__item">
      <h3 class="usa-process-list__heading">Medicare approves the claims</h3>
  </li>
  <li class="usa-process-list__item about-final-item">
    <h3 class="usa-process-list__heading">BCDA shares adjudicated claims data </h3>
    <p class="usa-intro font-ui-md text-bold text-italic text-base margin-top-1">Typically 14 days after submission</p>
    <p>
      BCDA receives updated adjudicated claims data from the IDR every weekend. In the event of a delay, we'll make an announcement in the <a href="https://groups.google.com/g/bc-api" target="_blank" rel="noopener noreferrer">BCDA Google Group</a> with updates on when the data will be refreshed.
    </p>
  </li> 
</ol>

### Improving timeliness with access to claims during processing

Normally, access to Parts A, B, and D data can be delayed during claims processing (adjudication). BCDA lets provider organizations see "partially-adjudicated" data before waiting for the process to complete.

Read the guide to [partially adjudicated claims]({{ '/bcda-data/partially-adjudicated-claims-data' | relative_url }}) and their use cases to learn more about:

- Update frequency
- Resource types
- Eligible organizations
- Data Dictionary

## Continuing innovation: BCDA v3

BCDA v3 consolidates data sources and FHIR conformance to help organizations reduce administrative friction, improve data quality, provide a better user experience, and more effectively realize the standardization benefits of FHIR interoperability.

## Expanding reach to new models

BCDA continues to grow in availability. In 2026, its reach expanded to include the [ACCESS (Advancing Chronic Care with Effective, Scalable Solutions)](https://www.cms.gov/priorities/innovation/innovation-models/access), [GUIDE (Guiding an Improved Dementia Experience)](https://www.cms.gov/priorities/innovation/innovation-models/guide), and [IOTA (Increasing Organ Transplant Access)](https://www.cms.gov/priorities/innovation/innovation-models/iota) models. As organizations within these models adopt BCDA, they’ll join an existing user community encompassing [ACO REACH](https://www.cms.gov/priorities/innovation/innovation-models/aco-reach), [KCC](https://www.cms.gov/priorities/innovation/innovation-models/kidney-care-choices-kcc-model), and [SSP](https://www.cms.gov/medicare/payment/fee-for-service-providers/shared-savings-program-ssp-acos) participants. 

## What are the other CMS claims-based FHIR APIs?

<ul class="usa-card-group flex-justify-center padding-y-4">
  <li class="usa-card tablet:grid-col-6 desktop:grid-col-4">
    <div class="usa-card__container">
      <div class="usa-card__header">
        <h3 class="usa-card__heading">Claims Data to Part D Sponsors</h3>
      </div>
      <div class="usa-card__media usa-card__media--inset">
        <div class="usa-card__img text-center">
          <img
            src="{{ '/assets/img/logo-ab2d-sm.svg' | relative_url }}"
            alt="AB2D logo"
            class="maxw-15 margin-x-auto"
          />
        </div>
      </div>
      <div class="usa-card__body">
        <p>
          The AB2D API provides stand-alone Prescription Drug Plan sponsors with claims data to enhance the use of medication and improve the long term health of enrollees.
        </p>
      </div>
      <div class="usa-card__footer">
        <a href="https://ab2d.cms.gov/" target="_blank" rel="noopener noreferrer" class="usa-button">Visit AB2D</a>
      </div>
    </div>
  </li>
  <li class="usa-card tablet:grid-col-6 desktop:grid-col-4">
    <div class="usa-card__container">
      <div class="usa-card__header">
        <h3 class="usa-card__heading">Blue Button</h3>
      </div>
      <div class="usa-card__media usa-card__media--inset">
        <div class="usa-card__img text-center">
          <img
            src="{{ '/assets/img/logo-bluebutton.svg' | relative_url }}"
            alt="Blue button logo"
            class="maxw-15 margin-x-auto"
          />
        </div>
      </div>
      <div class="usa-card__body">
        <p>
          The Blue Button API enables enrollees to connect their Medicare claims data to the applications, services, and research programs they trust.
        </p>
      </div>
      <div class="usa-card__footer">
        <a href="https://bluebutton.cms.gov/" target="_blank" rel="noopener noreferrer" class="usa-button">Visit Blue Button</a>
      </div>
    </div>
  </li>
  <li class="usa-card tablet:grid-col-6 desktop:grid-col-4">
    <div class="usa-card__container">
      <div class="usa-card__header">
        <h3 class="usa-card__heading">Data at the Point of Care</h3>
      </div>
      <div class="usa-card__media usa-card__media--inset">
        <div class="usa-card__img text-center">
          <img
            src="{{ '/assets/img/logo-dpc.svg' | relative_url }}"
            alt="DPC logo"
            class="maxw-15 margin-x-auto"
          />
        </div>
      </div>
      <div class="usa-card__body">
        <p>
          The Data at the Point of Care (DPC) API enables healthcare providers with claims data to fill in gaps in patient history at the point of care and deliver high-quality care to Medicare enrollees.
        </p>
      </div>
      <div class="usa-card__footer">
        <a href="https://dpc.cms.gov/" target="_blank" rel="noopener noreferrer" class="usa-button">Visit DPC</a>
      </div>
    </div>
  </li>
</ul>

{% include feedback-form.html id=page.feedback_id %}
