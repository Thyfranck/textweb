class SchoolsController < ApplicationController

  #before_filter :require_current_school, :except => [:set_session]
  #before_filter :require_login, :except => [:set_session, :home]

  def home
    set_current_school(School.first.id)
    @courses = current_school.courses.page(params[:page]).order("courses.name ASC")
  end

  def courses
    @courses = current_school.courses.page(params[:page]).order("courses.name ASC")
    respond_to do |format|
      format.js
    end
  end

  def set_session
    set_current_school(params["school"])
    redirect_to login_path
  end

end
