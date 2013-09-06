#ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtpout.secureserver.net",
  :port                 => 3535,
  :domain               => "courselinks.co",
  :user_name            => "info@courselinks.co",
  :password             => "virginia10",
  :authentication       => "plain"
}