require 'spec_helper'

describe UsersController do
  render_views
  
  describe "admin actions are protected" do
    [[:get, :approve], [:get, :disapprove], [:delete, :destroy]].each do |verb, action|
      it "should not #{verb} #{action}" do
        user = Factory.create(:user)
        login_as user
        send(verb, action, :id => 1)
        response.should be_redirect
      end
    end  
    
    it "should not get index" do
      user = Factory.create(:user)
      login_as user
      get :index
      response.should be_redirect
    end
  end
  
  describe 'Creating a user' do
    before(:each) do
      UsersController.any_instance.should_receive(:passes_captcha?).and_return(true)
      @user_attributes = Factory.attributes_for(:user)
      post :create, :user => @user_attributes
      @user = User.find_by_login @user_attributes[:login]
    end
    
    it 'should delete authorization cookie' do
       cookies[:auth_token].should be_nil
    end
    
    it { should redirect_to root_path }
        
    it 'should actually create the user' do
      @user.should_not be_nil
    end
  end
  
  describe 'Failing to create a user' do
    before(:each) do
      UsersController.any_instance.should_receive(:passes_captcha?).and_return(true)
      @user_attributes = Factory.attributes_for(:user, :password => nil)
      post :create, :user => @user_attributes
      @user = User.find_by_login @user_attributes[:login]
    end
    
    it { should respond_with :success }
    it { should render_template :new }
    it 'should not actually create the user' do
      @user.should be_nil
    end
  end
end