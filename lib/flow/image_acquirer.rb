require 'open-uri'

class ImageAcquirer
  attr_accessor :url
  
  def initialize(url)
    self.url = url
  end
  
  def get_images
    nok = Nokogiri::HTML(open(self.url).read)
    nok.css('img').collect {|img| img.attr('src')}
  end
end