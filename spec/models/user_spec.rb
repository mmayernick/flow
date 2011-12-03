require 'spec_helper'

describe User do
  it { should have_many :items }
  it { should have_many :comments }

  it { should validate_presence_of :login }
  it { should validate_presence_of :password }
  it { should validate_presence_of :email }

  it { should ensure_length_of(:login).is_at_least(3).is_at_most(40) }
  it { should allow_value('mylogin').for(:login) }
  it { should allow_value('woooooo123').for(:login) }

  it { should_not allow_value('my login').for(:login) }

  it { should allow_value('http://example.com').for(:url) }
  it { should_not allow_value('example.com').for(:url) }
  
  describe "api keys" do
    before(:each) do
      @user = Factory.create(:user)
    end
    
    it "should have one on creation" do
      @user.api_key.should_not be_blank
    end
    
    it "should allow the api key to be recreated" do
      old_key = @user.api_key
      @user.reset_api_key
      @user.reload
      @user.api_key.should_not be_blank
      @user.api_key.should_not == old_key
    end
  end
  
  describe "logins" do
    before(:each) do
      @user = Factory.create(:user, :login => 'aaron')
    end
    
    it "shouldn't be case sensitive" do
      failed_user = Factory.build(:user, :login => @user.login)
      failed_user.save.should be_false
    end
  end
  
  describe 'A user' do
    before(:each) do
      @user = Factory(:user, :password => 'password')
    end
    
    subject { @user }
    
    it { should validate_uniqueness_of :login }
    
    it 'should be able to authenticate with correct password' do
      @user.should == User.find_by_login(@user.login).authenticate('password')
    end
    
    it 'should not be able to authenticate with incorrect password' do
      User.find_by_login(@user.login).authenticate('notpassword').should be_false
    end
    
    describe 'updating their password' do
      before(:each) do
        @user.password = 'new password'
        @user.save!
      end
      
      it 'should be able to login with new password' do
        @user.should == User.find_by_login(@user.login).authenticate('new password')
      end
    end
  end
end
