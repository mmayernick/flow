source 'http://rubygems.org'

gem 'rails', '=3.1.3'

gem 'foreman', '~>0.26.1'
gem 'unicorn', '~>4.1.1'
gem 'rack-rewrite', '~>1.2.1'

gem 'haml', '~>3.1.3'
gem 'RedCloth', '~>4.2.2', :require => 'redcloth'
gem 'will_paginate', '~>3.0.2'
gem 'configatron', '~>2.8.4'
gem "twitter", "~> 1.7.2"
gem "acts_as_state_machine", "~>2.2.0"
gem "acts_as_tree_rails3", "~> 0.1.0"
gem "recaptcha", "~> 0.3.1", :require => "recaptcha/rails"
gem "uuid", "~> 2.3.4"
gem 'nokogiri', '~>1.5.0'

gem "paperclip", "~> 2.4.5"
gem 'aws-s3', '~>0.6.2', :require => 'aws/s3'

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end
  
gem 'jquery-rails'
 
gem 'bcrypt-ruby', '~> 3.0.0'


group :development do
  gem "metric_fu", "~>2.1.1"
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec', '~>2.6.0'
  gem 'rspec-rails', '~>2.6.0'
end

group :test do
  gem 'factory_girl', '=1.3.3'
  gem "shoulda-matchers", "~> 1.0.0"
  gem 'mocha', '=0.10.0'
  gem "no_peeping_toms", "~> 2.1.2"
  gem 'turn', '0.8.2', :require => false
end

group :production do
  gem 'pg', '~>0.11.0'
end