class UpController < ApplicationController
  def index
    head :ok
  end

  def databases
    RedisConn.current.ping
    ActiveRecord::Base.connection.execute("SELECT 1")

    head :ok
  end
end
