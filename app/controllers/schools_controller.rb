class SchoolsController < ApplicationController

  before_filter :require_school_session, :except => [:set_session]
  before_filter :require_login, :except => [:set_session]

  def home
    @school = School.find(session[:school])
    @courses = @school.courses.order("courses.name ASC").limit(School::COURSE_PER_PAGE)
  end

  def courses
    page = params[:page].to_i
    @courses = School.find(session[:school]).courses.order("courses.name ASC").limit(School::COURSE_PER_PAGE).offset((page - 1)*School::COURSE_PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  def set_session
    session[:school] = params["school"]
    redirect_to login_path
  end

end
