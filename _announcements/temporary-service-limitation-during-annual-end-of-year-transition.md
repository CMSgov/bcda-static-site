---
layout: announcement
page_title: "Temporary service limitation during annual end-of-year transition"
show-side-nav: false
in-page-nav: true
published_date: 2024-12-03
description: "BCDA unavailable between Jan 1, 2025 and Feb 13, 2025 due to end-of-year transition."
lead_paragraph: "Some data unavailable between Jan 1, 2025 and February 13, 2025 during end-of-year maintenance."
custom_excerpt: "Some data unavailable between Jan 1, 2025 and February 13, 2025 during end-of-year maintenance."
---

Current or new claims data will be unavailable between January 1, 2025 and February 13, 2025 due to yearly maintenance. 

This limitation occurs while CMS updates attribution for the new performance year (PY 2025). 

Data will be available again after BCDA receives each organization’s attribution information for PY 2025.

## Temporary data limitations starting 01/2025

- You will only be able to request runout data from BCDA from PY 2024. Use the `runout` identifier with the `/Group` endpoint to return data for enrollees attributed to your organization in PY 2024. 
  - Claims with a service date in 2025 will be excluded. The claims returned will have a service date no later than December 31, 2024. 
  - You can use the [_since parameter]({{ "/api-documentation/filter-claims-data.html#the-_since-parameter" | relative_path}}) with the runout identifier to limit data to updates occurring since your last runout request.
  - Review our documentation and example requests for runout data. 
- You won’t be able to make requests to the `/Group/all` or `/Patient` endpoints. These requests will result in an OperationOutcome error.

Normal functionality will be restored to individual entities as soon as their data is ready. This typically takes 1 month. At that point, you can use the all identifier to request data, including 2025 claims, with the `/Group` and `/Patient` endpoints as usual.

## Example requests and outcomes using BCDA in January 2025
- A caller makes a request to the /Patient or /Group endpoint using the `all` identifier.
  - **GET** `/api/v2/Patient/$export`
  - **GET** `/api/v2/Group/all/$export`
- The caller receives an OperationOutcome error.
  - An example OperationOutcome.fhir.json is attached. Callers should use the `/api/v2/Group/runout/$export` endpoint.
- A caller makes a request to the /Group endpoint using the runout identifier.
  - **GET** `/api/v2/Group/runout/$export`
- The caller receives a 202 Accepted response.
  - Content-Location header sent with the job location:
    - `Content-Location: /api/v2/jobs/2`
- A caller polls the /Jobs endpoint until the job completes.
  - **GET** `/api/v2/jobs/2`
- The caller can now download the job data.
  - **GET** `/data/2/output.json`
  - All claims data will be capped at December 31, 2024.

We’ll post an update here and in the Google Group when the limitation ends for each supported model. Thanks for your patience!

Post or send any questions to the <a href="https://groups.google.com/g/bc-api" target="_blank" rel="nofollow noreferrer">Google Group</a> or contact [bcapi@cms.hhs.gov](mailto:bcapi@cms.hhs.gov).