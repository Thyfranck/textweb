class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  attr_accessible :name, :school_id, :description, :title, :image

  belongs_to :school
  has_many :topics, :dependent => :destroy
  has_many :moderators, :dependent => :destroy

  validates :school_id,   :presence => true
  validates :name,        :presence => true
  
end