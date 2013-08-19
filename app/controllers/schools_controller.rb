class SchoolsController < ApplicationController

  before_filter :require_school_session, :except => [:set_session]
  before_filter :require_login, :except => [:set_session]

  def home
    @courses = School.find(session[:school]).courses
  end

  def set_session
    session[:school] = params["school"]
    redirect_to home_schools_path
  end

end
