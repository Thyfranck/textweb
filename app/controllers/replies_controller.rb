class RepliesController < ApplicationController
  def create
    @reply = current_user.replies.new(params[:reply])
    @reply.save and redirect_to request.referrer
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy and redirect_to request.referrer
  end
end