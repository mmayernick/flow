require 'spec_helper'

describe SessionsController do
  render_views
  
  describe 'logging in with proper credentials' do
    before(:each) do
      @user = Factory.create(:user)
      post :create, :login => @user.login, :password => @user.password
    end

    it { should redirect_to(root_path) }
    
    it 'should set user id on session' do
      @user.id.should == session[:user_id]
    end
  end
  
  describe 'logging in with proper credentials, and wanting to be remembered' do
    before(:each) do
      @user = Factory.create(:user)
      post :create, {:login => @user.login, :password => @user.password, :remember_me => 1}
    end
    
    it { should redirect_to(root_path) }
        
    it 'should set the authentication cookie' do
      @response.cookies['auth_token'].should_not be_nil
    end
  end
  
  describe 'logging in with proper credentials, and wanting to not be remembered' do
    before(:each) do
      @user = Factory.create(:user)
      post :create, {:login => @user.login, :password => @user.password, :remember_me => 0}
    end
    
    it { should redirect_to(root_path) }
    
    it 'should not set the authentication cookie' do
      @response.cookies['auth_token'].should be_nil
    end
  end
  
  describe 'logging in with bad credentials' do
    before(:each) do
      post :create, {:login => 'somelogin', :password => 'some bad password'}
    end
    
    it { should respond_with :success }
    it 'should not set user id on session' do
      session[:user_id].should be_nil
    end
  end
  
  describe 'logging out' do
    before(:each) do
      @user = Factory(:user)
      login_as @user
      get :destroy
    end
    
    it { should redirect_to(root_path) }
    
    it 'should unset user id on session' do
      session[:user_id].should be_nil
    end
  end
  
  describe 'logging out when remembered' do
    before(:each) do
      @user = Factory(:user)
      @request.cookies["auth_token"] = CGI::Cookie.new('name' => 'auth_token', 'value' => @user.remember_token)
      login_as @user
      get :destroy
    end
    
    it 'should unset cookie' do
      @response.cookies['auth_token'].should be_nil
    end
  end
end