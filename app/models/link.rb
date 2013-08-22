class Link < ActiveRecord::Base
  attr_accessible :topic_id, :description, :url, :creator_type, :approved, :creator_id, :plus_count, :minus_count

  belongs_to :topic

  has_many :rates
  has_many :rater_users, :class_name => "User", :foreign_key => "user_id", :through => :rates

  belongs_to :creator, polymorphic: true

  validates :url, :presence => true, :format => /(^$)|([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix 
  validates :description, :presence => true
  after_create :set_approved

  def set_approved
    self.approved = false
    save
  end

  def user_already_rated(user_id)
    rates = self.rates
    return rates.where(:user_id => user_id).present? ? true : false
  end

  def youtube?
    uri = URI.parse(url)
    uri.host =~ /youtube\.com/
  end

  def iframe_url
    return url =~ /^http:\/\// ? url : "http://" + url
  end

end