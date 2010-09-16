RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

load File.join(File.dirname(__FILE__), 'initializers', 'configure_site_name.rb')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]


  config.action_controller.session = {
    :session_key => "_#{$SITE_NAME}_session",
    :secret      => 'hcumyrevuoyknahteslegnihtemosotsihtegnahcotdeenuoy'
  }

  config.active_record.default_timezone = :utc

  config.gem 'RedCloth',      :version => '4.2.2',  :lib => 'redcloth'
  config.gem 'will_paginate', :version => '2.2.0'
  config.gem 'configatron',   :version => '2.5.1'
  config.gem 'bitly',         :version => '0.3.1'
  config.gem 'twitter',       :version => '0.9.8'

  config.active_record.observers = :item_observer
end