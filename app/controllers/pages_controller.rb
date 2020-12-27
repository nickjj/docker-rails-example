class PagesController < ApplicationController
  def home
  end

  def up
    Redis.current.ping
    ActiveRecord::Base.connection.execute("SELECT 1")

    head :ok
  end
end
