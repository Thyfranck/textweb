class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id, :status, :user_id

  belongs_to :user
  belongs_to :link

  validates :link_id,   :presence => true
  validates :user_id,   :presence => true
  validates :content,   :presence => true

  scope :approved, -> { where(status: STATUS[:approved]) }

  STATUS = {
    :approved => "APPROVED",
    :blocked => "BLOCKED",
    :deleted => "DELETED"
  }
end
