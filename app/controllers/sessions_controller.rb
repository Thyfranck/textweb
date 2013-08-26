class SessionsController < ApplicationController

  def new
    redirect_to home_schools_path if current_user
  end

  def create
    if @user = User.authenticate(params[:email], params[:password], params[:remember_me])
      set_current_school(@user.school_id)
      redirect_back_or_to home_schools_path, :notice => "Logged in!"
    else
      flash[:alert] = "Email or Password was invalid!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
