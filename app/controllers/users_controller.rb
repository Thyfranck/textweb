class UsersController < ApplicationController

  before_filter :require_current_school, :except => [:email_verification, :email_confirmation_page]
  before_filter :require_login, :only => [:show, :settings, :change_password]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(current_user.id)
    render :layout => "profile"
  end

  def settings
    @user = User.find(current_user.id)
    render :layout => "profile"
  end

  def create
    @user = current_school.users.new(params[:user])
    @user.make_email_format
    if @user.save
      session[:email_confirmation] = @user.id
      redirect_to email_confirmation_page_user_path(@user), :notice => "You need to confirm your email address in order to continue"
    else
      @user.email = @user.email.gsub(/\@\S*/, "")
      render :new
      flash.now.alert = "Sorry there was a problem. Please, try again."
    end
  end

  def email_confirmation_page
    if session[:email_confirmation].present? and session[:email_confirmation].to_i == params[:id].to_i
      @user = User.find(session[:email_confirmation])
      if @user.active?
        redirect_to root_path
      elsif current_school.blank?
        set_current_school(@user.school_id)
      end
    else
      redirect_to root_path
    end
  end

  def resend_activation_email
    @user = User.find(params[:id])
    
    if params[:email].present?
      @user.email = params[:email]
      @user.make_email_format
    end
    
    if @user.save and @user.resend_activation_email!
      redirect_to email_confirmation_page_user_path(@user), :notice => "Confirmation email sent to #{@user.email}"
    else
      redirect_to email_confirmation_page_user_path(@user), :alert => "Invalid Email Address!"
    end
  end

  def email_verification
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      set_current_school(@user.school_id)
      auto_login(@user)
      redirect_to home_schools_path, :notice => "Your account is now verified."
    else
      not_authenticated
    end
  end

  def change_password
    @user = User.find(current_user.id)
    
    if @user.update_attributes(:password => params["password"], :password_confirmation => params["password_confirmation"])
      redirect_to @user, :notice => "Password was successfully updated!"
    else
      render :settings, :layout => "profile"
    end
  end

end
