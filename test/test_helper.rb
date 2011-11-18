ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.join(Rails.root, "lib", "authenticated_test_helper.rb")

require 'factory_girl'
Factory.find_definitions
#Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/shoulda_macros/**/*.rb")].each {|f| require f}

class ActiveSupport::TestCase
  include AuthenticatedTestHelper
end

class ActionController::TestCase
  def self.should_require_login(method, action, id = nil)
    context "#{method} to #{action} as anonymous" do
      setup do
        id ? send(method, action, {:id => id}) : send(method, action)
      end
      # TODO: this is nasty, fix it.
      should redirect_to('/login')
    end
  end
  
  def self.should_require_admin(method, action, id = nil)
    context "#{method} to #{action} as non-admin user" do
      setup do
        @user = Factory(:user)
        login_as @user
        
        id ? send(method, action, {:id => id}) : send(method, action)
      end
      # TODO: this is nasty, fix it.
      should redirect_to('/login')
    end
  end
end