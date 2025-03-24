---
layout: default
page_title: "About BCDA"
seo_title: ""
description: ""
permalink: /about
show-side-nav: false
---

<div class="grid-row grid-gap-4 flex-align-center">
  <div class="tablet:grid-col-5 tablet:order-2 padding-y-2">
    <img src="{{ '/assets/img/data-consult.svg' | relative_url }}" alt="data consult illustration" class="padding-x-4"/>
  </div>
  <div class="tablet:grid-col tablet:order-1" >
    <h1>{{ page.page_title }}</h1>
    <p>
        Beneficiary Claims Data API (BCDA) was released in February 2019 to share Medicare Parts A, B, and D data, including from <a href="{{ '/placeholder' | relative_url }}"> partially adjudicated claims</a>.
    </p>
    <p>
        BCDA allows <a href="{{ '/index#eligible-model-entities' | relative_url }}">eligible model entities</a> to track performance metrics, identify high-risk patients sooner, and improve transition of care.
    </p>
  </div>
</div>

<table class="usa-table usa-table--borderless usa-table--stacked">
      <caption class="usa-sr-only">Definitions of Part A and Part B claims data</caption>
      <thead>
        <tr>
          <th scope="col">Data type</th>
          <th scope="col">Definition</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">Medicare Part A claims data</th>
          <td>
            inpatient hospital stays, care in skilled nursing facilities, and hospice care
          </td>
        </tr>
        <tr>
          <th scope="row">Medicare Part B claims data</th>
          <td>
            various doctors' services, outpatient care, medical supplies, and preventive services
          </td>
        </tr>
        <tr>
          <th scope="row">Medicare Part D claims data</th>
          <td>
            prescription drugs prescribed by healthcare providers          
          </td>
        </tr>
      </tbody>
    </table>

## Claims data process

<ol class="usa-process-list">
    <li class="usa-process-list__item">
        <h4 class="usa-process-list__heading">Medicare enrollee receives care</h4>
    </li>
    <li class="usa-process-list__item">
        <h4 class="usa-process-list__heading">Provider submits Medicare claim</h4>
    </li>
    <li class="usa-process-list__item">
        <h4 class="usa-process-list__heading">BCDA shares partially adjudicated claims data </h4>
        <p class="usa-intro font-ui-md text-bold text-color-gray-40">2-4 days after submission</p>
        <p>
            Partially adjudicated claims haven’t been fully processed and approved yet. BCDA updates this data daily from the Fiscal Intermediary Standard System (FISS) and Multi-Carrier System (MCS). 
        </p>
  </li>
</ol>


## What are the other CMS claims-based FHIR APIs?

<ul class="usa-card-group flex-justify-center padding-y-4">
    <li class="usa-card tablet-lg:grid-col-6 widescreen:grid-col-4">
    <div class="usa-card__container">
      <div class="usa-card__header">
        <h4 class="usa-card__heading">Card with Media</h4>
      </div>
      <div class="usa-card__media">
        <div class="usa-card__img">
          <img
            src="https://designsystem.digital.gov/img/introducing-uswds-2-0/built-to-grow--alt.jpg"
            alt="A placeholder image"
          />
        </div>
      </div>
      <div class="usa-card__body">
        <p>
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis earum
          tenetur quo cupiditate, eaque qui officia recusandae.
        </p>
      </div>
      <div class="usa-card__footer">
        <a href="#" class="usa-button">Visit Florida Keys</a>
      </div>
    </div>
  </li>
</ul>
