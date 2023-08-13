FROM ruby:3.1.2-alpine AS builder

RUN apk update && apk upgrade && apk add --update --no-cache \
  gcompat \
  ca-certificates \
  build-base \
  curl-dev \
  nodejs \
  postgresql-dev \
  tzdata \
  vim \
  git \
  yarn && rm -rf /var/cache/apk/*

ARG RAILS_ROOT=/usr/src/app/
WORKDIR $RAILS_ROOT
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile* $RAILS_ROOT
RUN gem install bundler:2.3.26
RUN gem update --system
RUN bundle config --global frozen 1 && bundle install

COPY . .


### BUILD STEP DONE ###

FROM ruby:3.1.2-alpine

ARG RAILS_ROOT=/usr/src/app/
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

RUN apk update && apk upgrade && apk add --update --no-cache \
  ca-certificates \
  build-base \
  curl-dev \
  nodejs \
  gcompat \
  postgresql-dev \
  tzdata \
  vim \
  git \
  yarn && rm -rf /var/cache/apk/*

WORKDIR $RAILS_ROOT

COPY --from=builder $RAILS_ROOT $RAILS_ROOT
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

EXPOSE 3000

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
