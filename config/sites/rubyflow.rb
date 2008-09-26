configatron.site_title     = 'RubyFlow'
configatron.default_title  = 'RubyFlow : Community Filtered News'

configatron.sub_title = 'Community-maintained news'

configatron.meta.keywords = 'news, news site'
configatron.meta.author = 'RubyFlow'

configatron.language = 'en-us'

configatron.site_url = 'http://rubyflow.local/'
configatron.rss_url = 'http://rubyflow.local/items.rss'

configatron.google_analytics.enabled = false
configatron.google_analytics.account = 'UA-2237791-8'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = false

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END
!http://www.engineyard.com/images/ey_banner_150x200.png!:http://www.engineyard.com/?utm_source=RubyFlow&utm_medium=Banner&utm_campaign=Sponsorship

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