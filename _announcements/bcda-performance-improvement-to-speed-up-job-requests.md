---
layout: announcement
page_title: "BCDA performance improvement to speed up job requests"
description: "We’re excited to announce the launch of a new BCDA.cms.gov based on your feedback, user research, and testing."
show-side-nav: false
in-page-nav: true
published_date: 2024-12-01
custom_excerpt: "We’re excited to announce the launch of a new BCDA.cms.gov based on your feedback, user research, and testing."
---

We’ve decreased the time it takes to complete long-running jobs by reducing the number of EOB resources per ndjson file. We’ve also increased the rate limit on API requests by 10X to accommodate the additional files.

What's changing?
- EOB resources per ndjson file are reduced from 200 to 50. 
- We’ve increased the rate limit from 300 to 3,000 per 5 minutes from a single IP address.

Why is it changing?
- The change in EOB file volume decreases the time it takes to complete long-running jobs like requests for historical data.
- The API rate limit increase lowers likelihood of having your requests throttled.

What can you do to prepare?
- There’s no action required. It can be helpful to revisit our guidance on [handling 429 errors](https://stage.bcda.cms.gov/build.html#handling-429-error) caused by exceeding the API rate limit.