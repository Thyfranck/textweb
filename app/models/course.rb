class Course < ActiveRecord::Base
  attr_accessible :name, :school_id, :description

  belongs_to :school

  has_many :topics
end