class ApplicationController < ActionController::Base
  protect_from_forgery



  private

  def not_authenticated
    redirect_to login_url, :alert => "First log in to view this page."
  end

  def require_school_session
    redirect_to root_path if session[:school].nil?
  end

end
