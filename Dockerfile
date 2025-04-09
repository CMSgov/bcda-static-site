FROM ruby:3.3-slim

RUN apt-get update && apt-get install -y \
  build-essential libssl-dev libffi-dev git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

COPY . .
RUN gem install bundler && bundle install

ENTRYPOINT ["bundle", "exec", "jekyll", "build"]
CMD []
