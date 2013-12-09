class RepliesController < ApplicationController
  before_filter :require_login

  def create
    @reply = current_user.replies.new(params[:reply])
    @reply.save and redirect_to request.referrer
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy and redirect_to request.referrer
  end
end