class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :point

  has_many :links, as: :creator

  has_many :rates
  has_many :rated_links, :class_name => "Link", :foreign_key => "link_id", :through => :rates

  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  def resend_activation_email!
    send_activation_needed_email!
  end

  def self.authenticate_without_active_check(*credentials)
    prevent_check = self.sorcery_config.before_authenticate.delete(:prevent_non_active_login)
    user = self.authenticate(*credentials)
    self.sorcery_config.before_authenticate << prevent_check if prevent_check
    return user
  end

end
