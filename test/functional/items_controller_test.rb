require File.dirname(__FILE__) + '/../test_helper'

class ItemsControllerTest < ActionController::TestCase
  def self.should_require_login(method, action)
    context "#{method} to #{action}" do
      setup do
        send(method, action)
      end
      should_redirect_to 'login_url'
    end
  end

  should_require_login :put, :update
  should_require_login :get, :edit
  
  context 'As an anonymous user' do
  
    context 'GET to index' do
      # TODO test other formats (js and rss)
      setup do
        get :index
      end
      should_respond_with :success
      should_assign_to :items
      should_assign_to :items_count
      should_assign_to :front_page
    end

    context 'GET to show' do
    
      # FIXME make DRYer between with/without name tests
      context 'of item with name' do
        setup do
          @item = Factory(:item)
          get :show, :id => @item.to_param
        end
    
        should_respond_with :success
        should_assign_to :item
        should_assign_to :title
        should_assign_to :comment
    
        should "set title from item's title" do
          assert_equal @item.title, assigns(:title)
        end
      end
    
      context 'of item without name' do
        setup do
          @item = Factory(:item, :name => nil)
          get :show, :id => @item.to_param
        end
    
        should_respond_with :success
        should_assign_to :item
        should_assign_to :title
        should_assign_to :comment
    
        should "set title from item's title" do
          assert_equal @item.title, assigns(:title)
        end
      end
    
      context 'with non-existent item' do
        setup do
          get :show, :id => 'nonexistent'
        end
        should_respond_with 404
      end
    end
  
    context 'GET to new' do
      setup do
        get :new
      end
  
      should_respond_with :success
      should_render_template :new
      should_assign_to :item
    end
    
    # context 'POST to create'
  end
  
  # context 'As a registered user' do
    # TODO find a way to test being logged in
    # context 'GET to edit' do
    #   # FIXME make DRYer between with/without name tests
    #   context 'of item with name' do
    #     setup do
    #       @item = Factory(:item)
    #       get :edit, :id => @item.to_param
    #     end
    #   
    #     should_respond_with :success
    #     should_assign_to :item
    #   end
    #   
    #   context 'of item without name' do
    #     setup do
    #       @item = Factory(:item, :name => nil)
    #       get :edit, :id => @item.to_param
    #     end
    #   
    #     should_respond_with :success
    #     should_assign_to :item
    #   end
    # end
  #   
  #   context 'POST to create' do
  #   end
  # end
  

  
  # context 'POST to create' do
  #   setup do
  #     item :create, :item => Factory.attributes_for(:item)
  #     @item = Item.find(:all).last
  #   end
  #   
  #   should_redirect_to 'item_path(@item)'
  # end
  # 
  # context 'GET to show' do
  #   setup do
  #     @item = Factory(:item)
  #     get :show, :id => @item.id
  #   end
  #   should_respond_with :success
  #   should_render_template :show
  #   should_assign_to :item
  # end
  # 
  # context 'GET to edit' do
  #   setup do
  #     @item = Factory(:item)
  #     get :edit, :id => @item.id
  #   end
  #   should_respond_with :success
  #   should_render_template :edit
  #   should_assign_to :item
  # end
  # 
  # 
  # context 'DELETE to destroy' do
  #   setup do
  #     @item = Factory(:item)
  #     delete :destroy, :id => @item.id
  #   end
  #   should_redirect_to 'items_path'
  # end
end
