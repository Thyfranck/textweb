class School < ActiveRecord::Base
  attr_accessible :name

  has_many :courses

  COURSE_PER_PAGE = 10

end