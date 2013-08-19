class PublicController < ApplicationController
  def index
    @school = School.all
  end

  def home
  end

end
