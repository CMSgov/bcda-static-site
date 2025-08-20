# Beneficiary Claims Data API

Informational site for the CMS Beneficiary Claims Data API (BCDA): [https://bcda.cms.gov](https://bcda.cms.gov/)

## About the Project

A static Jekyll site for the Beneficiary Claims Data API (BCDA) which contains an overview of the API, how to connect to production and sandbox environments, and other documentation for the API.

## Core Team

A list of core team members responsible for the code and documentation in this repository can be found in [COMMUNITY.md](COMMUNITY.md).

This Ruby program builds the [bcda.cms.gov](https://bcda.cms.gov/) website via [Jekyll](https://jekyllrb.com/) and [U.S. Web Design System (USWDS)](https://designsystem.digital.gov/).

## Requirements
> [!NOTE]
> This repository assumes development on MacOS. If you're using Windows, some installation steps may be different.

- [Homebrew](https://brew.sh/)
- [Ruby](https://www.ruby-lang.org/en/)
- [Node.js](https://nodejs.org/en/download/) (v20 or higher required)
- [npm](https://www.npmjs.com/get-npm)

## Installation

### Step 1: Install Homebrew
> [!NOTE]
> If you already have Homebrew on your machine, you can skip this step.

Follow the installation process [found here](https://brew.sh/).

You can confirm Homebrew is installed on your machine by running the following in your terminal:

```sh
brew -v
```

(You may need to close and reopen your terminal window)

### Step 2: Install `pre-commit`

> [!IMPORTANT]
> Anyone committing to this repository must install [pre-commit](https://pre-commit.com/) and use the pre-commit hook to reduce the risk of exposing secrets.

#### Install pre-commit

To install pre-commit, run the following in your terminal:

```sh
brew install pre-commit
```

#### Implement the pre-commit hook

Run the following command to install the "gitleaks" hook:

```sh
pre-commit install
```

This will download and install the pre-commit hooks specified in `.pre-commit-config.yaml`.

### Step 3: Install Ruby

Using Jekyll requires Ruby to be installed on your system. We use `chruby` to make it easier to switch between Ruby versions. Due to limitations with our deployment process, the maximum version of Ruby we use is `v3.2.6`.

Install `chruby` and `ruby-install` by running the following:

```sh
brew install chruby ruby-install
```

Then, install Ruby v3.2.6 by running:

```sh
ruby-install ruby 3.2.6
```

You can verify your installation by running:
```sh
ruby -v
```

(You may need to close and reopen your terminal window)

You should see something like:
```
ruby 3.2.6 (2024-10-30 revision 63aeb018eb) ...
```

### Step 4: Install Node.js and npm

USWDS and other JavaScript packages require `npm` which comes with Node.js

You can install this manually from the [Node.js website](https://nodejs.org/en/download/) or with Homebrew by running:

```sh
brew install node
```

You can verify the installation by running:

```sh
node -v
npm -v
```

Your node version should be at least `v20`.

### Step 5: Install Jekyll and Bundler

Once Ruby is installed, install Jekyll and Bundler

```sh
gem install jekyll bundler
```

Verify your installation by running:

```sh
jekyll -v
```

You should see:

```
jekyll 4.4.1
```

### Step 6: Install Jekyll dependencies

Install Jekyll dependencies via `Bundler` by running:
```sh
bundle install
```

### Step 7: Install USWDS & other JavaScript dependencies

Run the following:

```sh
npm install
```

## Local Development

Once you've gone through the installation process you should be able to run the site locally.

### Running the Site

Run the following command to start the Jekyll server and watch for changes to your SCSS and JS assets:

```sh
npm run dev
```

You can view the site at `http://localhost:4000/`.

### Compiling USWDS styles and scripts seperately

You can run the following command to compile your assets without running the Jekyll server:

```sh
npm run assets:build
```

Alternatively, you can run the following to watch for changes as you modify your source files:

```sh
npm run assets:serve
```

### Running Jekyll seperately

You can also run Jekyll seperately with the following commands.

> [!WARNING]
> Be careful running these scripts seperately. These scripts will only build the Jekyll site with the compiled assets. If you've made changes to your source `*.scss` and `*.js` files, those changes will not be captured in these scripts.

To run the Jekyll server and automatically react to changes in your source `*.md` and `*.html` files, run:

```sh
npm run jekyll:serve
```

Or, to build the Jekyll site without watching for changes, run:

```sh
npm run jekyll:build
```

## Local accessibility testing

The `.pa11yci` config file defines [Axe](https://github.com/dequelabs/axe-core) and [HTML_CodeSniffer](https://squizlabs.github.io/HTML_CodeSniffer/) accessibilty tests for WCAG 2 Level AA conformance that should be run during local development:

### Run tests for every page in the sitemap

In order to run accessibility tests, make sure the site is running locally. Then, you can run:

```sh
npm run pa11y
```

Pa11y is configured to `includeWarnings` (not just errors) for more thorough compliance. However, some warning result codes are ignored for the following reasons:

- `color-contrast` — [Pa11y reports false positives](https://github.com/pa11y/pa11y/issues/633) when axe can't determine the contrast ratio for certain elements.

And some elements are hidden from testing:

- `.usa-overlay` — area behind mobile nav has a fixed position which triggers a "scrolling in two dimensions" error
- `.usa-in-page-nav__heading` — although heading structure is not logically nested, there's an [exception for fixed page sections](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## USWDS Icons

Over 2K icons get compiled when you run the Gulp tasks. Woah! But every individual icon file is not tracked and committed.

All of the `usa-icons` are packaged into a sprite, which should be preferred when possible:

```html
<svg class="usa-icon" role="img">
  <use xlink:href="{{ '/assets/uswds/img/sprite.svg#arrow_forward' | relative_url }}"></use>
</svg>
```

However, `img` tags need to point to individual icon files. These must be explicitly be tracked and checked in. Add required icons to the list of files to track (not be ignored) in `.gitignore`:

```sh
!assets/uswds/img/usa-icons/close.svg
```

And add them to the `include` inside the Jekyll `_config.yml`:

```yml
include:
  ...
  - assets/uswds/img/usa-icons/close.svg
```

### Theming USWDS

See USWDS [settings documentation](https://designsystem.digital.gov/documentation/settings/)

There are three key files in the `./_uswds_sass` dierctory:

- `_uswds-theme-custom-styles.scss`
- `_uswds-theme.scss`
- `styles.scss`

`styles.scss` is the Sass entry point that pulls everything together. Leave it be.

Per [USWDS guidance](https://designsystem.digital.gov/documentation/settings/), Sass `$theme-` variables can be defined in `_uswds-theme.scss` to create a custom configuration of USWDS.

For specific customizations that cannot be achieved at the theme level, USWDS includes a versatile set of [utility classes](https://designsystem.digital.gov/utilities/) that can be used to style elements (e.g. `border-style`, `background-color`, etc). Most designs are achievable with utility classes, and they are preferred over custom CSS rules whenever possible.

If custom styles must be written, they should added to `_uswds-theme-custom-styles.scss`, where you can leverage [USWDS design tokens](https://designsystem.digital.gov/design-tokens/), variables, mixins, and functions.

## Community

The BCDA team is taking a community-first and open source approach to the product development of this tool. We believe government software should be made in the open and be built and licensed such that anyone can download the code, run it themselves without paying money to third parties or using proprietary software, and use it as they will.

We know that we can learn from a wide variety of communities, including those who will use or will be impacted by the tool, who are experts in technology, or who have experience with similar technologies deployed in other spaces. We are dedicated to creating forums for continuous conversation and feedback to help shape the design and development of the tool.

We also recognize capacity building as a key part of involving a diverse open source community. We are doing our best to use accessible language, provide technical and process documents, and offer support to community members with a wide variety of backgrounds and skillsets.

### Community Guidelines

Principles and guidelines for participating in our open source community are can be found in [COMMUNITY.md](COMMUNITY.md). Please read them before joining or starting a conversation in this repo or one of the channels listed below. All community members and participants are expected to adhere to the community guidelines and code of conduct when participating in community spaces including: code repositories, communication channels and venues, and events.

## Feedback

If you have ideas for how we can improve or add to our capacity building efforts and methods for welcoming people into our community, please let us know at **bcapi@cms.hhs.gov**. If you would like to comment on the tool itself, please let us know by filing an **issue on our GitHub repository.**

## Policies

### Open Source Policy

We adhere to the [CMS Open Source
Policy](https://github.com/CMSGov/cms-open-source-policy). If you have any
questions, just [shoot us an email](mailto:opensource@cms.hhs.gov).

### Security and Responsible Disclosure Policy

_Submit a vulnerability:_ Vulnerability reports can be submitted through [Bugcrowd](https://bugcrowd.com/cms-vdp). Reports may be submitted anonymously. If you share contact information, we will acknowledge receipt of your report within 3 business days.

For more information about our Security, Vulnerability, and Responsible Disclosure Policies, see [SECURITY.md](SECURITY.md).

### Software Bill of Materials (SBOM)

A Software Bill of Materials (SBOM) is a formal record containing the details and supply chain relationships of various components used in building software.

In the spirit of [Executive Order 14028 - Improving the Nation’s Cyber Security](https://www.gsa.gov/technology/it-contract-vehicles-and-purchasing-programs/information-technology-category/it-security/executive-order-14028), a SBOM for this repository is provided here: https://github.com/{{ cookiecutter.project_org }}/{{ cookiecutter.project_repo_name }}/network/dependencies.

For more information and resources about SBOMs, visit: https://www.cisa.gov/sbom.

## Public domain

This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/) as indicated in [LICENSE](LICENSE).

All contributions to this project will be released under the CC0 dedication. By submitting a pull request or issue, you are agreeing to comply with this waiver of copyright interest.