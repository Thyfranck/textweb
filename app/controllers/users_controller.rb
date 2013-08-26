class UsersController < ApplicationController

  before_filter :require_current_school, :except => [:email_verification]
  before_filter :require_login, :only => [:profile, :change_password]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to email_confirmation_page_user_path(@user), :notice => "You need to confirm your email address in order to continue"
    else
      render :new
      flash.now.alert = "Sorry there was a problem. Please, try again."
    end
  end

  def email_confirmation_page
    @user = User.find(params[:id])
  end

  def resend_activation_email
    @user = User.find(params[:id])
    notice = ""
    if params[:email].present?
      if @user.update_attributes(:email => params[:email])
        notice = "updated email address to "+ params[:email]
      else
        notice = "could not update email address"
      end
    end
    if @user.resend_activation_email!
      redirect_to email_confirmation_page_user_path(@user), :notice => "Email sent successfully to #{@user.email}. "+ notice
    else
      redirect_to email_confirmation_page_user_path(@user), :notice => "Sorry there was a problem. Plz, try again later. "+ notice
    end
  end

  def email_verification
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      auto_login(@user)
      redirect_to home_schools_path, :notice => "Your account is now verified."
    else
      not_authenticated
    end
  end

  def profile
    render :layout => "profile"
  end

  def change_password
    if current_user.update_attributes(:password => params["password"], :password_confirmation => params["password_confirmation"])
      flash[:notice] = "Password changed successfully"
      redirect_to profile_user_path(current_user)
    else
      flash[:alert] = "Sorry there was a problem"
      render :profile, :layout => "profile"
    end
  end

end
