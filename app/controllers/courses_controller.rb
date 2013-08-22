class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
    @topics = @course.topics
    if params[:topic_id]
      @topic_id = params[:topic_id]
      @topic = Topic.find(params[:topic_id])
      @approved_links = @topic.links.where(:approved => true).order("id DESC")
      @unapproved_links = @topic.links.where(:approved => false).order("id DESC")
      @link = Link.new
    end
  end

end
