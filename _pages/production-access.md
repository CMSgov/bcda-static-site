---
layout: api-docs
page_title: "Production Access"
seo_title: ""
description: ""
permalink: /production-access
in-page-nav: true
in-page-nav-levels: "h2"
show-side-nav: false
---

# {{ page.page_title }}

[Eligible organizations]({{ '/index#eligible-model-entities' | relative_url }}) must get credentials from their model-specific systems to access enrollee claims data. 

**Before accessing the production environment, download test claims data in the sandbox environment and follow the steps in [API Documentation]({{ '/api-documentation' | relative_url }}).**

<ol class="usa-process-list margin-top-4">
  <li class="usa-process-list__item">
    <h2 class="usa-process-list__heading margin-y-2">Authorize your model entity</h2>
      <p>
        Production credentials authorize your organization’s access to the API. Create and manage credentials by logging into your model-specific system:
      </p>
      <ul>
        <li>
            <strong>ACOs in the Medicare Shared Savings Program:</strong> Credential delegates can manage credentials from the <a href="https://acoms.cms.gov/api-key-mgmt/bcda" target="_blank" rel="noopener">ACO Management System (ACO-MS)</a>.
        </li>
        <li>
            <strong>REACH ACOs and KCEs or KCF practices in the Kidney Care Choices Model:</strong> The following roles can manage credentials from <a href="https://4innovation.cms.gov/secure/api-credentials/bcda" target="blank" rel="noopener">4innovation (4i)</a>:
        </li>
        <ul>
            <li>Executive Contact </li>
            <li>Entity Primary Contact </li>
            <li>Entity Secondary Contact </li>
            <li>DUA Requestor </li>
            <li>DUA Custodian</li>
        </ul>
      </ul>
      <p>Your registered contact can <a href="https://www.cms.gov/data-research/cms-information-technology/cms-identity-management/help-desk-support" target="blank" rel="noopener">contact the help desk</a> to assign these roles.</p>
  </li>
  <li class="usa-process-list__item">
    <h2 class="usa-process-list__heading margin-y-2">Obtain production credentials</h2>
    <ol>
        <li>Visit the <em>API Credentials</em> page in your model-specific system. </li>
        <li>Choose the <em>BCDA Credentials</em> tab, then select Create New API Credentials.</li>
        <li>Add a public, static IP address for every system, including vendors, that will use the API (up to 8). It may take up to an hour for the allow list to update.</li>
    </ol>
    <h3 class="font-ui-sm">Rotate (renew) credentials every 90 days</h3>
    <p class="margin-top-05">Visit BCDA Credentials and select the rotate icon in the <em>Actions</em> column.</p>
    <h3 class="font-ui-sm">Revoke (deactivate) credentials if compromised</h3>
    <p class="margin-top-05">Visit BCDA Credentials and select the delete icon in the <em>Actions</em> column. Email <a href="mailto:bcapi@cms.hhs.gov" target="blank" rel="noopener">bcapi@cms.hhs.gov</a> to review recent activity.</p>
  </li>
  <li class="usa-process-list__item">
    <h2 class="usa-process-list__heading margin-y-2">Access production claims data</h2>
      <p>
        The sandbox and production environments support the same workflow, endpoints, and resource types. Follow similar steps as you did in the sandbox to <a href="{{ '/get-a-bearer-token' | relative_url }}">get a bearer token</a> and <a href="{{ '/access-claims-data' | relative_url }}">retrieve claims data</a>.
      </p>
      <p>
        Visit <a href="{{ '/support' | relative_url }}">Support</a> or <a href="https://groups.google.com/forum/#!forum/bc-api" target="blank" rel="noopener">join the Google Group</a> if you have questions. Do not share <a href="{{ '/placeholder' | relative_url }}">Personally Identifiable Information (PII)</a> like tokens, credentials, or claims data. 
      </p>
  </li>
</ol>
