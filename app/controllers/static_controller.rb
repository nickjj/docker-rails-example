class StaticController < ApplicationController
  def home
  end

  def up
    ActiveRecord::Base.connection.execute("SELECT 1")
    head :ok
  end
end
