class LinksController < ApplicationController
  before_filter :require_login, :except => [:show, :vote, :download]
  
  def create
    @link = current_user.links.new(params[:link])
    unless @link.save
      flash[:alert] = @link.errors.full_messages.join(", ")
    end
    redirect_to request.referrer
  end
    
    
  def vote
    respond_to do |format|
      if current_user
        @link = Link.find(params[:id])
        @vote_type = params[:rate]

        unless @link.user.id == current_user.id

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

          @link = Link.find(params[:id])

        end
        @no_user = false
        format.js
      else
        @url = login_url
        flash[:alert] = "You must be logged in to view the contents of this page! Sign in."
        @no_user = true
        format.js
      end
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

  def approve
    @link = Link.find(params[:id])
    if current_user.moderator?(@link.section.topic.course)
      @link.approved? ? @link.unapprove : @link.approve
    end
    redirect_to request.referrer
  end

  def destroy
    @link = Link.find(params[:id])
    if current_user.moderator?(@link.section.topic.course)
      @link.destroy
    end
    redirect_to request.referrer
  end

end