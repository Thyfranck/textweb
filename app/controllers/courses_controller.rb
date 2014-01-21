class CoursesController < ApplicationController

  before_filter :require_login
  
  def show
    if params[:id]
      @course = Course.find(params[:id])
    elsif params[:course_id]
      @course = Course.find(params[:course_id])
    end
    @topics = @course.topics
    
    if params[:topic_id]
      @topic = Topic.find(params[:topic_id])
      @topic_id = params[:topic_id].present? ? @topic.id : (@topics.size > 0 ? @topics.first.id : nil)
    end
    
    if params[:section_id]
      @section = Section.find(params[:section_id])
      @section_id = @section.id
      @approved_links = @section.links.where(:status => Link::STATUS[:approved]).includes(:votes).order("id DESC")
      @unapproved_links = @section.links.where(:status => nil).includes(:votes).order("id DESC")
    end
    @new_link = Link.new
  end

end
