iOS Dev Links
==============

This fork of [RubyFlow](http://rubyflow.com) and [CappuccinoFlow](http://cappuccinoflow.com) has been extensively upgraded.

Getting Started
-----

1. Install Ruby 1.9.2 and RVM. (you've likely already done this)
2. Install the app's gems (`gem install bundler && bundle install`)
3. Set up the database: `rake db:schema:load`
4. Set up your `.env` file: copy the file `env.example` to `.env` and fill in your own Amazon, Recaptcha and Twitter keys.
5. Launch the app: `foreman start`

Deploying to Heroku
-----

1. Install the Heroku gem
2. Set up a new Cedar stack application
3. Add config variables for:
  * `RECAPTCHA_PUBLIC_KEY`
  * `RECAPTCHA_PRIVATE_KEY`
  * `AMAZON_ACCESS_KEY_ID`
  * `AMAZON_SECRET_ACCESS_KEY`
  * `TWITTER_CONSUMER_KEY`
  * `TWITTER_CONSUMER_SECRET`
  * `TWITTER_ACCESS_TOKEN`
  * `TWITTER_ACCESS_SECRET`
4. `git push heroku master`
5. `heroku run rake db:migrate`
6. `heroku open`


Notes
==============

The app has been upgraded and tested to work with Ruby 1.9.2.

The app has been upgraded from Rails 2.3 to Rails 3.1.

The app is ready to be deployed on Heroku's Celadon Cedar platform. It is configured to use Unicorn and Foreman, and has _pg_ specified in its production gems group.

Twitter's Bootstrap has been integrated. Many of the views have been migrated to Haml. 

I have ripped out any reference to OpenID. 

Items now support images.

License
======

Copyright (c) 2011 Aaron Brethorst

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

_Originally Developed by Peter Cooper - 2008_

All code developed by Peter Cooper within this project is in the public domain.
Plugins, Rails, and derivative code is licensed as it was originally (mostly MIT).