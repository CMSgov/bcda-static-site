---
layout: announcement
page_title: "BCDA data limited in Jan 2026 for yearly updates"
description: "Requests for current or new BCDA claims data are paused in January 2026 for yearly updates."
show-side-nav: false
in-page-nav: true
lead_paragraph: "Requests for current or new BCDA claims data are paused in January 2026 for yearly updates."
published_date: 2025-12-03
---

Certain BCDA data is unavailable every January while CMS updates attributed beneficiaries for the new performance year (PY). Normal functionality will be restored to individual entities as soon as their data is ready. This typically takes 1 month. 

PY 2026 starts Jan 1, 2026 and ends Dec 31, 2026. 

## What data will be unavailable in Jan 2026?

Claims data with a service date in 2026 will be unavailable. Requests to `/Group/all` and `/Patient` endpoints will be disabled while we wait for updated attribution info for your model entity.

## How should I request PY 2025 runout data?

To request runout data for enrollees attributed to your organization in PY 2025:

* Use the `runout` identifier with the /Group endpoint. 
* Claims with a service date in 2026 will be excluded. Data returned will have a service date no later than December 31, 2025. 
* Use the [\_since parameter](/api-documentation/filter-claims-data.html#the-since-parameter) with the `runout` identifier to return data updated since your last runout request. [Review our documentation on the runout identifier](/api-documentation/filter-claims-data.html#the-runout-identifier-2). 

## How will I know when data is available again?

We’ll notify you in the [BCDA Google Group](https://groups.google.com/g/bc-api) when the limitation ends for each supported model. At that point, you can use the `all` identifier to request data, including 2026 claims, with the `/Group` and `/Patient` endpoints as usual.

## Examples of requests/outcomes to expect in Jan 2026

- A caller makes a request to the `/Patient` or `/Group` endpoint using the `all` identifier.
  - GET `/api/v2/Patient/$export`
  - GET `/api/v2/Group/all/$export`

- The caller receives a `404 Not Found` response and an `OperationOutcome` error.
  - An example `OperationOutcome.fhir.json` is attached. 
  - Callers should use the `/api/v2/Group/runout/$export` endpoint.

- A caller makes a request to the `/Group` endpoint using the `runout` identifier.
  - GET `/api/v2/Group/runout/$export`

- The caller receives a `202 Accepted` response.
  - Content-Location header sent with the job location.
  - `Content-Location: /api/v2/jobs/{job_id}`

- A caller polls the `/Jobs` endpoint until the job completes.
  - GET `/api/v2/jobs/{job_id}`

- The caller can now download the job data.
  - GET `/data/2/output.json`
  - All claims data will be capped at December 31, 2025.

## Need help?

Keep an eye on the [Google Group conversation](https://groups.google.com/g/bc-api) to ask questions and read updates about BCDA data availability. If you can’t find what you need, send an email to [bcapi@cms.hhs.gov](mailto:bcapi@cms.hhs.gov). 