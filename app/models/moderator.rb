class Moderator < ActiveRecord::Base
  attr_accessible :course_id, :user_id, :status

  belongs_to :course
  belongs_to :user

  validates :user_id, :presence => true, :uniqueness => { :scope => :course_id }
  validates :course_id, :presence => true
end
