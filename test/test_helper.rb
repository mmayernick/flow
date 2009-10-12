ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  include AuthenticatedTestHelper
end

class ActionController::TestCase
  def self.should_require_login(method, action)
    context "#{method} to #{action} as anonymous" do
      setup do
        send(method, action)
      end
      should_redirect_to('login') { login_path }
    end
  end
  
  def self.should_require_admin(method, action)
    context "#{method} to #{action} as non-admin user" do
      setup do
        @user = Factory(:user)
        login_as @user
        
        send(method, action)
      end
      should_redirect_to('login') { login_path }
    end
  end
end