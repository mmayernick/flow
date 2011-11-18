require 'spec_helper'

describe "Stories Integration" do
  
  it "should return 404s for missing items" do
    get item_url(:id => 'blah-blah')
    response.code.should == "404"
  end
  
  it "should allow anon access to items" do
    item = Factory.create(:item)
    get item_url(item.id)
    response.should be_success
  end
  
  it "xtest_failed_edit_then_login_and_edit" do
    @user = Factory(:user)
    @item = Factory(:item, :user => @user)
    
    get edit_item_url(@item.id)
    response.should be_redirect
    
    post session_url, :login => @user.login, :password => @user.password
    response.should be_redirect
    
    get edit_item_url(@item.id)
    response.should be_success
  end
end