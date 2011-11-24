configatron.site_title     = 'iOS Dev Links'
configatron.default_title  = 'iOS Dev Links'

configatron.sub_title = 'Interesting links for iOS Developers'

configatron.meta.keywords = 'news, news site, ios, iPhone, iPad, development'
configatron.meta.author = 'iOS Dev Links'

configatron.language = 'en-us'

configatron.site_url = 'http://www.iosdevlinks.com'
configatron.rss_url = 'http://feeds.feedburner.com/iosdevlinks'
configatron.twitter_url = 'https://twitter.com/iosdevlinks'

configatron.google_analytics.enabled = true
configatron.google_analytics.account = 'UA-27252129-1'

# Set this to true for a more fancy interface, but for the cost of page load time
configatron.javascript.enabled = true

configatron.edit_expiration_in_minutes = 60

configatron.sidebar_redcloth = <<END

<p><a href="http://feeds.feedburner.com/iosdevlinks"><img src="http://feeds.feedburner.com/~fc/iosdevlinks?bg=99CCFF&amp;fg=444444&amp;anim=0" height="26" width="88" style="border:0" alt="" /></a></p>

<p><a href="https://twitter.com/iosdevlinks" class="twitter-follow-button">Follow @iosdevlinks</a>
<script src="//platform.twitter.com/widgets.js" type="text/javascript"></script></p>

h3. Bookmarklet

Drag this to your bookmarks bar to post links to this site from whatever page you're on.

<a href="javascript:window.location=%22http://www.iosdevlinks.com/items/new?u=%22+encodeURIComponent(document.location)+%22&t=%22+encodeURIComponent(document.title)">Post to iOS Dev Links</a>

h3. What?

iOS Dev Links is a community driven iOS links site based on a "modernized version of the RubyFlow codebase":https://github.com/aaronbrethorst/flow.

h3. How?

Enjoy the links, comment or "make a post of your own":http://iosdevlinks.com/items/new. You don't need to be signed in! Only posts made by users with a good track record make it into the feed though, so no spam.
END

configatron.sidebar = RedCloth.new(configatron.sidebar_redcloth).to_html