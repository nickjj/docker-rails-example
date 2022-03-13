if Rails.env.development?
  Rack::MiniProfiler.config.enable_hotwire_turbo_drive_support = true
end
