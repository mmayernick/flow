module ApplicationHelper
  def editable?(item)
    admin? || item.user == current_user
  end
  
  def title
    if @title
      "#{@title} | #{site_config.site_title}"
    else
      site_config.default_title
    end
  end
end