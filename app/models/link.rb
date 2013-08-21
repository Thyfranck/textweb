class Link < ActiveRecord::Base
  attr_accessible :course_id, :description, :url, :creator_type, :approved, :creator_id, :plus_count, :minus_count

  belongs_to :course

  has_many :rates
  has_many :rater_users, :class_name => "User", :foreign_key => "user_id", :through => :rates

  belongs_to :creator, polymorphic: true

  validates :url, :presence => true
  validates :description, :presence => true
  after_create :set_approved

  def set_approved
    self.approved = false
    save
  end

  def user_already_rated(user_id)
    rates = self.rates
    return rates.where(:user_id => user_id).present? ? true : false
  end
end