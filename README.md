# Beneficiary Claims Data API
A static Jekyll site for the BCDA splash page: [https://sandbox.bcda.cms.gov](https://sandbox.bcda.cms.gov/)

## Requirements
It is assumed that the environment already has these installed:
* [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to install versioned ruby
* [ruby](https://www.ruby-lang.org/en/) currently using 2.4
* [jekyll](https://jekyllrb.com/) currently using 3.5.2

## Installation
1. `$ gem install bundler` <—install Gem bundler
2. `$ bundle install` <—install Gem bundles

## Build

Jekyll builds the CSS and HTML pages. Run `bundle exec jekyll serve` from the project root for a local build. By default, the site will run in `http://localhost:4000/`. You can also run `bundle exec jekyll build` to compile the site files into the `_site` directory.

### Using Docker for builds

Consistent and simple build process:

```
docker-compose -f docker-compose.yml build static_site
docker-compose -f docker-compose.yml run --rm static_site
```

This process uses a Docker container to execute `bundle exec jekyll build` , compiling site files ino the same `_site` directory used when executing this command on the Docker host. Advantage here is that there's no need to install ruby or any dependencies on the machine building the static site — Docker takes care of all that.

This is a convenience meant to ease integration of static site builds with the larger BCDA CI/CD pipeline.
