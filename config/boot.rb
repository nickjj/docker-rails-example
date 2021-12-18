ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# Set up gems listed in the Gemfile.
require "bundler/setup"

# Speed up boot time by caching expensive operations, but not in production.
require "bootsnap/setup" if Gem.loaded_specs.has_key?("bootsnap")
