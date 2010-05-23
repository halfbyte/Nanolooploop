class HomeController < ApplicationController
  def index
    @latest_public = Loop.where(:public => true).limit(10).order_by(["created_at", :desc])
    @bestest_public = Loop.where(:public => true).limit(10).order_by(["plays_and_downloads", :desc])
  end

end
