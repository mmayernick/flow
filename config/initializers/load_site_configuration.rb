# config/initializers/configure_site_name.rb MUST have been run by now
require 'configatron'

configatron.site_name = $SITE_NAME

site_config_path = File.join(File.dirname(__FILE__), '..', 'sites', "#{$SITE_NAME}.rb")

unless File.exists? site_config_path
  raise "Need a file #{site_config_path} for configuration. See newsflow.rb for example"
end

eval(IO.read(site_config_path), binding, site_config_path)