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
  should_require_login :delete, :destroy
  
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
    
    context 'GET to edit' do
      setup do
        @item = Factory(:item)
        get :edit, :id => @item.id
      end
      
      should_redirect_to 'login_url'
    end
    
    context 'POST to create with failing captcha' do
      setup do
        @controller.stubs(:passes_captcha?).returns(false)
        post :create, :item => Factory.attributes_for(:item)
        @item = Item.last
      end
      
      should_render_template :new
    end
    
    context 'POST to create with passing captcha' do
      setup do
        @controller.stubs(:passes_captcha?).returns(true)
        post :create, :item => Factory.attributes_for(:item, :byline => nil)
        @item = Item.last
      end
      
      should_redirect_to 'item_path(@item)'
      should 'set item byline to Anonymous Coward' do
        assert_equal 'Anonymous Coward', @item.byline
      end
    end
  end
  
  context 'As a registered user' do
    setup do
      @user = Factory(:user)
      @request.session[:user_id] = @user.to_param
    end
    
    context 'GET to edit of one of the users item' do
      # FIXME make DRYer between with/without name tests
      context 'with a name' do
        setup do
          @item = Factory(:item, :user => @user)
          get :edit, :id => @item.to_param
        end
      
        should_respond_with :success
        should_assign_to :item
      end
      
      context 'without a name' do
        setup do
          @item = Factory(:item, :name => nil, :user => @user)
          get :edit, :id => @item.to_param
        end
      
        should_respond_with :success
        should_assign_to :item
      end
    end
    
    context 'POST to create' do
      setup do
        post :create, :item => Factory.attributes_for(:item, :content => '<a href="http://icanhascheezburger.com">invisble link!</a>')
        @item = Item.last
      end
      
      should_redirect_to 'item_path(@item)'
      
      should 'create item posted by user' do
        assert_equal @user, @item.user
      end
      
      # FIXME for some reason, content ends up being <a href=\"http://icanhascheezburger.com\">invisble link!</a>
      # works from development from script/server, but fails during testing
      should_eventually 'add nofollow to links in content, because we hate anons' do
        breakpoint
        assert_match /nofollow/, @item.content
      end
    end
  end
  
  context 'As an admin user' do
    context 'DELETE to destroy' do
      setup do
        @user = Factory(:admin)
        @request.session[:user_id] = @user.to_param
        
        @item = Factory(:item)
        delete :destroy, :id => @item.id
      end
      should_redirect_to 'items_path'
      
      should 'remove item' do
        assert_nil Item.find_by_id(@item.id)
      end
    end
  end
end
