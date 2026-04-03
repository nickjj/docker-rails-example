FROM ruby:4.0.2-alpine AS assets
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

ARG APP_UID=1000
ARG APP_GID=1000

# Instalar dependencias de Alpine necesarias para compilar gemas y assets
RUN apk add --no-cache \
  build-base \
  git \
  curl \
  postgresql-dev \
  yaml-dev \
  tzdata \
  nodejs \
  npm \
  bash \
  linux-headers \
  libffi-dev \
  && npm install -g yarn \
  && addgroup -g "${APP_GID}" ruby \
  && adduser -u "${APP_UID}" -G ruby -s /bin/sh -D ruby \
  && mkdir /node_modules && chown ruby:ruby -R /node_modules /app

USER ruby

COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
  NODE_ENV="${NODE_ENV}" \
  PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
  USER="ruby"

COPY --chown=ruby:ruby . .

RUN if [ "${RAILS_ENV}" != "development" ]; then \
  SECRET_KEY_BASE_DUMMY=1 rails assets:precompile; fi

CMD ["sh"]

###############################################################################

FROM ruby:4.0.2-alpine AS app
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

ARG APP_UID=1000
ARG APP_GID=1000

# Instalar dependencias mínimas de Alpine para runtime
RUN apk add --no-cache \
  curl \
  postgresql-dev \
  tzdata \
  bash \
  && addgroup -g "${APP_GID}" ruby \
  && adduser -u "${APP_UID}" -G ruby -s /bin/sh -D ruby \
  && chown ruby:ruby -R /app

USER ruby

COPY --chown=ruby:ruby bin/ ./bin
RUN chmod 0755 bin/*

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
  PATH="${PATH}:/home/ruby/.local/bin" \
  USER="ruby"

COPY --chown=ruby:ruby --from=assets /usr/local/bundle /usr/local/bundle
COPY --chown=ruby:ruby --from=assets /app/public /public
COPY --chown=ruby:ruby . .

ENTRYPOINT ["/app/bin/docker-entrypoint-web"]

EXPOSE 8000

CMD ["rails", "s"]
