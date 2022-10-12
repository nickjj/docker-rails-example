class UpController < ApplicationController
  def index
    head :ok
  end

  def databases
    RedisClient.current.ping
    ActiveRecord::Base.connection.execute("SELECT 1")

    head :ok
  end
end
