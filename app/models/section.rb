class Section < ActiveRecord::Base
  attr_accessible :name, :topic_id

  belongs_to :topic
  has_many :links, :dependent => :destroy

  validates :topic_id,    :presence => true
  validates :name,        :presence => true
  
end
