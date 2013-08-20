class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation

  has_many :links, as: :creator

  has_many :rates
  has_many :rated_links, :class_name => "Link", :foreign_key => "link_id", :through => :rates

  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  def resend_activation_email!
    send_activation_needed_email!
  end

end
