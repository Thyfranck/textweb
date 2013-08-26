class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :school_id, :first_name, :last_name, :email,
    :password, :password_confirmation

  belongs_to :school
  has_many :links,    :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes,    :dependent => :destroy

  validates :school_id, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :uniqueness => true, :format =>  { :with => /^[\w\.\+-]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$/ }
  validates_length_of :password, :minimum => 6, :if => :password
  validates_confirmation_of :password, :if => :password

  def name
    "#{first_name} #{last_name}"
  end

  def resend_activation_email!
    send_activation_needed_email!
  end

  def self.authenticate_without_active_check(*credentials)
    prevent_check = self.sorcery_config.before_authenticate.delete(:prevent_non_active_login)
    user = self.authenticate(*credentials)
    self.sorcery_config.before_authenticate << prevent_check if prevent_check
    return user
  end

  def make_email_format
    self.email = self.email + "@" +self.school.email_postfix
  end

  def self.authenticate_without_active_check(*credentials)
    prevent_check = self.sorcery_config.before_authenticate.delete(:prevent_non_active_login)
    user = self.authenticate(*credentials)
    self.sorcery_config.before_authenticate << prevent_check if prevent_check
    return user
  end

end
