class PublicController < ApplicationController

  def index
    @school = School.all
    session.delete(:school)
  end

  def terms_of_service

  end

  def privacy
    
  end

end
