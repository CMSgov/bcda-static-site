---
layout: announcement
page_title: "Normal data availability resumed for 2025 claims"
show-side-nav: false
in-page-nav: true
published_date: 2025-02-13
description: "Normal BCDA operations resume after end-of-year transition."
lead_paragraph: "Access to all PY 2025 data restored."
custom_excerpt: "Access to all PY 2025 data restored."
---

Now that annual maintenance is complete, you'll have access to all PY 2025 data using the `/Group/all` and `/Patient` endpoints. 
- **For your first PY 2025 data request** - Use the `all` identifier for any service date.
- **To request runout data from PY 2024** - Use the `runout` identifier separately with the `/Group` endpoint. This will return data for enrollees who were attributed to your organization in PY 2024, but not PY 2025.
  - Use the `_since` parameter in conjunction with the `runout` identifier to limit data to updates occurring since your last runout request.
  - The `runout` identifier will be updated each month up to and including July 2025. After July 2025, new data for enrollees who were attributed to your organization in PY 2024, but not PY 2025, will no longer be included.

Post or send any questions to the <a href="https://groups.google.com/g/bc-api" target="_blank" rel="nofollow noreferrer">Google Group</a> or contact [bcapi@cms.hhs.gov](mailto:bcapi@cms.hhs.gov).
