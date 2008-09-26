configatron.site_title     = 'NewsFlow'
configatron.default_title  = 'NewsFlow : Community Filtered News'

configatron.sub_title = 'Community-maintained news'

configatron.meta.keywords = 'news, news site'
configatron.meta.author = 'NewsFlow'

configatron.language = 'en-us'

configatron.site_url = 'http://rubyflow.local/'
configatron.rss_url = 'http://rubyflow.local/items.rss'

configatron.google_analytics.enabled = false
configatron.google_analytics.account = 'UA-2237791-8'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = false

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END
h3. What?

This site is intended for news gathering, with links chosen and summarised by the community.

h3. How?

Enjoy the links, comment, or "make a post":/items/new of your own. You don't need to be signed in!

_Note: If you're not signed in, your byline is unlinked and your links are made "nofollow" to prevent spam. You also get CAPTCHAed!_

h3. Who?

RubyFlow was built by "Peter Cooper":http://peterc.org/ of "Ruby Inside":http://rubyinside.com, but is ultimately a community site.
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html