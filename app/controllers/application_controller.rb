class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :catch_not_found if Rails.env != "development"

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "Record not found." }
  end

  def current_school
    if current_user
      @current_school = current_user.school
    else
      @current_school ||= School.find(session[:school]) if session[:school].present?
    end
  end

  hide_action :current_school
  helper_method :current_school

  private

  def set_current_school(school_id)
    session[:school] = school_id
  end

  def not_authenticated
    redirect_to login_url, :alert => "You must be logged in to view the contents of this page! Sign in."
  end

  def require_current_school
    if current_school.blank?
      session[:referrer] = request.url
      redirect_to root_path , :alert => "Please select your school."
    end
  end

end
