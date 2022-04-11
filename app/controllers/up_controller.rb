class UpController < ApplicationController
  def index
    head :ok
  end

  def databases
    Rails.cache.redis.ping
    ActiveRecord::Base.connection.execute("SELECT 1")

    head :ok
  end
end
