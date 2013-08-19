class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation

  has_many :links, as: :creator

  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  def resend_activation_email!
    send_activation_needed_email!
  end

end
