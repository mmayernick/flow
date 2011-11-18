require 'spec_helper'

describe User do
  it { should have_many :items }
  it { should have_many :comments }
  it { should have_many :stars }
  it { should have_many :starred_items }

  it { should validate_presence_of :login }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }
  #should validate_presence_of :email

  it { should ensure_length_of(:password).is_at_least(4).is_at_most(40) }

  it { should ensure_length_of(:login).is_at_least(3).is_at_most(40) }
  it { should allow_value('mylogin').for(:login) }
  it { should allow_value('woooooo123').for(:login) }

  it { should_not allow_value('my login').for(:login) }

  it { should allow_value('http://example.com').for(:url) }
  it { should_not allow_value('example.com').for(:url) }
  
  describe 'A user' do
    before(:each) do
      @user = Factory(:user, :password => 'password', :password_confirmation => 'password')
    end
    
    subject { @user }
    
    it { should validate_uniqueness_of :login }
    
    it 'should be able to authenticate with correct password' do
      @user.should == User.authenticate(@user.login, 'password')
    end
    
    it 'should not be able to authenticate with incorrect password' do
      User.authenticate(@user.login, 'notpassword').should be_nil
    end
    
    describe 'updating their password' do
      before(:each) do
        @user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
      end
      
      it 'should be able to login with new password' do
        @user.should == User.authenticate(@user.login, 'new password')
      end
    end
    
    describe 'updating their login' do
      before(:each) do
        @user.update_attributes(:login => 'newlogin')
      end
      
      subject { @user }
      
      # should_eventually 'not rehash password' do
      #   @user.should == User.authenticate('newlogin', 'password')
      # end
    end
    
    describe 'being remembered for default amount of time' do
      before(:each) do
        @before_time = 52.week.from_now.utc
        @user.remember_me
        @after_time = 52.weeks.from_now.utc
      end
      
      it 'should set remember token' do
        @user.remember_token.should_not be_nil
      end
      
      it 'should set remember token expires at' do
        @user.remember_token_expires_at.should_not be_nil
      end
      
      it 'should remember for 52 weeks' do
        assert @user.remember_token_expires_at.between?(@before_time, @after_time)
      end
      
      describe 'and then being forgotten' do
        before(:each) do
          @user.forget_me
        end
        
        it 'should unset remember token' do
          @user.remember_token.should be_nil
        end
      end
    end
    
    describe 'being remember until 1 week from now' do
      before(:each) do
        @time = 1.week.from_now.utc

        @user.remember_me_until @time
      end
      
      it 'should set remember token' do
        @user.remember_token.should_not be_nil
      end
      
      it 'should set remember token expires at' do
        @user.remember_token_expires_at.should_not be_nil
      end
      
      it 'should expire in 1 week' do
        @time.should == @user.remember_token_expires_at
      end
    end
    
    describe 'being remembered for 1 week' do
      before(:each) do
        @before_time = 1.week.from_now.utc
        @user.remember_me_for 1.week  
        @after_time = 1.weeks.from_now.utc
      end
      
      it 'should set remember token' do
        @user.remember_token.should_not be_nil
      end
      
      it 'should set remember token expires at' do
        @user.remember_token_expires_at.should_not be_nil
      end
      
      it 'should remember for 1 weeks' do
        @user.remember_token_expires_at.between?(@before_time, @after_time).should be_true
      end
    end
  end
  
  describe 'A non existant user' do
    it 'should not be able to authenticate' do
      User.authenticate('nonexistentlogin', 'password').should be_nil
    end
  end
end