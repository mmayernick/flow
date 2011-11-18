xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title       site_config.site_title
    xml.link        site_config.site_url
    xml.description site_config.sub_title
    xml.language    site_config.language

    for item in @items.first(10)
      next unless item.user_id
      next unless item.user.approved_for_feed == 1
      xml.item do
        xml.title(item.title)
        xml.description(textilize(item.content))
        xml.pubDate(item.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(site_config.site_url + "items/" + item.id.to_s)
        xml.guid(site_config.site_url + "items/" + item.id.to_s)
      end
    end
  }
}
