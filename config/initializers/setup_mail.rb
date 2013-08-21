#ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "textweb.com",
  :user_name            => "contact@mhbweb.com",
  :password             => "qwerty$123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}