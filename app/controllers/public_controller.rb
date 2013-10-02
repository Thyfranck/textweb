class PublicController < ApplicationController
  def index
    @school = School.all
    if current_user.present?
      redirect_to home_schools_path
    else
      set_current_school(School.first.id)
      #session.delete(:school)
    end
  end

  def terms_of_service

  end

  def privacy
    
  end

  def suggest_course
    session.delete(:course_suggestion) if session[:course_suggestion].present?
    render :layout => false
  end

  def suggest_course_submit
    if current_user
      course = params[:course].present? ? params[:course] : session[:course_suggestion].present? ? session.delete(:course_suggestion) : nil
      Notification.send_suggested_course(course, current_user).deliver if course.present?
      redirect_to root_path, :notice => "Successfully submitted your suggestion."
    else
      session[:course_suggestion] = params[:course]
      redirect_to login_path, :alert => "You must be logged in to submit course suggestion!"
    end
  end

end
