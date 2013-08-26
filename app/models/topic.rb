class Topic < ActiveRecord::Base
  attr_accessible :course_id, :name

  belongs_to :course
  has_many :sections, :dependent => :destroy

  validates :course_id,   :presence => true
  validates :name,        :presence => true
end
