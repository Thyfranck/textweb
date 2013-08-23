class School < ActiveRecord::Base
  attr_accessible :name

  has_many :courses, :dependent => :destroy

  COURSE_PER_PAGE = 10

end
