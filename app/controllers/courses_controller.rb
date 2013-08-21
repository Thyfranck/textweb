class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
    @approved_links = @course.links.where(:approved => true).order("id DESC")
    @unapproved_links = @course.links.where(:approved => false).order("id DESC")
    @link = Link.new
  end

end
