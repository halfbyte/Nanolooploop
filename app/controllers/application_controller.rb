# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_iphone_view
  helper :all # include all helpers, all the time
  helper_method :logged_in?, :current_user, :maildrop
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
protected
  
  def current_user
    @current_user || (session[:user_id] ? User.find(session[:user_id]) : nil)
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user=(user)
    return if user.nil?
    @current_user = user
    session[:user_id] = user.id
  end
  
  def login_required
    return true if logged_in?
    flash[:notice] = "You need to be logged in to use this page"
    redirect_to new_session_url
    false
  end

  def maildrop(user, priv)
    "loopstore+#{user.id}#{priv ? "P" : "p"}#{priv ? user.mail_drop_private : user.mail_drop_public}@googlemail.com"

  end
  def set_iphone_view
    if iphone_request?
      request.format = :iphone
    end
  end

  def iphone_request?
    (agent = request.env["HTTP_USER_AGENT"]) && agent[/(Mobile\/.+Safari)/]
  end

end
