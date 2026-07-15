---
layout: announcement
page_title: "End of BCDA data limitations"
description: "Performance year (PY) 2026 data is now accessible."
show-side-nav: false
in-page-nav: true
lead_paragraph: "Performance year (PY) 2026 data now available."
published_date: 2026-02-12
---

All model entities can now access PY 2026 data using the `/Group/all` and `/Patient` endpoints.

- Use the `all` identifier for `/Group` and `/Patient` endpoint requests.  
- Use the `all` identifier **for your first PY 2026 data request.** There will be no service date restrictions for this data.

## Requesting PY 2025 runout data

Use the `runout` identifier separately with the `/Group` endpoint. This will return data for enrollees who were attributed to your organization in PY 2025, but not PY 2026\.

- Use the `_since` parameter in conjunction with the `runout` identifier to limit data to updates occurring since your last runout request.  
- The `runout` identifier will be updated each month up to and including July 2026.   
- After July 2026, new data for enrollees who were attributed to your organization in PY 2025, but not PY 2026, will not be included.