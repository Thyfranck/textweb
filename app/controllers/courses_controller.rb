class CoursesController < ApplicationController

  before_filter :require_login
  
  def show
    @course = Course.find(params[:id])
    @topics = @course.topics
    @topic_id = params[:topic_id].present? ? params[:topic_id] : (@topics.size > 0 ? @topics.first.id : nil)
    @topic = Topic.find(@topic_id) if @topic_id.present?
    if @topic.present?
      @approved_links = @topic.links.where(:approved => true).order("id DESC")
      @unapproved_links = @topic.links.where(:approved => false).order("id DESC")
      @link = Link.new
    end
  end

end
