class Link < ActiveRecord::Base
  attr_accessible :course_id, :description, :url, :creator_type, :approved, :creator_id, :plus_count, :minus_count

  belongs_to :course

  belongs_to :creator, polymorphic: true

end