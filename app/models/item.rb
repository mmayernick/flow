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
  validates_length_of       :byline, :maximum => 18, :if => :byline?
  
  named_scope :all, :order => 'created_at DESC', :include => :user
  
  before_save :anonymize_byline, :if => :anonymous?
  
  def anonymous?
    (self.user_id.nil? || self.user.nil?) && (self.byline.nil? || self.byline.blank? || self.byline == 'Anonymous Coward')
  end
  
  def anonymize_byline
    self.byline = 'Anonymous Coward'
  end
  
  def self.find_by_id_or_name(id_or_name)
    find(id_or_name) rescue find_by_name(id_or_name)
  end
  
  def to_param
    self[:name] && self[:name].length > 3 ? self[:name] : self[:id]
  end

	def is_starred_by_user(user)
		user.starred_items.include? self
	end
	
	def self.per_page
    50
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
