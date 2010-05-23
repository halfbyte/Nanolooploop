class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    raise "hackers?" unless data = RPXNow.user_data(params[:token])
    logger.debug(data.inspect)
    self.current_user = User.first(:conditions => {:identifier => data[:identifier]}) || User.create!(data)
    redirect_to root_path
  end
  
  def destroy
    self.current_user = session[:user_id] = nil
    redirect_to new_session_url
  end
    
  def new
    
  end
end
