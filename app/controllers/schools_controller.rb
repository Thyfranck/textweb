class SchoolsController < ApplicationController

  before_filter :require_school_session, :except => [:set_session]
  before_filter :require_login, :except => [:set_session]

  def home
    @courses = School.find(session[:school]).courses
#    render :layout => false
  end

  def courses
    per_page = 4
    page = params[:page].to_i
    courses = School.find(session[:school]).courses.limit(per_page).offset((page - 1)*per_page)
    render :json => {"total" => courses.count, "course" => courses}.to_json
#    respond_to do |format|
#      format.json
#    end
  end

  def set_session
    session[:school] = params["school"]
    redirect_to login_path
  end

end
