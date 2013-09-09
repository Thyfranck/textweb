class CourseAdmin < ActiveRecord::Base
  attr_accessible :active, :course_id, :user_id

  belongs_to :user
  belongs_to :course

  validates :course_id, :presence => true
  validates :user_id, :presence => true

  before_create :check_user_and_course

  def check_user_and_course
    return CourseAdmin.where("user_id = ? and course_id =?", self.user_id, self.course_id).blank? ? true : false
  end
end
