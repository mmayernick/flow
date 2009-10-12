configatron.site_title     = 'CappuccinoFlow'
configatron.default_title  = 'CappuccinoFlow : Cappuccino Community Links'

configatron.sub_title = 'cappuccino community link blog'

configatron.meta.keywords = 'cappuccino, objective-j, news, links, blog, community'
configatron.meta.author = 'CappuccinoFlow'

configatron.language = 'en-us'

configatron.site_url = 'http://cappuccinoflow.com/'
configatron.rss_url = 'http://feeds.feedburner.com/cappuccinoflow'

configatron.google_analytics.enabled = true
configatron.google_analytics.account = 'UA-3287978-14'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = false

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END
h3. What?

CappuccinoFlow is a community driven "Cappuccino":http://www.cappuccino.org link blog. Posts are by members of the community — like you!

h3. How?

Enjoy the links, comment, or "make a post":/items/new of your own. You don't need to be signed in!

_Note: Only posts by registered members with 1 previously good post make it into the RSS feed._

h3. Who?

CappuccinoFlow is a fork of RubyFlow (built by "Peter Cooper":http://peterc.org/). It is maintained by "Jerod Santo":http://jerodsanto.net , but is ultimately a community site. "Contributions are welcome":http://github.com/sant0sk1/cappuccinoflow/
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html