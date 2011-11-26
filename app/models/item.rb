class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
	has_many :stars, :dependent => :destroy

  serialize :metadata

  attr_protected :user_id

  validates_length_of       :title, :within => 4..255
  validates_uniqueness_of   :name, :if => :name?
  validates_format_of       :name, :with => /^[\w\-\_]+$/, :if => :name?, :message => 'is invalid (alphanumerics, hyphens and underscores only)'
  validates_length_of       :name, :within => 4..255, :if => :name?
  validates_length_of       :content, :within => 25..1200
  validates_length_of       :byline, :maximum => 50, :if => :byline?

  validates :url, :presence => true, :uniqueness => true

  scope :newest_first, order('items.id DESC')
  scope :search, lambda {|t|
    where(["LOWER(items.title) LIKE ? OR LOWER(items.name) LIKE ? OR LOWER(items.url) LIKE ?", "%#{t.downcase.strip}%", "%#{t.downcase.strip}%", "%#{t.downcase.strip}%"])
  }

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100#" },
                    :storage => :s3,
                    :s3_credentials => {access_key_id: ENV['AMAZON_ACCESS_KEY_ID'] || "", secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'] || ""},
                    :s3_permissions => :public_read,
                    :path => ":attachment/:id/:style.:extension",
                    :bucket => "iosdev_#{Rails.env}",
                    :default_url => '/assets/images/missing.png'


  before_save :anonymize_byline, :if => :anonymous?

  def as_json(opts = {})
    {
      :id => id,
      :url => url,
      :title => title,
      :name => name,
      :byline => byline,
      :comments_count => comments_count,
      :stars_count => stars_count
    }
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def anonymous?
    (self.user_id.nil? || self.user.nil?) && (self.byline.nil? || self.byline.blank? || self.byline == 'Anonymous')
  end

  def anonymize_byline
    self.byline = 'Anonymous'
  end

  def tweetable?
    user && user.approved_for_feed == 1
  end

  def self.find_by_id_or_name(id_or_name)
    find(id_or_name) rescue find_by_name(id_or_name)
  end

  def is_starred_by_user(user)
    user.starred_items.include? self
  end

  def self.per_page
    25
  end

  # TODO move to a helper
  def starred_class(user)
    if self.is_starred_by_user(user)
      return "starred"
    else
      return ""
    end
  end
end
