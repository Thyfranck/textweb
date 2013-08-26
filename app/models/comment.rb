class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id, :status, :user_id

  belongs_to :user
  belongs_to :link

  validates :link_id,   :presence => true
  validates :user_id,   :presence => true
  validates :content,   :presence => true

  STATUS = {
    :approved => "APPROVED",
    :blocked => "BLOCKED",
    :deleted => "DELETED"
  }
end
