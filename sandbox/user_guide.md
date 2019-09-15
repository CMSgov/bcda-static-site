---
layout: home
title:  "Getting Started with BCDA in Sandbox"
date:   2019-09-15 09:21:12 -0500
description: A Beginners Guide to learning about APIs and a walkthrough for the BCDA Swagger Environment
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
permalink: /sandbox/user-guide/
id: sandbox-user-guide
sections:
  - Getting Started with APIs
  - Setting up your credentials in Swagger
  - Making your first requests for data

button:
  - title: Home
    link: "../../index.html"
  - title: Try the API
    link: "#"
  - title: Learn about Production
    link: "../../user_guide.html"
  - title: Understand BCDA Data
    link: "../../data_guide.html"
---

# Getting Started with BCDA in Sandbox

This page is intended for a user who has little to no experience with APIs, and provides a guided walkthrough for working with BCDA using our interactive documentation. More advanced API users may be better served by the [Technical Setup guide](/sandbox/technical-user-guide/). If you’re not sure where to go, start here!

## Getting Started with APIs

* What’s an API?
  * An API (Application Programming Interface) is a set of features and rules that exist inside a software program that allows other software programs to interact with it. For example, you can build an app that uses the Twitter API to get information or data from a user's Twitter account. APIs are used in a wide variety of ways, but for our purposes, you can think of an API as a pipeline that can allow your ACO’s computer systems to receive data directly from CMS’ databases.
  * Need more information about APIs? Here are some great introductions:
    * [Introduction to Web APIs](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction)
    * [An Intro to APIs](https://www.codenewbie.org/blogs/an-intro-to-apis)
* Do I need to know how to code to use BCDA?
  * You do not need to know how to code!  Our documentation is written so that everyone -- regardless of technical exposure -- can access beneficiary data. For this walkthrough, we’ll be using a platform called Swagger, where you’ll be able to interact with the API through a web interface.

## Setting up your credentials in Swagger

* Navigating to Swagger
* Introduction to authorization
  * (OAuth2?)
  * (How can I authorize my vendor to do this?)
* Walk-through: credentials → token

## Making your first requests for data

### 1. Getting comfortable in Swagger

There are two categories of information that you can retrieve through BCDA: metadata, and bulk beneficiary data.  

<img src="/assets/img/sandbox_getting_started_01.png" alt="Swagger: metadata and bulkData" width="500"/>

**Metadata** in BCDA includes information about the platform that is making, storing, and verifying credentials and tokens (the `auth provider`); information about the API’s version; and information about the actions you can perform using the API itself (also duplicatively termed `metadata`). There is no PII or PHI in the **metadata** endpoint, so you can access this endpoint without having to be authorized.

<img src="/assets/img/sandbox_getting_started_02.png" alt="Swagger: metadata endpoints" width="500"/>

**Bulk Beneficiary Data** is where you can request the data about your assigned or assignable beneficiaries from three endpoints: Explanation of Benefit, Patient, and Coverage. Since all of these endpoints involve PII and PHI, you need to be authorized with your client ID and secret in order to access them.

<img src="/assets/img/sandbox_getting_started_03.png" alt="Swagger: bulkData endpoints" width="500"/>

### 2. Looking at BCDA Metadata

We’ll use `auth` as an example here.

Under the Metadata endpoint, click on `/_auth` to expand that section. After the information field expands, as shown below, click `Try it out`.

<img src="/assets/img/sandbox_getting_started_04.png" alt="Swagger: Looking at BCDA Metadata (1)" width="500"/>

Then, as shown below, click `Execute` to run the process of getting details about `auth`.

<img src="/assets/img/sandbox_getting_started_05.png" alt="Swagger: Looking at BCDA Metadata (22" width="500"/>

As shown below, clicking `Execute` returns details about the authorization and authentication provider BCDA is using.

<img src="/assets/img/sandbox_getting_started_06.png" alt="Swagger: Details about authorization and authentication" width="500"/>

You can repeat this process with the `/_version` and `/api/v1/metadata` endpoints as well.

If you’d like to do this from the command line or implement this API call in code, look in the `Curl` section for the request you just made.

### 3. Learning about the Bulk Data Endpoints

The `bulkData` category provides information about beneficiaries.  As shown below, there are five pieces of information within the `bulkData` category.  The first three -- Explanation of Benefit (EOB) data, Patient data, and Coverage data -- are endpoints that return information about your ACO’s assigned or assignable beneficiaries. The last two pieces of information -- jobId and filename -- return information about the request you’re making.

* **Explanation of Benefit** data includes claims data for your beneficiaries.
* **Patient** data includes identification information about your assigned or assignable beneficiaries.
* **Coverage** data includes each beneficiary’s Medicare coverage plan.

<img src="/assets/img/sandbox_getting_started_07.png" alt="Swagger: Learning about the Bulk Data Endpoints" width="500"/>

### 4. Making your first request for beneficiary data

To get any bulk beneficiary data, you must first be authorized with BCDA. Make sure you’ve followed the steps above for [Setting up your credentials in Swagger](#TKTK) before moving forward.

Retrieving beneficiary data comprises two steps:

1. Starting a job to acquire data from a specific endpoint
2. Retrieving data via a job request.

We’ll use the `Coverage` endpoint as an example of how to perform both steps. You’ll be able to follow the same instructions for Explanation of Benefit and Patient data as well.

First, click on `GET /api/v1/Coverage/$export`,then click `Try it out`.

<img src="/assets/img/sandbox_getting_started_08.png" alt="Swagger: Coverage endpoint (1)" width="500"/>

Then, as shown below, click `Execute` to start the process of requesting Coverage data.  Make sure you note the **job number** (also known as `jobId`)  in the response header, since you’ll need this job number to track the status of your data request.

<img src="/assets/img/sandbox_getting_started_09.png" alt="Swagger: Coverage endpoint (2)" width="500"/>

If you’d like to use the command line or implement this API call in code, look in the `Curl` section (shown in the image above) for the request you just made. Not far below that, you can see the response: an `HTTP 202 Accepted` giving a link in the content-location header for status information on your Coverage job.

### 5. Getting your data

There are three steps to retrieving the requested Coverage data:

1. Checking the status of your job
2. Downloading your bulk data file
3. Decrypting your data file

Depending on the number of beneficiaries prospectively assigned or assignable to your ACO, it may take a while for your data file to be ready to download. While you wait, you can check the status of your job to find out when the file is ready.

You can check the status of the job by entering the job number into the `jobId` text field, as shown in the image below.

<img src="/assets/img/sandbox_getting_started_10.png" alt="Swagger: retrieving your jobId" width="500" />

Once the job is completed, you can download the file by clicking on the `Download` button, as shown in the image below.  You will have one hour before your token expires, and you will need to get another from token if it expires before you are finished interacting with the API.  You will also want to copy the filename.

<img src="/assets/img/sandbox_getting_started_11.png" alt="Swagger: downloading your data" width="500" />

The file you’ve downloaded will be encrypted. Follow the [decryption walkthrough](/decryption/) to learn how to decrypt and view the NDJSON data contained inside it.

Once you’ve decrypted the file, you’ll want to know what to do with the data. We’ve provided a [guide to working with BCDA data](/data-guide/) to help you, including a crosswalk between CCLF fields and the corresponding sections of the NDJSON files.
