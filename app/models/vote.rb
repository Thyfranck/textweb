class Vote < ActiveRecord::Base
  attr_accessible :down, :link_id, :up, :user_id

  belongs_to :link
  belongs_to :user
  
  after_save :update_link_vote, :check_user

  def update_link_vote
    self.link.update_attribute(:vote, self.link.votes.where(:up => true).count - self.link.votes.where(:down => true).count)
  end

  def check_user
    return false if self.user == self.link.user
  end
end
