class SessionsController < ApplicationController

  before_filter :require_school_session, :except => [:destroy]

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to home_schools_path, :notice => "Logged in!"
    else
      render :new
      flash.now.alert = "Email or password was invalid."
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
