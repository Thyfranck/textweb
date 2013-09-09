class CommentsController < ApplicationController

  before_filter :require_login

  def create
    comment = current_user.comments.create(params["comment"])
    unless comment.save
      flash[:alert] = "Sorry, comment could not be posted. Please, try again later."
    end
    redirect_to request.referrer
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy and redirect_to request.referrer
  end

end