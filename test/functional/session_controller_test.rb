require File.dirname(__FILE__) + '/../test_helper'

class SessionControllerTest < ActionController::TestCase
  
  context 'logging in with proper credentials' do
    setup do
      @user = Factory(:user)
      post :create, :login => @user.login, :password => @user.password
    end
    should_redirect_to 'root_url'
    should 'set user id on session' do
      assert_equal @user.id, session[:user_id]
    end
  end
  
  context 'logging in with proper credentials, and wanting to be remembered' do
    setup do
      @user = Factory(:user)
      post :create, :login => @user.login, :password => @user.password, :remember_me => 1
    end
    should_redirect_to 'root_url'
    should 'set the authentication cookie' do
      assert_not_nil @response.cookies['auth_token']
    end
  end
  
  context 'logging in with proper credentials, and wanting to not be remembered' do
    setup do
      @user = Factory(:user)
      post :create, :login => @user.login, :password => @user.password, :remember_me => 0
    end
    should_redirect_to 'root_url'
    should 'not set the authentication cookie' do
      assert_nil @response.cookies['auth_token']
    end
  end
  
  context 'logging in with bad credentials' do
    setup do
      post :create, :login => 'somelogin', :password => 'some bad password'
    end
    should_respond_with :success
    should 'not set user id on session' do
      assert_nil session[:user_id]
    end
  end
  
  context 'logging out' do
    setup do
      @user = Factory(:user)
      login_as @user
      get :destroy
    end
    should_redirect_to 'root_url'
    should 'unset user id on session' do
      assert_nil session[:user_id]
    end
  end
  
  context 'logging out when remembered' do
    setup do
      @user = Factory(:user)
      @request.cookies["auth_token"] = cookie_for(@user)
      login_as @user
      get :destroy
    end
    
    should 'unset cookie' do
      assert_nil @response.cookies['auth_token']
    end
  end

  protected
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end
    
    def cookie_for(user)
      auth_token user.remember_token
    end
end
