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

end
