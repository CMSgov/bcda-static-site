---
layout: base
page_title: "BCDA API"
show-side-nav: false
---

<main id="main-content">
  <div class="usa-section--dark bg-primary bg-primary-gradient">
    <div class="grid-container padding-y-8">
      <h1 class="hero-title font-body-3xl measure-1 margin-bottom-0 line-height-sans-2 text-semibold text-balance">
          Improve Care Coordination with Medicare Claims Data
      </h1>
      <p class="hero-paragraph line-height-sans-4 measure-5">
      The Beneficiary Claims Data Application Programming Interface (BCDA) gives eligible model entities access to their attributed enrollees’ Medicare Parts A, B, and D claims data, including data from any care received outside their organization.
      </p>
      <div class="grid-row grid-gap margin-top-2">
        <div class="tablet:grid-col-auto margin-top-2">
          <a href="{{ '/api-documentation' | relative_url }}" class="hero-button usa-button usa-button--inverse usa-button--outline width-full">
            Get Started
            {% include sprite.html icon="arrow_forward" size="3" %}
          </a>
        </div>
        <div class="tablet:grid-col-auto margin-top-2">
          <a href="https://github.com/CMSgov/bcda-app" target="_blank" rel="noopener" class="hero-button usa-button usa-button--inverse usa-button--outline width-full">
            Code Repo
            {% include sprite.html icon="github" size="3" %}
          </a>
        </div>
      </div>
    </div>
  </div>
  
  <div class="minw-15 padding-y-6 padding-x-3 grid-container">
    <div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-y-7">
      <div class="tablet:grid-col display-flex flex-align-center tablet:flex-justify-center">
        <img class="width-auto height-full" src="{{ '/assets/img/support-home.svg' | relative_url }}" alt="Illustration of 3 people helping each other climb to the top of increasingly taller platforms" />
      </div>
      <div class="tablet:grid-col padding-top-4 tablet:padding-top-0 display-flex flex-align-center">
        <div>
          <h2>Eligible model entities</h2>
          <p>BCDA supports organizations participating in the following <a href="https://www.cms.gov/priorities/innovation/about/alternative-payment-models" target="_blank" rel="noopener">Alternative Payment Models</a>:</p>
          <ul>
            <li><a href="https://www.cms.gov/medicare/payment/fee-for-service-providers/shared-savings-program-ssp-acos" target="_blank" rel="noopener">Medicare Shared Savings Program</a></li>
            <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/kidney-care-choices-kcc-model" target="_blank" rel="noopener">Kidney Care Choices Model</a></li>
            <li><a href="https://www.cms.gov/priorities/innovation/innovation-models/aco-reach" target="_blank" rel="noopener">Accountable Care Organizations Realizing Equity, Access, and Community Health Model</a></li>
          </ul>
        </div>
      </div>
    </div>
    <!--  -->
    <div class="padding-y-7">
      <h2>Use cases for BCDA</h2>
      <div class="usa-graphic-list__row grid-row tablet:grid-gap-6 padding-y-2">
        <div class="tablet:grid-col-6 padding-y-3 tablet:display-flex">
          <div>{% include sprite.html icon="people" size="8" %}</div>
          <div class="tablet:margin-left-2">
            <h3 class="margin-y-1">
              Target MTM program enrollees
            </h3>
            <p>
              Identify Medication Therapy Management (MTM) enrollees by using data for a more thorough search capability.
            </p>
          </div>
        </div>
        <div class="tablet:grid-col-6 padding-y-3 tablet:display-flex">
          <div>{% include sprite.html icon="insights" size="8" %}</div>
          <div class="tablet:margin-left-2">
            <h3 class="margin-y-1">
              Get claims data faster
            </h3>
            <p>
              Model entities eligible for <a href="{{ '/placeholder' | relative_url }}">partially adjudicated claims data</a> have early access to claims as soon as 2-4 days after Medicare submission.
            </p>
          </div>
        </div>
         <div class="tablet:grid-col-6 padding-y-3 tablet:display-flex">
            <div>{% include sprite.html icon="security" size="7" %}</div>
            <div class="tablet:margin-left-2">
              <h3 class="margin-y-1">Provide value-based care</h3>
              <p>
                Identify suspicious activity from providers or suppliers through access to mass data.
              </p>
            </div>
        </div>
        <div class="tablet:grid-col-6 padding-y-3 tablet:display-flex">
          <div>{% include sprite.html icon="security" size="7" %}</div>
          <div class="tablet:margin-left-2">
            <h3 class="margin-y-1">Receive standardized claims data</h3>
            <p>
              Get claims data that follows the <a href="https://hl7.org/fhir/R4/overview.html">HL7 Healthcare Interoperability Standard</a> required by Centers for Medicare & Medicaid Services (CMS).
            </p>
          </div>
        </div>
      </div>
    </div>
    <!--  -->
    <div class="grid-row grid-gap-4 desktop:grid-gap-6 padding-y-7">
      <div class="tablet:order-last tablet:grid-col display-flex flex-align-center tablet:flex-justify-center">
        <img class="width-auto height-full" style="object-fit: contain;" src="{{ '/assets/img/understanding-the-data.svg' | relative_url }}" alt="Illustration of two people collaborating using a laptop and discussing data, charts, and communication." />
      </div>
      <div class="tablet:grid-col padding-top-4 tablet:padding-top-0 display-flex flex-align-center">
        <div>
          <h2>Using the data</h2>
          <p>BCDA is an Application Programming Interface (API) that updates enrollee claims data at least once a week. Data is provided in NDJSON format and includes:</p>
          <ul>
            <li>Medicare enrollee identifiers</li>
            <li>diagnosis codes</li>
            <li>dates and times of service</li>
          </ul>
          <p><a href="{{ '/bcda-data' | relative_url }}" class="usa-button usa-button--unstyled">Learn about the data {% include sprite.html icon="arrow_forward" %}</a></p>
        </div>
      </div>
    </div>
  </div>
</main>
