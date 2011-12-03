configatron.site_title     = 'CappuccinoFlow'
configatron.default_title  = 'CappuccinoFlow : Cappuccino Community Links'

configatron.sub_title = 'cappuccino community link blog'

configatron.meta.keywords = 'cappuccino, objective-j, news, links, blog, community'
configatron.meta.author = 'CappuccinoFlow'

configatron.language = 'en-us'

configatron.site_url = 'cappuccinoflow.com/'
configatron.rss_url = 'http://feeds.feedburner.com/cappuccinoflow'

configatron.google_analytics.enabled = true
configatron.google_analytics.account = 'UA-3287978-14'

# Set this to true for live post previews and other fanciness
configatron.javascript.enabled = true

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END

h3. What

CappuccinoFlow is a community driven "Cappuccino":http://www.cappuccino.org link blog. Posts are by members of the community — like you!

h3. How

Enjoy the links, comment, or "make a post":/items/new of your own. Feel free to promote your own high quality Cappuccino-related content. You don't even need to be signed in!

Note: Only posts by registered members with 1 previously good post make it into the "RSS":http://feeds.feedburner.com/cappuccinoflow and "Twitter":http://twitter.com/cappuccinoflow feeds.

h3. Who

CappuccinoFlow is maintained by "Jerod Santo":http://jerodsanto.net/, but is ultimately a community site. "Contributions are welcome":http://github.com/sant0sk1/cappuccinoflow

h3. Community Links

* "Developers List":http://twitter.com/cappuccinoflow/developers
* "Core Team List":http://twitter.com/cappuccinoflow/core-team
* "Google Group":http://groups.google.com/group/objectivej
* "Source Code":http://github.com/280north/cappuccino

h3. Other Flows

* "RubyFlow":http://www.rubyflow.com/ (the OG)
* "iPhoneFlow":http://www.iphoneflow.com/
* "JSRoll":http://www.jsroll.com/
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html