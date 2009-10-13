require 'test_helper'

class ItemObserverTest < ActiveSupport::TestCase
  should_be_an_observer
  should_observe Item

  context "An Item Observer" do
    setup do
      @observer = ItemObserver.instance
    end
    
    context "on an approved user's item" do
      setup do
        @user = Factory(:user, :approved_for_feed => true)
        @item = Factory.build(:item, :user_id => @user.id)
      end

      should "send a tweet" do
        @observer.expects(:call_rake).with(:tweet, :item_id => @item.id).returns(true)
        @observer.after_create(@item)
      end
    end
    
    context "on an unapproved user's item" do
      setup do
        @user = Factory(:user, :approved_for_feed => false)
        @item = Factory.build(:item, :user_id => @user.id)
      end
      
      should "not send a tweet" do
        @observer.expects(:call_rake).with(:tweet, :item_id => @item.id).never
        @observer.after_create(@item)
      end
    end
  
    context "on an anonymous item" do
      setup do
        @item = Factory.build(:item)
      end
      
      should "not send a tweet" do
        @observer.expects(:call_rake).with(:tweet, :item_id => @item.id).never
        @observer.after_create(@item)
      end
    end
  end

end