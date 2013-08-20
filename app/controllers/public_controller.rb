class PublicController < ApplicationController

  def index
    @school = School.all
    render :layout => "home"
  end

  def home
  end

end
