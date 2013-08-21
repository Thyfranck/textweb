#ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "54.226.211.169",
  :user_name            => "contact@mhbweb.com",
  :password             => "qwerty$123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}