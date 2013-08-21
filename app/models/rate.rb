class Rate < ActiveRecord::Base
  attr_accessible :link_id, :minus, :plus, :user_id

  belongs_to :link
  after_create :update_link_rating

  def update_link_rating
    if self.plus == true
      if self.link.plus_count
        self.link.plus_count = self.link.plus_count + 1
      else
        self.link.plus_count = 1
      end
    else
      if self.link.minus_count
        self.link.minus_count = self.link.minus_count + 1
      else
        self.link.minus_count = 1
      end
    end
    self.link.save
  end
end
