class Topic < ActiveRecord::Base
  attr_accessible :course_id, :title

  belongs_to :course
  has_many :links
end
