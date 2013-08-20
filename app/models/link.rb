class Link < ActiveRecord::Base
  attr_accessible :course_id, :description, :url, :creator_type, :approved, :creator_id, :plus_count, :minus_count

  belongs_to :course

  has_many :rates
  has_many :rater_users, :class_name => "User", :foreign_key => "user_id", :through => :rates

  belongs_to :creator, polymorphic: true

end