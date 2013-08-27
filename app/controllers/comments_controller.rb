class CommentsController < ApplicationController

  before_filter :require_login

  def create
    comment = current_user.comments.create(params["comment"])
    @url = comment.save ? request.referrer : nil
  end

end