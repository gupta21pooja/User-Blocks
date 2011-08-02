class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cookies,:set_user_session
  helper_method :set_user_session
  
  def set_user_session
    return @user_session if defined?(@user_session)
    return nil if session[:session_id].blank?
    @user_session = UserSession.find_or_create_by(:session_id => session[:session_id])
    @user_session
   end
  
  def set_cookies
    if cookies[:key].blank?
      cookies.delete :key
      cookies[:key] = session[:session_id]
    else
      session.delete :session_id
      session[:session_id] =  cookies[:key]
    end
  end
end
