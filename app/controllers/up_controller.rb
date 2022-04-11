class UpController < ApplicationController
  def index
    head :ok
  end

  def databases
    redis&.ping
    ActiveRecord::Base.connection.execute("SELECT 1")

    head :ok
  end

  private

  def redis
    Rails.cache.try(:redis)
  end
end
