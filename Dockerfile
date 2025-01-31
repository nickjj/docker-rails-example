FROM ruby:3.4.1-slim-bullseye AS assets
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

# Define arguments at the start
ARG UID=1000
ARG GID=1000

# Create user first, before any package installations
RUN groupadd -g ${GID} ruby && \
    useradd --create-home --no-log-init -u ${UID} -g ${GID} ruby && \
    mkdir -p /node_modules && \
    chown ruby:ruby -R /node_modules /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    libpq-dev \
    libyaml-dev && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key -o /etc/apt/keyrings/nodesource.asc && \
    echo 'deb [signed-by=/etc/apt/keyrings/nodesource.asc] https://deb.nodesource.com/node_22.x nodistro main' | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    corepack enable && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    apt-get clean

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
    SECRET_KEY_BASE_DUMMY=1 rails assets:precompile; \
    fi

CMD ["bash"]

###############################################################################

FROM ruby:3.4.1-slim-bullseye AS app
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

ARG UID=1000
ARG GID=1000

# Create user first
RUN groupadd -g ${GID} ruby && \
    useradd --create-home --no-log-init -u ${UID} -g ${GID} ruby && \
    chown ruby:ruby -R /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    apt-get clean

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