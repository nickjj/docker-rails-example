require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hello
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Log to STDOUT because Docker expects all processes to log here. You could
    # then collect logs using journald, syslog or forward them somewhere else.
    logger           = ActiveSupport::Logger.new(STDOUT)
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
    config.log_tags  = %i[subdomain uuid]

    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch("REDIS_URL") { "redis://redis:6379/1" },
      namespace: "cache"
    }

    # Set Sidekiq as the back-end for Active Job.
    config.active_job.queue_adapter = :sidekiq

    # Separate Action Cable into its own process.
    config.action_cable.url = ENV.fetch("ACTION_CABLE_FRONTEND_URL") { "ws://localhost:28080" }

    # Action Cable will only allow connections from these domains.
    origins = ENV.fetch("ACTION_CABLE_ALLOWED_REQUEST_ORIGINS") { "http:\/\/localhost*" }.split(",")
    origins.map! { |url| /#{url}/ }
    config.action_cable.allowed_request_origins = origins
  end
end

# Ensure the TailwindCSS JIT compiler exits properly.
Webpacker::Compiler.env["TAILWIND_MODE"] = "build"
