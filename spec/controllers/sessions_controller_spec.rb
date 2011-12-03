require 'spec_helper'

describe SessionsController do
  render_views
  
  describe 'logging in with proper credentials' do
    before(:each) do
      @user = Factory.create(:user, :password => 'mypasswordisprettyawesome')
      post :create, :login => @user.login, :password => 'mypasswordisprettyawesome'
    end

    it { should redirect_to(root_path) }
    
    it 'should set user id on session' do
      @user.id.should == session[:user_id]
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
end