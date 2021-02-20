# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

- Nothing yet!

## [0.2.0] - 2021-02-20

### Added

- Hotwire through Webpack
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

[Unreleased]: https://github.com/nickjj/docker-rails-example/compare/0.2.0...HEAD
[0.2.0]: https://github.com/nickjj/docker-rails-example/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/nickjj/docker-rails-example/releases/tag/0.1.0
