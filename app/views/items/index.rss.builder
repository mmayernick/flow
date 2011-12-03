xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title       site_config.site_title
    xml.link        root_url
    xml.description site_config.sub_title
    xml.language    site_config.language

    for item in @items.first(10)
      next unless item.user_id
      next unless item.user.is_approved_for_feed?
      xml.item do
        xml.title(item.title)
        img = item.image.file? ? image_tag(item.image.url(:thumb)) + raw("<br>") : ""
        xml.description(textilize(item.content) + img)
        xml.pubDate(item.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(item_url(item))
        xml.guid(item_url(item))
      end
    end
  end
end
