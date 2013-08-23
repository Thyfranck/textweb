class SessionsController < ApplicationController

  before_filter :require_school_session, :except => [:destroy]
  before_filter :redirect_current_user_to_home, :except => [:destroy]
  layout "home"

  def new
  end

  def create
    if @user = User.authenticate(params[:email], params[:password])
      auto_login(@user)
      redirect_back_or_to home_schools_path, :notice => "Logged in!"
    else
      if @user = User.authenticate_without_active_check(params[:email],params[:password])
        flash[:alert] = "Please check your Email to activate your account."
        redirect_to login_path 
      else
        flash[:alert] = "Email or Password was invalid!"
        render :new
      end
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  

end
