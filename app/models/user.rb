class User < ActiveRecord::Base
  has_many :items, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  
  has_secure_password
  validates_presence_of :password, :on => :create 
  
  validates_presence_of     :login
  validates_uniqueness_of   :login, :case_sensitive => false
  validates_format_of       :login, :with => /^\w+$/
  validates_length_of       :login,    :within => 3..40
  
  validates_presence_of     :api_key
  
  validates_presence_of     :email
  validates_uniqueness_of   :email

  validates_format_of       :url, :with => /^(|http\:\/\/.*)$/

  before_validation :ensure_api_key

  attr_accessible :login, :email, :url, :password
  
  def reset_password
    self.password_reset_token = UUID.new.generate(:compact)
    self.save!
  end

  def reset_api_key
    self.api_key = nil
    self.save
  end

  def login=(val)
    write_attribute(:login, val.try(:downcase).try(:strip))
  end

  private
  def ensure_api_key
    self.api_key = UUID.new.generate(:compact) if self.api_key.blank?
  end
end
