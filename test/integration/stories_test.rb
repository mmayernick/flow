require File.dirname(__FILE__) + '/../test_helper'

class StoriesTest < ActionController::IntegrationTest
  def test_404
    get item_url(:id => 'non-existent')
    assert_response :missing
  end
  
  def test_no_login_and_no_edit
    @item = Factory(:item)
    
    get item_url(@item.id)
    
    assert_response :success
  end
  
    
  def xtest_failed_edit_then_login_and_edit
    @user = Factory(:user)
    @item = Factory(:item, :user => @user)
    
    get edit_item_url(@item.id)
    assert_response :redirect
    
    post login_url(:login => @user.login, :password => @user.password)
    assert_response :redirect
    
    get edit_item_url(@item.id)
    assert_response :success
  end

  # def test_non_admin_login_to_test_edit
  #   post "/session", :login => 'quentin', :password => 'test'
  #   assert_response :redirect
  #   get "/items/edit/MyString1"
  #   assert_response :success    
  # end
end