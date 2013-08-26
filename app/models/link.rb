class Link < ActiveRecord::Base
  attr_accessible :section_id, :user_id, :url, :description, :vote, :status
  
  belongs_to :section
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes,    :dependent => :destroy

  validates :section_id,  :presence => true
  validates :user_id,     :presence => true
  validates :url,         :presence => true, :format => { :with => /(^$)|([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }
  validates :description, :presence => true

  STATUS = {
    :approved => "APPROVED",
    :blocked => "BLOCKED",
    :deleted => "DELETED"
  }

  def youtube?
    uri = URI.parse(url)
    uri.host =~ /youtube\.com/
  end

  def iframe_url
    return url =~ /^http:\/\// ? url : "http://" + url
  end

  def user_already_rated(user_id)
    user = User.find(user_id)
    @votes = user.votes.where("link_id = ?", self.id)
    return @votes.present? ? @votes.first.id : nil
  end

end