# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def editable?(item)
    admin? || item.user == current_user
  end
  
  def title
    if @title
      "#{@title} : #{config.site_title}"
    else
      config.default_title
    end
  end

	def to_textile(contents)
	  html = RedCloth.new(contents, [:filter_styles, :filter_classes, :filter_ids]).to_html()
    sanitize(html, :tags => %w(a p code b strong i em blockquote ol ul li), :attributes => %w(href))
	end
  
end
