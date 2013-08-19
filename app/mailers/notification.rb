class Notification < ActionMailer::Base
  default from: "tanim@iconsbd.com"

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

end


