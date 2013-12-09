class Section < ActiveRecord::Base
  attr_accessible :name, :topic_id

  belongs_to :topic
  has_many :links, :dependent => :destroy

  validates :topic_id,    :presence => true
  validates :name,        :presence => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  #  def should_generate_new_friendly_id?
  #    new_record?
  #  end
  
end
