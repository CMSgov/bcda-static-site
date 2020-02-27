---
layout: home
title:  "Getting Started with BCDA in Production"
date:   2019-09-03 09:21:12 -0500
description: "A beginner's guide to working with the BCDA Production environment."
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
nav_link: production
permalink: /production/user-guide/
id: prod-user-guide
sections:
  - Requesting production access
  - Getting started with APIs
  - Setting up your credentials in Swagger
  - Making your first requests for data
  - Frequently asked questions
---

## Requesting production access
* As BCDA launches into our production beta, we are slowly onboarding small groups of Shared Savings Program ACOs into the production environment. To put your ACO in the queue for access, please fill out the [BCDA Production Onboarding Request Form](https://airtable.com/shrMbfFSRZkTcSAof){:target="_blank"}. ACOs will be onboarded to production in the order in which requests are received. While you wait, you can get familiar with the API in the [sandbox environment](/sandbox/user-guide/){:target="_self"}, review the [data structure](/data-guide/){:target="_self"}, and join the [BCDA Google Group](https://groups.google.com/forum/#!forum/bc-api){:target="_blank"}, to have your questions answered.
* **Note:** some of our early production beta partners have encountered issues accessing the API due to internal firewalls. If your corporate IT uses an internal DNS server, you may not be able to access the API. As you request production access, you may want to check in with your internal IT team to discuss your company’s network structure.

This page is intended for a user who has little to no experience with APIs, and provides a guided walkthrough for working with BCDA using our interactive documentation. More advanced API users may be better served by the [Advanced User Guide](/production/technical-user-guide/){:target="_self"}. If you’re not sure where to go, start here!

## Getting started with APIs
  * What’s an API?
    * An API (Application Programming Interface) is a set of features and rules that exist inside a software program that allows other software programs to interact with it. For example, you can build an app that uses the Twitter API to get information or data from a user's Twitter account. APIs are used in a wide variety of ways, but for our purposes, you can think of an API as a pipeline that can allow your ACO’s computer systems to receive data directly from CMS’ databases.
    * Need more information about APIs? Here are some great introductions:
      * [Introduction to Web APIs](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction){:target="_blank"}
      * [An Intro to APIs](https://www.codenewbie.org/blogs/an-intro-to-apis){:target="_blank"}
  * Do I need to know how to code to use BCDA?
    * You do not need to know how to code!  Our documentation is written so that everyone -- regardless of technical exposure -- can access beneficiary data. For this walkthrough, we’ll be using a platform called Swagger, where you’ll be able to interact with the API through a web interface.

## Setting up your credentials in Swagger

### Navigating to Swagger

To get to BCDA's Swagger page for production data, click on the following link, or copy and paste it into your web browser:

[https://api.bcda.cms.gov/api/v1/swagger](https://api.bcda.cms.gov/api/v1/swagger){:target="_blank"}

### Walk-through: from credentials to token

Once the page is open, your first step will be getting an **access token**.  You'll use this access token later to prove you are allowed to use the API.

* Find the section of the page shown below, in the **auth** category.
* Click the lock icon.

<img class="ug-img" src="/assets/img/nav_swag_01.png" alt="Swagger: Auth category with lock icon circled in red on the right"/>

When you enrolled in BCDA, you received **credentials**, which included a **client ID** and **secret**.  Here you'll enter them into Swagger.

* Click the "Authorize" button when you've entered your credentials, then "Close"

<img class="ug-img" src="/assets/img/nav_swag_02.png" alt=""/>

Now you're ready to get a token!

* To show more information about the `/auth/token` API endpoint, click on it (this time, away from the lock icon).
* Click "Try it out"

<img class="ug-img" src="/assets/img/nav_swag_03.png" alt="Swagger: Token endpoint field with 'Try it out' button, circled in red on the right"/>

* Click "Execute" to get your token

<img class="ug-img" src="/assets/img/nav_swag_04.png" alt=""/>

If all is well, the Server response section will look similar to the following snapshot: it will have a response code of `200`, and give an "access_token" in the response body.

* Copy the access token.  It will not have any spaces or newlines; the hyphens at the end of the lines are indicating that the line continues unbroken.

<img class="ug-img" src="/assets/img/nav_swag_05.png" alt="Swagger: Access token response showing long access token in text field"/>

Now that you have a token, you can tell Swagger to use it for your future requests.

* Return to the top of the Swagger page
* Click on the lock icon

<img class="ug-img" src="/assets/img/nav_swag_06.png" alt=""/>

In the "Value" box:

* **First, you must type the word _Bearer_ followed by a space into the box. _Bearer_ is case-sensitive.**
  * Failure to do this will result in an `HTTP 401 Unauthorized` error. 
* Paste your token after the space following **_Bearer_**
* Click "Authorize" and then "Close"

<img class="ug-img" src="/assets/img/nav_swag_07.png" alt=""/>

### Follow-up questions about authorization

**Q: Will I always use this token with the BCDA API?**

A: The token will expire after twenty minutes.  The next time you use the BCDA API after that time, you can follow the same steps to get a fresh token.


## Making your first requests for data
### 1. Getting comfortable in Swagger
There are two categories of information that you can retrieve through BCDA: metadata and bulk beneficiary data.

<img class="ug-img" src="/assets/img/swagger_walkthrough_01.png" alt="Swagger: 'metadata' and 'bulkData' are categories that can be expanded further to get more detailed information" />

**Metadata** in BCDA includes information about the platform that is making, storing, and verifying credentials and tokens (the auth provider); information about the API’s version; and information about the actions you can perform using the API itself (also duplicatively termed metadata). There is no PII or PHI in the **metadata** endpoint, so you can access this endpoint without having to be authorized.

<img class="ug-img" src="/assets/img/swagger_walkthrough_02.png" alt="" />

### 2. Looking at BCDA Metadata

We’ll use `auth` as an example here.

Under the Metadata endpoint, click on `/_auth` to expand that section. After the information field expands, as shown below, click `Try it out`.

<img class="ug-img" src="/assets/img/swagger_walkthrough_03.png" alt="" />

Then, as shown below, click `Execute` to run the process of getting details about `auth`.

<img class="ug-img" src="/assets/img/swagger_walkthrough_04.png" alt="" />

As shown below, clicking `Execute` returns details about the authorization and authentication provider BCDA is using.

<img class="ug-img" src="/assets/img/swagger_walkthrough_05.png" alt="Swagger: the response body reveals that the auth_provider is 'alpha'" />

You can repeat this process with the `/_version` and `/api/v1/metadata` endpoints as well.

If you’d like to do this from the command line or implement this API call in code, look in the `Curl` section for the request you just made.

### 3. Learning about the Bulk Data Resource Types

The `bulkData` category provides information about beneficiaries.  As shown below, there are three pieces of information within the `bulkData` category.  The first one -- the `Patient` endpoint -- is an endpoint that returns information about your ACO’s assigned or assignable beneficiaries. The last two pieces of information -- jobId and filename -- return information about the request you’re making.

Within the `Patient` endpoint, you can make requests for up to three resource types:

* **Explanation of Benefit** data includes claims data for your beneficiaries.
* **Patient** data includes identification information about your assigned or assignable beneficiaries.
* **Coverage** data includes each beneficiary’s Medicare coverage plan.

<img class="ug-img" src="/assets/img/swagger_walkthrough_06.png" alt="Swagger: use the 'type' parameter to specify resource type(s) for your request" />

### 4. Making your first request for beneficiary data
To get any bulk beneficiary data, you must first be authorized with BCDA. Make sure you’ve followed the steps above for [Setting up your credentials in Swagger](#setting-up-your-credentials-in-swagger) before moving forward.

Retrieving beneficiary data comprises two steps:

1. Starting a job to acquire data from the `Patient` endpoint
2. Retrieving data via a job request

#### a. Making a request for all three resource types

In this example, we'll show a request for all three resource types in the `Patient` endpoint. If you want to learn how to make a request for data from one resource type, jump to [step 4b: Making a Request for One Resource Type](#b-making-a-request-for-one-resource-type).

First, click on `GET /api/v1/Patient/$export`, then click `Try it out`.

<img class="ug-img" src="/assets/img/swagger_walkthrough_06a.png" alt="" />

Then, as shown below, click `Execute` to start the process of requesting data from the `Patient` endpoint.  Make sure you note the **job number** (also known as `jobId`)  in the **response header**, since you’ll need this job number to track the status of your data request.

<img class="ug-img" src="/assets/img/swagger_walkthrough_06b.png" alt="Swagger: making a call to the Patient endpoint with no Resource Types specified defaults to returning data from all three Resource Types at once" />

<img class="ug-img" src="/assets/img/swagger_walkthrough_06c.png" alt="Swagger: 'curl' examples are given in full in the Advanced User Guide" />

If you’d like to use the command line or implement this API call in code, look in the `Curl` section (shown in the image above) for the request you just made. Not far below that, you can see the response: an `HTTP 202 Accepted` giving a link in the content-location header for status information on your job.

#### b. Making a request for one resource type

Next, we'll show a specific example of requesting only the `Coverage` resource type from the `Patient` endpoint. You can follow the same steps for `ExplanationOfBenefit` or `Patient` data from the `Patient` endpoint, or any combination of the three.

First, click on `GET /api/v1/Patient/$export`, then click `Try it out`.

<img class="ug-img" src="/assets/img/swagger_walkthrough_07.png" alt="" />

As shown above, in the field labeled "Resource types requested," type "Coverage." Then click `Execute` to start the process of requesting Coverage data.  Make sure you note the **job number** (also known as `jobId`)  in the **response header**, since you’ll need this job number to track the status of your data request.

<img class="ug-img" src="/assets/img/swagger_walkthrough_08.png" alt="" />

If you’d like to use the command line or implement this API call in code, look in the `Curl` section (shown in the image above) for the request you just made. Not far below that, you can see the response: an `HTTP 202 Accepted` giving a link in the content-location header for status information on your Coverage job.

### 5. Getting your data
There are two steps to retrieving the requested Coverage data:

1. Checking the status of your job
2. Downloading your bulk data file

Depending on the number of beneficiaries prospectively assigned or assignable to your ACO, it may take a while for your data file to be ready to download. While you wait, you can check the status of your job to find out when the file is ready.

You can check the status of the job by entering the job number into the `jobId` text field, as shown in the image below.

<img class="ug-img" src="/assets/img/swagger_walkthrough_09.png" alt="Swagger: after entering the job ID into the job ID field, click execute" />

The X-Progress header indicates the job's workflow status (Pending, In Progress, Completed, Archived, Expired, Failed). When in the In Progress state, an estimated completion percentage is appended to the X-Progress value (e.g., "In Progress (10%)").

Once the job is completed, you will receive a `HTTP 200 Complete` response, which includes a URL ending in .ndjson.  You’ll need the end of the URL in order to retrieve your data.

<img class="ug-img" src="/assets/img/swagger_walkthrough_10.png" alt="Swagger: copy the file name: the part of the URL after the last '/'" />

To retrieve your data, open the `GET /data/{jobId}/{filename}` endpoint. Copy the `jobId` into the `jobId` field, and the last string of the URL received in the previous step (highlighted in green and dashed lines above) into the `filename` field, then hit `Execute`.

<img class="ug-img" src="/assets/img/swagger_walkthrough_11.png" alt="" />

The `Response Body` contains the requested claims data in NDJSON format. Click the `Download` button that appears in the lower right corner of the response section. Note that a large file may take a while to download.

<img class="ug-img" src="/assets/img/swagger_walkthrough_12.png" alt="" />

If you have requested data related to more than one Resource Type, the files related to each Resource Type will appear separately.

You will have twenty minutes before your token expires, and you will need to get another from `/auth/token` if it expires before you are finished interacting with the API.

Once you’ve downloaded the file, you’ll want to know what to do with the data. We’ve provided a [guide to working with BCDA data](/data-guide/){:target="_self"} to help you, including a crosswalk between CCLF fields and the corresponding sections of the NDJSON files.

## <a name="frequently-asked-questions"></a>Frequently asked questions about making requests

* **How often can I request data from BCDA?**

  BCDA data will be updated weekly, so you will be able to make requests and expect to retrieve new data on a weekly basis. If you’re already requesting data from one endpoint and try to request data from that endpoint again while the first request is processing, you’ll receive a `429 Too Many Requests` error.

* **How will I know when my data is ready?**

  The X-Progress header indicates the job's workflow status (Pending, In Progress, Completed, Archived, Expired, Failed). When in the In Progress state, an estimated completion percentage is appended to the X-Progress value (e.g., "In Progress (10%)").

* **How long do I have before my file is deleted?**

  You will need to download the data file within 24 hours of starting the request to a specific endpoint.

* **Why is this data file so large?**

  In the sandbox environment, we can only provide synthetic data up to an equivalent of 30,000 beneficiaries. Your ACO may be larger, in which case the production file will be larger and take longer to process.

  Additionally, in the first iteration of BCDA in production, each request to a bulk data endpoint sends back seven years of historical data for your beneficiaries. In future iterations, we’ll add a way for you to limit the data to a specific date range.
