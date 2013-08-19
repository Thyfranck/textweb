#ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "localhost",
  :user_name            => "tanim@iconsbd.com",
  :password             => "tanimotogj456",
  :authentication       => "plain",
  :enable_starttls_auto => true
}