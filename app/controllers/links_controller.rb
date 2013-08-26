class LinksController < ApplicationController
  before_filter :require_login
  
  def create
    @link = current_user.links.new(params[:link])
    if @link.save
      @url = request.referrer
    else
      @error = 'yes'
    end
  end
    
    
  def vote
    @link = Link.find(params[:id])
    @vote_type = params[:rate]
    respond_to do |format|
      @vote_id = @link.user_already_rated(current_user.id)
      if @vote_id.present?
        @vote = Vote.find(@vote_id)
        if @vote.up == @vote.down
          @vote.update_attributes(@vote_type == "up" ? {:up => true, :down => false} : {:down => true, :up => false})
        else
          @vote.update_attributes(@vote_type == "up" ? {:up => true} : {:down => true})
        end     
      else
        @new_vote = @link.votes.create(@vote_type == "up" ? {:up => true, :user_id => current_user.id} : {:down => true, :user_id => current_user.id})
      end
      @new_link_status = Link.find(params[:id])
      format.js
    end
  end

  def show
    @link = Link.find(params[:link_id])
    @section = @link.section
    @section_id = @section.id
    @topic = @section.topic
    @course = @topic.course
    @topics = @course.topics
    @topic_id = @topic.id
    @youtube_link = @link.youtube?
  end

end