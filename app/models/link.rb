class Link < ActiveRecord::Base
  mount_uploader :file, FileUploader
  
  attr_accessible :section_id, :user_id, :url, :description, :vote, :status, :file
  
  belongs_to :section
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes,    :dependent => :destroy

  validates :url, :presence => true, :format => { :with => /(^$)|([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix },
    :if => lambda{ |l| l.url.present? or l.file.blank? }
  validates :description, :presence => true

  before_save :check_validity

  def check_validity
    if self.url.present?
      begin
        uri = URI.parse(self.url)
        if uri.host.include?("youtube.com")
          self.url = self.url.gsub("feature=player_embedded&", "")
        end
      rescue
        return false
      end
    end
  end

  STATUS = {
    :approved => "APPROVED",
    :blocked => "BLOCKED",
    :deleted => "DELETED"
  }

  def name
    self.host
  end

  def mime
    MIME::Types.type_for(self.file.url).first.content_type
  end

  def file_extension
    self.file.file.extension.downcase
  end

  def disposition
    extension = self.file.file.extension.downcase
    if %w{jpg jpeg gif png pdf}.include?(extension)
      disposition = 'inline'
    else
      disposition = 'attachment'
    end
    disposition
  end

  def picture?
    mime.downcase.include?("image")
  end

  def youtube?
    if self.url.present?
      uri = URI.parse(iframe_url)
      uri.host =~ /youtube\.com/
    else
      return false
    end
  end

  def iframe_url
    return url =~ /^(http|https):\/\// ? url : "http://" + url
  end

  def host
    URI.parse(iframe_url).host
  end

  def user_already_rated(user_id)
    user = User.find(user_id)
    @votes = user.votes.where("link_id = ?", self.id)
    return @votes.present? ? @votes.first.id : nil
  end

  def approve
    self.status = STATUS[:approved]
    self.save
  end

  def unapprove
    self.status = nil
    self.save
  end

  def approved?
    self.status == STATUS[:approved]
  end

  def up_voted_by(user)
    vote = self.votes.find_by_user_id(user.id)
    vote.present? and vote.up and !vote.down ? true : false
  end

  def down_voted_by(user)
    vote = self.votes.find_by_user_id(user.id)
    vote.present? and !vote.up and vote.down ? true : false
  end

end