ARG NODE_VERSION=24.6
ARG RUBY_VERSION=3.2.6


FROM node:${NODE_VERSION}-alpine AS node-build

WORKDIR /usr/src/app

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

COPY ./assets ./assets
COPY ./sass ./sass

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=bind,source=gulpfile.js,target=gulpfile.js \
    --mount=type=cache,target=/root/.npm \
    npm run assets:build


FROM ruby:3.2.6 AS ruby-build

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN --mount=type=bind,source=Gemfile,target=Gemfile \
    --mount=type=bind,source=Gemfile.lock,target=Gemfile.lock \
    bundle install

COPY --from=node-build /usr/src/app/assets /usr/src/app/assets
COPY . .

RUN JEKYLL_ENV=production bundle exec jekyll build

CMD ["jekyll", "-v"]


FROM node:${NODE_VERSION}-alpine AS prod

WORKDIR /usr/src/app/_site

RUN npm install serve

COPY --from=ruby-build /usr/src/app /usr/src/app

USER node

EXPOSE 4000

ENTRYPOINT [ "npx" ]
CMD [ "serve", "-l", "4000" ]
