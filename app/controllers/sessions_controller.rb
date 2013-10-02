class SessionsController < ApplicationController

  def new
    if session[:referrer].present?
      redirect_to session.delete(:referrer)
    elsif current_user
      redirect_to home_schools_path
    end
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      if session[:course_suggestion].present?
        redirect_to suggest_course_submit_path
      else
        redirect_back_or_to home_schools_path, :notice => "Logged in!"
      end
    else
      if User.authenticate_without_active_check(params[:email],params[:password])
        flash[:alert] = "Please check your email to activate your account."
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
