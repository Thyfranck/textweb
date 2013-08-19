class Course < ActiveRecord::Base
  attr_accessible :name, :school_id

  belongs_to :school
  has_many :links
end