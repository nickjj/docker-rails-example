# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Changed

- Reference `CABLE_PORT` in `compose.yaml`

#### Languages and services

- Update `Postgres` to `16.4`
- Update `Redis` to `7.4.0`

#### Back-end dependencies

- Update `minitest` to `5.25.1`
- Update `rails` to `7.2.1` (check [this commit](https://github.com/nickjj/docker-rails-example/commit/a23dddb802b8d98100ca43c4cad34969f61919f6) for 7.1 to 7.2)
- Update `redis` to `5.3.0`
- Update `rubocop-rails` to `2.26.0`
- Update `sidekiq` to `7.3.1`
- Update `stimulus-rails` to `1.3.4`

#### Front-end dependencies

- Update `esbuild` to `0.23.1`
- Update `tailwindcss` to `3.4.10`

## [0.9.0] - 2024-08-09

### Changed

- Add `config/initializers/enable_yjit.rb` which enables YJIT by default (delete this file to disable it)
- Add `required: false` to `depends_on` in `docker-compose.yml` (requires Docker Compose v2.20.2+)
- Update Node and Yarn install strategy to remove install script deprecation warning
- A whole bunch of changes related to Rails 7.1.0, take a look at [this commit](https://github.com/nickjj/docker-rails-example/commit/94e9190e2e3db2cd350cd217db3b270b7c77fb72)
- Update `rename-project` script to auto-delete temporary files
- Rename `docker-compose.yml` to `compose.yaml` to stick to the official Docker Compose spec

#### Languages and services

- Update `Ruby` to `3.3.3`
- Update `Node` to `20.X`
- Update `Postgres` to `16.3`
- Update `Redis` to `7.2.5`

#### Back-end dependencies

- Update `cssbundling-rails` to `1.4.1`
- Update `jsbundling-rails` to `1.3.1`
- Update `minitest` to `5.24.1`
- Update `pg` to `1.5.7`
- Update `puma` to `6.4.2`
- Update `rack-mini-profiler` to `3.3.0`
- Update `rack-mini-profiler` to `3.3.1`
- Update `rack` to `3.1.7`
- Update `rails` to `7.1.3.4`
- Update `redis` to `5.2.0`
- Update `sidekiq` to `7.3.0`
- Update `stimulus-rails` to `1.3.3`
- Update `turbo-rails` to `2.0.6`

#### Front-end dependencies

- Update `@hotwired/stimulus` to `3.2.2`
- Update `@hotwired/turbo-rails` to `8.0.5`
- Update `autoprefixer` to `10.4.20`
- Update `esbuild` to `0.23.0`
- Update `postcss-import` to `16.1.0`
- Update `postcss` to `8.4.41`
- Update `tailwindcss` to `3.4.8`

## [0.8.0] - 2023-05-13

### Added

- Ability to customize `UID` and `GID` if you're not using `1000:1000` (check the `.env.example` file)
- Output `docker compose logs` in CI for easier debugging

### Changed

- Replace `Redis.current` (removed in `redis` 5.0+) with `RedisConn.current` which is in `config/initializers/redis.rb`
- Rename `run bash` to `run shell`
- Reference `PORT` variable in the `docker-compose.yml` web service instead of hard coding `8000`
- Adjust Hadolint to exit > 0 if any style warnings are present

#### Languages and services

- Update `Ruby` to `3.2.2`
- Update `Node` to `18.X`
- Update `Postgres` to `15.3`
- Update `Redis` to `7.0.11`

#### Back-end dependencies

- Update `cssbundling-rails` to `1.1.2`
- Update `jsbundling-rails` to `1.1.1`
- Update `minitest` to `5.18.0`
- Update `pg` to `1.5.3`
- Update `puma` to `6.2.2`
- Update `rack-mini-profiler` to `3.1.0`
- Update `rails` to `7.0.4.3`
- Update `redis` to `5.0.6`
- Update `sidekiq` to `7.1.0`
- Update `stimulus-rails` to `1.2.1`
- Update `turbo-rails` to `1.4.0`

#### Front-end dependencies

- Update `@hotwired/stimulus` to `3.2.1`
- Update `@hotwired/turbo-rails` to `7.3.0`
- Update `autoprefixer` to `10.4.14`
- Update `esbuild` to `0.17.19`
- Update `postcss-import` to `15.1.0`
- Update `postcss` to `8.4.23`
- Update `tailwindcss` to `3.3.2`

### Removed

- `set -o nounset` from `run` script since it's incompatible with Bash 3.2 (default on macOS)
- `--jobs "$(nproc)"` from the `bundle install` command in the `Dockerfile` since this is the default

### Fixed

- Assets in production mode were using the wrong `.sprockets-manifest-XXX.json` file, `bin/docker-entrypoint-web` was adjusted to delete all but the last built version since Rails doesn't pick the latest file based on `mtime`

## [0.7.0] - 2022-09-08

### Added

- `set -o nounset` to `run` script to exit if there's any undefined variables

### Changed

- Switch Docker Compose `env_file` to `environment` for `postgres` to avoid needless recreates on `.env` changes
- Replace override file with Docker Compose profiles for running specific services
- Update Github Actions to use Ubuntu 22.04
- Enable BuildKit by default in the `.env.example` file

#### Languages and services

- Update `PostgreSQL` to `14.5`
- Update `Redis` to `7.0.4`

#### Back-end dependencies

- Update `cssbundling-rails` to `1.1.1`
- Update `jsbundling-rails` to `1.0.3`
- Update `pg` to `1.4.3`
- Update `redis` to `4.7.1`
- Update `sidekiq` to `6.5.4`
- Update `stimulus-rails` to `1.1.0`
- Update `turbo-rails` to `1.1.1`

#### Front-end dependencies

- Update `@hotwired/stimulus` to `3.1.0`
- Update `@hotwired/turbo-rails` to `7.1.3`
- Update `autoprefixer` to `10.4.8`
- Update `esbuild` to `0.15.2`
- Update `postcss` to `8.4.16`
- Update `tailwindcss` to `3.1.8`

### Removed

- Docker Compose `env_file` property for `redis` to avoid needless recreates on `.env` changes
- Drop support for Docker Compose v1 (mainly to use profiles in an optimal way, it's worth it!)

## [0.6.0] - 2022-05-15

### Added

- `config/initializers/rack_mini_profiler.rb` to enable profiling Hotwire Turbo Drive

### Changed

- Refactor `/up/` endpoint into its own controller and add `/up/databases` as a second URL

#### Languages and services

- Update `Ruby` to `3.1.2`
- Update `PostgreSQL` to `14.2`
- Update `Redis` to `7.0.0`

#### Back-end dependencies

- Update `capybara` to `3.37.1`
- Update `jsbundling-rails` to `1.0.2`
- Update `pg` to `1.3.5`
- Update `puma` to `5.6.4`
- Update `rack-mini-profiler` to `3.0.0`
- Update `rails` to `7.0.3`
- Update `redis` to `4.6.0`
- Update `sidekiq` to `6.4.2`
- Update `stimulus-rails` to `1.0.4`
- Update `turbo-rails` to `1.0.1`

#### Front-end dependencies

- Update `@hotwired/turbo-rails` to `7.1.1`
- Update `autoprefixer` to `10.4.7`
- Update `esbuild` to `0.14.39`
- Update `postcss-import` to `14.1.0`
- Update `postcss` to `8.4.13`
- Update `tailwindcss` to `3.0.24`

## [0.5.0] - 2021-01-15

### Added

- esbuild and tailwindcss based on Rails 7
- Lint Dockerfile with <https://github.com/hadolint/hadolint>
- `./run test` which runs `rails test` but also optionally builds your JS / CSS with `./run test -b`

### Changed

- Use the Docker Compose spec in `docker-compose.yml` (removes version: property)
- Rename `webpacker` Docker build stage to `assets`
- Replace `cp -a` with `cp -r` in Docker entrypoint to make it easier to delete older assets
- Base application has been freshly generated by Rails 7.0.1
- Only install and enable bootsnap in non-production environments
- Update `tailwind.config.js` based on the new TailwindCSS v3 defaults
- Update Bash shebang to use `#!/usr/bin/env bash` in `docker-entrypoint-web`

#### Languages and services

- Update `Ruby` to `3.1.0` and switch to Debian Bullseye Slim
- Update `Node` to `16.x`
- Update `PostgreSQL` to `14.1` and switch to Debian Bullseye Slim
- Update `Redis` to `6.2.6` and switch to Debian Bullseye Slim

#### Back-end dependencies

- Update `bootsnap` to `1.9.3`
- Update `capybara` to `3.36.0`
- Update `cssbundling-rails` to `1.0.0`
- Update `jbuilder` to `2.11.5`
- Update `jsbundling-rails` to `1.0.0`
- Update `puma` to `5.5.2`
- Update `rack-mini-profiler` to `2.3.3`
- Update `rails` to `7.0.1`
- Update `redis` to `4.5.1`
- Update `selenium-webdriver` to `4.1.0`
- Update `sidekiq` to `6.3.1`
- Update `sprockets-rails` to `3.4.2`
- Update `stimulus-rails` to `1.0.2`
- Update `turbo-rails` to `1.0.0`
- Update `web-console` to `4.2.0`
- Update `webdrivers` to `5.0.0`

#### Front-end dependencies

- Update `@hotwired/stimulus` to `3.0.1`
- Update `@hotwired/turbo-rails` to `7.1.0`
- Update `autoprefixer` to `10.4.2`
- Update `esbuild` to `0.14.11`
- Update `postcss-import` `14.0.2`
- Update `postcss` `8.4.5`
- Update `tailwindcss` to `3.0.15`

### Removed

- All traces of Webpacker
- Deleting old assets in the Docker entrypoint (it's best to handle this out of band in a cron job, etc.)
- Channel related JavaScript (this isn't added by default with Rails 7 and Hotwire is available now)
- `tailwindcss-stimulus-components` front-end package
- `@rails/activestorage` front-end package (you can always add it back if you use this feature)

### Fixed

- Use `bundle exec sidekiq` instead of `sidekiq` which fixes [issue #30](https://github.com/nickjj/docker-rails-example/issues/30)

## [0.4.0] - 2021-07-01

### Added

- StimulusJS imports into `application.js`

### Changed

- Update Rails from `6.1.3` to `6.1.4`
- Update Puma from `5.3.1` to `5.3.2`
- Update TailwindCSS from `2.1.2` to `2.2.4`
- Update Turbo Rails from `7.0.0-beta.5` to `7.0.0-beta.8`

### Fixed

- Use multi-stage build to prevent `bundle install` from running multiple times [#8](https://github.com/nickjj/docker-rails-example/issues/8)
- JS not executing due to `Gemfile.lock` referencing Webpacker `pre.2` not `beta.7`
- `Gemfile` now correctly references Webpacker 6 beta 7

## [0.3.0] - 2021-05-19

### Added

- `PORT` env variable to be compatible with more hosting providers
- `CABLE_PORT` env variable to split out the bind port from the Docker port forward
- `run cmd` to run any command you want in the web container, ie. `run cmd ruby --version`
- `bin/rename-project` script to assist with renaming the project

### Changed

- Rename `DOCKER_WEB_PORT` to `DOCKER_WEB_PORT_FORWARD`
- Rename `DOCKER_CABLE_PORT` to `DOCKER_CABLE_PORT_FORWARD`
- Comment out Sidekiq's dashboard route by default for extra safety (check `config/routes.rb`)
- Refactor `run` script so all web container commands use the new `cmd` function
- Replace `##` comments with `#` in the `run` script
- Replace `APP_NAME` in `run` script with `POSTGRES_USER` for connecting to psql
- Update Ruby from `2.7.2` to `3.0.1`
- Update Webpacker from `5.2` to `6.0-beta7`
- Update TailwindCSS from `2.0.3` to `2.1.2`
- Update TailwindCSS Stimulus Components from `2.1.2` to `2.2.0`
- Update PostgreSQL from `13.2` to `13.3`
- Update Redis from `6.0.10` to `6.2.3`
- Use new packs directory structure recommended by Webpacker 6
- Enable JIT compiler for TailwindCSS
- Move `tailwind.config.js` to the root of the project

### Fixed

- Add Web Console support by configuring `web_console.allowed_ips` in `config/environments/development.rb`
- Set an empty ENTRYPOINT for the worker and action cable to avoid race conditions when copying static files
- Fix `run` script error for unbound variable in older versions of Bash on macOS

### Removed

- Ability to customize puma bind host, it's hard coded to `0.0.0.0` now
- Unnecessary `mkdir` and `chown` of `/public` in `Dockerfile`

## [0.2.0] - 2021-02-20

### Added

- Hotwire Turbo through Webpack
- `run bundle:outdated` task to show outdated Ruby dependencies
- `run bundle:update` task to update your Ruby dependencies
- `run yarn:outdated` task to show outdated Node dependencies

### Changed

- `run bundle` task has been replaced with `run bundle:install` task
- `run yarn` task has been replaced with `run yarn:install` task
- Update PostgreSQL from `13.1` to `13.2`
- Update Redis from `6.0.9` to `6.0.10`
- Update all Ruby and most Node packages to their latest stable releases
- Ping Redis as part of the `/up` health check
- Rename `static` controller to `pages`
- Call `rails s` instead of `puma -C config/puma.rb` in the Dockerfile CMD
- Meta description to include the app being production ready
- Refactor `run` script to remove a lot of duplication by introducing helper functions

### Fixed

- Run `rails test` as part of the CI pipeline

### Removed

- Turbolinks (replaced by Hotwire Turbo Drive)

## [0.1.0] - 2020-12-22

### Added

- Everything!

[Unreleased]: https://github.com/nickjj/docker-rails-example/compare/0.9.0...HEAD
[0.9.0]: https://github.com/nickjj/docker-rails-example/compare/0.8.0...0.9.0
[0.8.0]: https://github.com/nickjj/docker-rails-example/compare/0.7.0...0.8.0
[0.7.0]: https://github.com/nickjj/docker-rails-example/compare/0.6.0...0.7.0
[0.6.0]: https://github.com/nickjj/docker-rails-example/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/nickjj/docker-rails-example/compare/0.4.0...0.5.0
[0.4.0]: https://github.com/nickjj/docker-rails-example/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/nickjj/docker-rails-example/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/nickjj/docker-rails-example/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/nickjj/docker-rails-example/releases/tag/0.1.0
