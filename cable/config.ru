# This file is used to start the Action Cable server.

require_relative "../config/environment"
Rails.application.eager_load!

run ActionCable.server
