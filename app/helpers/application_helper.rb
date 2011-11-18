module ApplicationHelper
  def editable?(item)
    admin? || item.user == current_user
  end
  
  def title
    if @title
      "#{@title} : #{site_config.site_title}"
    else
      site_config.default_title
    end
  end
  
  def to_textile(contents)
	  html = RedCloth.new(contents, [:filter_styles, :filter_classes, :filter_ids]).to_html()
    sanitize(html, :tags => %w(a p code b strong i em blockquote ol ul li), :attributes => %w(href))
	end
	
	def captcha
	  seed_captcha if !defined?(@captcha_value)
	  @captcha_value
  end
  
  def captcha_guide
    seed_captcha if !defined?(@captcha_value)
    @captcha_guide
  end
  
  def random_word
    @random_word
  end
  
  private
  
  def seed_captcha
    words = %w{renegade nevergonna giveyouup letyoudown runaround starla luckystiff inside an at ax al pol paypal nidd nid pin pit pragmatic astley twogirls onecup felch kwyjibo covenham kenwick grimsby warlingham cooper macbook triumph air mascot football hockey tennis shadow bullet metaphor flyer twitter yahoo google coding ruby masterplan spyhole porthole boat float granite trousers dragon tiger}
    post_words = %w{in ox et by rat tar al s ty ax ak an at de er ers}
    
    @captcha_value = ""
  	
    random_word = words[rand(words.size)] + post_words[rand(post_words.size)]
    random_word.each_char do |char|
      @captcha_value << char.upcase
    end
    
    @random_word = random_word
    
    @captcha_guide = Digest::SHA1.hexdigest(random_word.upcase)[0..5]
  end
end