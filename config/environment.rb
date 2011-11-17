RAILS_GEM_VERSION = '2.3.14' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

load File.join(File.dirname(__FILE__), 'initializers', 'configure_site_name.rb')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]


  config.action_controller.session = {
    :session_key => "_#{$SITE_NAME}_session",
    :secret      => 'hcumyrevuoyknahteslegnihtemosotsihtegnahcotdeenuoy'
  }

  config.active_record.default_timezone = :utc

  config.active_record.observers = :item_observer
end