---
layout: default
page_title: "About BCDA"
seo_title: ""
description: "Learn about BCDA claims data. Organizations participating in Alternative Payment Models use BCDA to aid in care coordination and risk prediction."
show-side-nav: false
---

<div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-y-7">
  <div class="tablet:order-last tablet:grid-col display-flex flex-align-center tablet:flex-justify-center">
        <img class="width-auto height-full" style="object-fit: contain;"
        src="{{ '/assets/img/data-consult.svg' | relative_url }}" 
        alt="data consult illustration"/>
  </div>
  <div class="tablet:grid-col-auto padding-top-4 tablet:padding-top-0 display-flex flex-align-center">
    <div>
      <h1>{{ page.page_title }}</h1>
      <p>
        Beneficiary Claims Data API (BCDA) was released in February 2019 to share Medicare claims data with Accountable Care Organizations (ACOs) and other <a href="{{ '/index.html#eligible-model-entities' | relative_url }}">eligible model entities</a>. 
      </p>
      <p>
        Similar to <a href="https://www.cms.gov/files/document/cclf-information-packet.pdf" target="blank" rel="noopener noreferrer">Claim and Claim Line Feed (CCLF) files</a>, BCDA offers Medicare Parts A, B, and D data, but with some key differences in formatting and update frequency. <a href="{{ '/bcda-data/comparison-bcda-cclf-files.html' | relative_url }}">Read more about using one or both data sources</a>, or map data between sources using the <a href="{{ '/assets/downloads/BCDA_Data_Dictionary.xlsx' | relative_url }}">Data Dictionary {% include sprite.html icon="file_download" class="text-middle" size="2" %}</a>.
      </p>
    </div>
  </div>
</div>

## Claims data process

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
          Partially adjudicated claims haven’t been fully processed and approved yet. BCDA updates this data daily from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS). 
        </p>
    </li>
    <li class="usa-process-list__item">
        <h3 class="usa-process-list__heading">Medicare approves the claims</h3>
    </li>
      <li class="usa-process-list__item about-final-item">
        <h3 class="usa-process-list__heading">BCDA shares adjudicated claims data </h3>
        <p class="usa-intro font-ui-md text-bold text-italic text-base margin-top-1">Typically 14 days after submission</p>
        <p>
          BCDA updates adjudicated claims data weekly from the <a href="https://www2.ccwdata.org/web/guest/home" target="_blank" rel="noopener noreferrer">Chronic Conditions Data Warehouse (CCW)</a>.
        </p>
    </li> 
</ol>

<h2 class="margin-top-8">Access partially adjudicated claims data with BCDA</h2>

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

Read <a href="{{ '/bcda-data/partially-adjudicated-claims-data.html' | relative_url }}">the guide to partially adjudicated claims and their use cases</a> to learn more.

<h2 class="margin-top-10 padding-top-2">What are the other CMS claims-based FHIR APIs?</h2>

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
          <h3 class="usa-card__heading">Blue Button 2.0</h3>
        </div>
        <div class="usa-card__media usa-card__media--inset">
          <div class="usa-card__img text-center">
            <img
              src="{{ '/assets/img/logo-bluebutton.svg' | relative_url }}"
              alt="AB2D logo"
              class="maxw-15 margin-x-auto"
            />
          </div>
        </div>
        <div class="usa-card__body">
          <p>
            The Blue Button 2.0 (BB2.0) API enables enrollees to connect their Medicare claims data to the applications, services, and research programs they trust.
          </p>
        </div>
        <div class="usa-card__footer">
          <a href="https://bluebutton.cms.gov/" target="_blank" rel="noopener noreferrer" class="usa-button">Visit BB2.0</a>
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

{% include feedback-form.html url="7d0c54c6" %}
