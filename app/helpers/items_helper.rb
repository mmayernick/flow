module ItemsHelper
    
  def should_display_date?(last_date, item)
    if last_date.nil?
      true
    elsif ! (last_date.day == item.created_at.day && last_date.month == item.created_at.month && last_date.year == item.created_at.year)
      true
    else
      false
    end
  end
  
  def can_edit?(item)
    time_left = edit_time_left(item)
    
    is_admin? || (item.user == current_user && (time_left.nil? || time_left > 0))
  end
  
  def user_link(item)
    if item.user
      options = item.user.is_approved_for_feed? ? {} : {:rel => 'nofollow'} 
      link_to(item.user.login, item.user.url, options) + " (#{item.user.items.count})"
    else
      item.byline
    end
  end
  
  # Shows the time left to edit the current item, or nil if it's always allowed
  def edit_time_left(item)
    diff = Time.now - item.updated_at
    expire_rate = site_config.edit_expiration_in_minutes
    return expire_rate > 0 ? expire_rate - (diff.to_i / 60) : nil
  end
  
end
