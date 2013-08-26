class SessionsController < ApplicationController

  def new
    redirect_to home_schools_path if current_user
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to home_schools_path, :notice => "Logged in!"
    else
      if User.authenticate_without_active_check(params[:email],params[:password])
        flash[:alert] = "Please check your Email to activate your account."
      else
        flash[:alert] = "Email or Password was invalid!"
      end
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
