class Image < ActiveRecord::Base
  belongs_to :item
  
  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100#" },
                    # :storage => :s3,
                    # :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
                    # :path => ":attachment/:id/:style.:extension",
                    # :bucket => "iosdev_#{Rails.env}"
end
