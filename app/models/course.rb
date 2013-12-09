class Course < ActiveRecord::Base
  self.per_page = 10
  mount_uploader :image, ImageUploader

  attr_accessible :name, :school_id, :description, :title, :image

  belongs_to :school
  has_many :topics, :dependent => :destroy
  has_many :moderators, :dependent => :destroy

  validates :school_id,   :presence => true
  validates :name,        :presence => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    new_record?
  end
end