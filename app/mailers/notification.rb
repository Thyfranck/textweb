class Notification < ActionMailer::Base
  default from: "\"TextWeb\" <info@textweb.com>"

  def activation_needed_email(user)
    @user = user
    @url  = email_verification_user_url(user.activation_token)
    headers['X-SMTPAPI'] = "{\"category\" : \"Activation Needed\"}"
    mail(:to      => user.email,
      :subject => "Click to activate your account")
  end

  def activation_success_email(user)
    @user = user
    @url = root_url
    headers['X-SMTPAPI'] = "{\"category\" : \"Welcome Email\"}"
    mail(:to => user.email,
      :subject => "Your account is now activated")
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
      :subject => "Your password has been reset")
  end

end


