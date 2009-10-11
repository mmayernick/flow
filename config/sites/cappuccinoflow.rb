configatron.site_title     = 'CappuccinoFlow'
configatron.default_title  = 'CappuccinoFlow : Cappuccino Community Links'

configatron.sub_title = 'Cappuccino Community Link Blog'

configatron.meta.keywords = 'cappuccino, objective-j, news, links'
configatron.meta.author = 'CappuccinoFlow'

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

CappuccinoFlow is a community driven Cappuccino links site. Posts are by members of the community — like you! Enjoy the links and leave comments.

h3. How?

Enjoy the links, comment, or "make a post":/items/new of your own. You don't need to be signed in!

_Note: If you're not signed in, your byline is unlinked and your links are made "nofollow" to prevent spam. You also get CAPTCHAed!_

h3. Who?

CappuccinoFlow is a fork of RubyFlow (built by "Peter Cooper":http://peterc.org/). It is maintained by "Jerod Santo":http://jerodsanto.net , but is ultimately a community site.
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html