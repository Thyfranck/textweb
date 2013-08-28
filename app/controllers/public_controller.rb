class PublicController < ApplicationController

  def index
    @school = School.all
    if current_user.present?
      redirect_to home_schools_path
    else
      session.delete(:school)
    end
  end

  def terms_of_service

  end

  def privacy
    
  end

end
