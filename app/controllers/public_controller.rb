class PublicController < ApplicationController
  before_filter :require_login, :only => [:suggest_course]

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
    if request.post?
      Notification.send_suggested_course(params[:course], current_user).deliver
      redirect_to request.referer, :notice => "Successfully submitted your suggestion."
    else
      render :layout => false
    end
  end

end
