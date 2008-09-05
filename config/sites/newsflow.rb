config.site_title     = 'NewsFlow'
config.default_title  = 'NewsFlow : Community Filtered News'

config.sub_title = 'Community-maintained news'

config.namespace(:meta) do |meta|
  meta.keywords = 'news, news site'
  meta.author = 'NewsFlow'
end

config.language = 'en-us'

config.site_url = 'http://rubyflow.local/'
config.rss_url = 'http://rubyflow.local/items.rss'

config.namespace(:google_analytics) do |google_analytics|
  google_analytics.enabled = false
  google_analytics.account = 'UA-2237791-8'
end

# Set this to true for a more fancy interface, but for the cost of page load time
config.namespace(:javascript) do |javascript|
  javascript.enabled = false
end

config.edit_expiration_in_minutes = 60

config.sidebar_redcloth = <<END
h3. What?

This site is intended for news gathering, with links chosen and summarised by the community.

h3. How?

Enjoy the links, comment, or "make a post":/items/new of your own. You don't need to be signed in!

_Note: If you're not signed in, your byline is unlinked and your links are made "nofollow" to prevent spam. You also get CAPTCHAed!_

h3. Who?

RubyFlow was built by "Peter Cooper":http://peterc.org/ of "Ruby Inside":http://rubyinside.com, but is ultimately a community site.
END

config.sidebar = RedCloth.new(config.sidebar_redcloth).to_html