class SuggestedCourse < ActiveRecord::Base
  attr_accessible :name, :title, :user_id

  belongs_to :user
end
