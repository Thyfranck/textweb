class School < ActiveRecord::Base
  attr_accessible :name, :email_postfix

  has_many :users,   :dependent => :destroy
  has_many :courses, :dependent => :destroy

  validates :name,            :presence => true
  validates :email_postfix,   :presence => true

  COURSE_PER_PAGE = 10
  
end
