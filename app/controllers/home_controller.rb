class HomeController < ApplicationController
  skip_before_filter :authorize
  before_filter :set_cookies

  def index
    redirect_to blocks_url
  end

  def set_cookies
    if cookies[:key].blank?
      cookies.delete :key
      cookies[:key] = session[:session_id]
    elsif params[:session_id].blank?
      session[:session_id] =  params[:session_id]
    else
      session.delete :session_id
      session[:session_id] =  cookies[:key]
    end
  end
end
