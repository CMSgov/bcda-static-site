---
layout: api-docs-v3
page_title: "BCDA v3 Documentation"
seo_title: ""
description: "Information about BCDA v3."
show-side-nav: true
feedback_id: ""
---

# {{ page.page_title }}

This documentation is for **v1 and v2 users migrating to BCDA v3**. If you’re new to BCDA, our [standard BCDA documentation](/api-documentation) may be the best place to get started. 

BCDA v3 became available July 1, 2026\. Access to v1 and 2 will be removed in mid-2027 (date to be determined). This documentation summarizes v3 changes and improvements while providing detailed steps to migrate.

## Topics

- [Introducing BCDA v3](/v3/introducing-v3.html) - Summary of v3 features and improvements   
- [How to Migrate to v3](/v3/how-to-migrate-v3.html) - New endpoints, claims representation, extensions, and mapping  
- [How to Filter Claims Data](/v3/filter-claims-data-v3.html) - Updated to include the [\_typefilter parameter](/v3/filter-claims-data-v3.html#the-typefilter-parameter)  
- [Partially Adjudicated Claims Data](/v3/partially-adjudicated-claims-data-v3.html) - Updated with FHIR resource consolidation  
- [Comparison of BCDA v3 and CCLF Files](/v3/comparison-bcda-cclf-files-v3.html) - Updated to cover mapping changes

## Join v3 office hours

We’re offering regular office hours to help you during your v3 migration. At each event, a 20-minute presentation will be followed by time for open questions.

<ul class="usa-collection">
{% capture date1 %}
Learn about enhancements to the API and get tips on how to plan your migration from BCDA v1 or v2. 

[Register now](https://events.gcc.teams.microsoft.com/event/b9936346-29a9-4522-9ec1-9d5b3111b75f@fbdcedc1-70a9-414b-bfa5-c3063fc3395e)
{% endcapture %}

{% include date-collection.html
    title="Planning your migration to v3"
    date="July 9, 2026"
    subtitle="July 9, 2026 | 1:00 - 2:00 pm CT"
    content=date1
%}

{% capture date2 %}
Join us for a general overview about how to access and use Medicare claims data with BCDA.

[Register now](https://events.gcc.teams.microsoft.com/event/3d64dee1-caac-46bd-9d7e-c6278cf0a51b@fbdcedc1-70a9-414b-bfa5-c3063fc3395e)
{% endcapture %}

{% include date-collection.html
    title="Getting started with BCDA"
    date="July 23, 2026"
    subtitle="July 23, 2026 | 1:00 - 2:00 pm CT"
    content=date2
%}
</ul>

We may schedule future office hours depending on need and interest.

## Join the BCDA Google Group

The [BCDA Google Group](https://groups.google.com/g/bc-api) is the best place for support and discussion about v3 and BCDA in general. Look for [posts labeled "BCDAv3"](https://groups.google.com/g/bc-api?label=BCDAv3) for v3 announcements and community discussion.

To get help directly contact [bcapi@cms.hhs.gov](mailto:bcapi@cms.hhs.gov).