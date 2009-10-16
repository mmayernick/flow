class ItemObserver < ActiveRecord::Observer
  observe Item
  
  def after_create(item)
    if item.user && item.user.approved_for_feed == 1
      call_rake("tweet:item", :item_id => item.id)
    end
  end
  
  def call_rake(task, options = {})
    exit unless Rails.env == "production"
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "rake #{task} RAILS_ENV=production #{args.join(' ')} &"
  end
end