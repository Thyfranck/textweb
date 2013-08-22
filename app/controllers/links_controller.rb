class LinksController < ApplicationController
  def create
    @link = current_user.links.create(params[:link])
    redirect_to request.referrer
  end

  def rate
    @link = Link.find(params[:id])
    @rate_type = params[:rate]
    respond_to do |format|
      if @link.user_already_rated(current_user.id)
      else
        @new_rate = @link.rates.create(:link_id => @link.id, :plus => @rate_type == "up" ? true : false, :user_id => current_user.id)
      end
      @new_link_status = Link.find(params[:id])
      format.js
    end
  end

  def show
    @link = Link.find(params[:id])
    @youtube_link = @link.youtube?
  end

end