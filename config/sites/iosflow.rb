configatron.site_title     = 'iOSFlow'
configatron.default_title  = 'iOSFlow : Community Filtered News'

configatron.sub_title = 'Community-maintained news'

configatron.meta.keywords = 'news, news site, ios, iPhone, iPad, development'
configatron.meta.author = 'iOSFlow'

configatron.language = 'en-us'

configatron.site_url = 'http://0.0.0.0:3000/'
configatron.rss_url = 'http://0.0.0.0:3000/items.rss'

configatron.google_analytics.enabled = false
configatron.google_analytics.account = 'UA-2237791-8'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = true

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END

"Follow RubyFlow on **Twitter**":http://twitter.com/rubyflow

h3. What?

RubyFlow is a community driven Ruby links site. Items are not added automatically, but chosen and summarized by the community, resulting in a higher quality of links than "social bookmarking sites":http://ruby.reddit.com/.

h3. International Versions

**Russian:** "rubyflow.ru":http://rubyflow.ru/

**Japanese:** There is "a Japanese version of RubyFlow":http://www.kuwata-lab.com/rubyflow-ja/ available, thanks to Makoto Kuwata!

**Chinese:** "Chinese Rubyflow site":http://flow.rubynow.com/.

**Dutch:** "Dutch (nederlandse) Rubyflow site":http://www.rubyweb.nl/.

h3. How?

Enjoy the links, comment or "make a post of your own":http://www.rubyflow.com/items/new. You don't need to be signed in! Only posts made by users with a good track record make it into the feed though, so no spam.
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html