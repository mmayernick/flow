configatron.site_title     = 'iOS Dev Links'
configatron.default_title  = 'iOS Dev Links'

configatron.sub_title = 'Community-maintained news'

configatron.meta.keywords = 'news, news site, ios, iPhone, iPad, development'
configatron.meta.author = 'iOS Dev Links'

configatron.language = 'en-us'

configatron.site_url = 'http://0.0.0.0:3000/'
configatron.rss_url = 'http://feeds.feedburner.com/cappuccinoflow'
configatron.twitter_url = '#'

configatron.google_analytics.enabled = true
configatron.google_analytics.account = 'UA-2237791-8'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = true

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END

"Follow iOS Dev Links on **Twitter**":http://twitter.com/iosdevlinks

h3. What?

iOS Dev Links is a community driven iOS links site.

h3. How?

Enjoy the links, comment or "make a post of your own":http://iosdevlinks.com/items/new. You don't need to be signed in! Only posts made by users with a good track record make it into the feed though, so no spam.
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html