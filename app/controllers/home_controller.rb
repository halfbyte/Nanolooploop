class HomeController < ApplicationController
  def index
    @latest_public = Loop.all(:conditions => {:public => true}, :limit => 10, :order => "created_at DESC")
    @bestest_public = Loop.all(:conditions => {:public => true}, :limit => 10, :order => "plays_and_downloads DESC")
  end

end
