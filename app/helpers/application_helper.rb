module ApplicationHelper
  def editable?(item)
    is_admin? || item.user == current_user
  end
  
  def title(val = nil)
    if @title && val.nil?
      "#{@title} | #{site_config.site_title}"
    elsif !val.nil?
      @title = val
    else
      site_config.default_title
    end
  end
end