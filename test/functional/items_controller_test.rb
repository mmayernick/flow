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
    
    context 'GET to edit' do
      setup do
        @item = Factory(:item)
        get :edit, :id => @item.id
      end
      
      should_redirect_to 'login_url'
    end
    
    context 'POST to create without captcha' do
      setup do
        post :create, :item => Factory.attributes_for(:item)
        @item = Item.last
      end
      
      should_render_template :new
    end
    
    # FIXME need to do something to be able to pass the captcha
    # context 'POST to create with captcha' do
    #   setup do
    #     @captcha_guide = 'WOOOOT'
    #     @captcha = Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5]
    #     post :create, :item => Factory.attributes_for(:item), :captcha => 'WOOOOT', :captcha_guide => 'WOOOOT'
    #     @item = Item.last
    #   end
    #   
    #   should_redirect_to 'item_path(@item)'
    # end
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
        post :create, :item => Factory.attributes_for(:item)
        @item = Item.last
      end
      
      should_redirect_to 'item_path(@item)'
      
      should 'create item posted by user' do
        assert_equal @user, @item.user
      end
    end
  end
  
  context 'As an admin user' do
    # context 'DELETE to destroy' do
    #   setup do
    #     @item = Factory(:item)
    #     delete :destroy, :id => @item.id
    #   end
    #   should_redirect_to 'items_path'
    # end
  end
end
