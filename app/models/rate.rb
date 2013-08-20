class Rate < ActiveRecord::Base
  attr_accessible :link_id, :minus, :plus, :user_id
end
