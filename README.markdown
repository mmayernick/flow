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


_Originally Developed by Peter Cooper - 2008_

All code developed by Peter Cooper within this project is in the public domain.
Plugins, Rails, and derivative code is licensed as it was originally (mostly MIT).