require 'spec_helper'

describe ItemObserver do
  before(:each) do
    @observer = ItemObserver.instance
  end
  # todo: fixme.
  # it {should_be_an_observer}
  # it {should_observe Item}

  describe "on an approved user's item" do
    before(:each) do
      @user = Factory(:user, :approved_for_feed => true)
      @item = Factory.build(:item, :user_id => @user.id)
    end

    it "should send a tweet" do
      @observer.expects(:call_rake).with("tweet:item", :item_id => @item.id).returns(true)
      @observer.after_create(@item)
    end
  end
  
  describe "on an unapproved user's item" do
    before(:each) do
      @user = Factory(:user, :approved_for_feed => false)
      @item = Factory.build(:item, :user_id => @user.id)
    end
    
    it "should not send a tweet" do
      @observer.expects(:call_rake).with("tweet:item", :item_id => @item.id).never
      @observer.after_create(@item)
    end
  end

  describe "on an anonymous item" do
    before(:each) do
      @item = Factory.build(:item)
    end
    
    it "should not send a tweet" do
      @observer.expects(:call_rake).with("tweet:item", :item_id => @item.id).never
      @observer.after_create(@item)
    end
  end
end