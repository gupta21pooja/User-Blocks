class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  helper_method :user_session
  
  def user_session
    return @user_session if defined?(@user_session)
    return nil if session[:session_id].blank?
    @user_session = UserSession.find_or_create_by(:session_id => session[:session_id])
    @user_session
  end
  
  def authorize
    unless session[:session_id].present?
      redirect_to '/'
    end
  end

end
