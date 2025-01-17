# Beneficiary Claims Data API

A static Jekyll site for the BCDA splash page: [https://bcda.cms.gov](https://bcda.cms.gov/)

## Requirements

It is assumed that the environment already has these installed:

- [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to install versioned ruby
- [ruby](https://www.ruby-lang.org/en/) currently using 2.7.1
- [jekyll](https://jekyllrb.com/) currently using 4.2.0

* [npm](https://www.npmjs.com/) currently using 6.13.4

- [Docker](https://docs.docker.com/install/) to standardize builds across all contributors' local machines
- [Docker Compose](https://docs.docker.com/compose/install/) to define and run multi-container Docker applications

## Installation

Navigate to the repository, and install the appropriate Gem file (a Gem file includes the dependencies for Ruby apps):

1. `$ gem install bundler` <— install Gem bundler
2. `$ bundle install` <— install Gem bundles
3. `$ npm install` <- install node dependancies

## Local builds

Jekyll builds the CSS and HTML pages. Run `bundle exec jekyll serve` from the project root for a local build. By default, the site will run in `http://localhost:4000/`. You can also run `bundle exec jekyll build` to compile the site files into the `_site` directory.

### Using Docker for distributed builds

Every contributor that uses Docker will have the exact same build as every other contributor. The command for a consistent and simple build process is:

```
docker compose -f docker-compose.yml build static_site
docker compose -f docker-compose.yml run --rm static_site
```

This process uses a Docker container to execute `bundle exec jekyll build` , compiling site files into the same `_site` directory used when executing this command on the Docker host. The advantage here is that there's no need to install ruby or any dependencies on the machine building the static site — Docker takes care of all that.

### Using Docker for serving

To host the site in Docker, accessible at `http://localhost:4000/`:

```
docker compose run --publish 4000:4000 --rm --entrypoint "bundle exec jekyll serve -H 0.0.0.0" static_site
```

This is a convenience meant to ease integration of static site builds with the larger BCDA CI/CD pipeline.

## Installing and Using Pre-commit

Anyone committing to this repo must use the pre-commit hook to lower the likelihood that secrets will be exposed.

### Step 1: Install pre-commit

You can install pre-commit using the MacOS package manager Homebrew:

```sh
brew install pre-commit
```

Other installation options can be found in the [pre-commit documentation](https://pre-commit.com/#install).

### Step 2: Install the hooks

Run the following command to install the gitleaks hook:

```sh
pre-commit install
```

This will download and install the pre-commit hooks specified in `.pre-commit-config.yaml`.
