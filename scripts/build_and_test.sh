#!/usr/bin/env bash

# build
docker-compose -f docker-compose.yml build static_site

# test
docker-compose run -u $(id -u ${USER}):$(id -g ${USER}) --publish 4000:4000 --rm --entrypoint "bundle exec jekyll serve -H 0.0.0.0" -d static_site
sleep 20
curl localhost:4000 | grep "Join the Google Group"
docker-compose down