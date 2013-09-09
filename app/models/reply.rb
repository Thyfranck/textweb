class Reply < ActiveRecord::Base
  attr_accessible :comment_id, :content, :user_id

  belongs_to :user
  belongs_to :comment
  
end
