require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  should_require_login :put, :update
  should_require_login :get, :edit
  should_require_login :delete, :destroy
  should_require_login :get, :star
  should_require_login :get, :unstar

  context 'As an anonymous user' do

    context 'GET to index' do
      # TODO test other formats (js and rss)
      setup do
        get :index
      end
      should respond_with :success
      should assign_to :items
      should assign_to :items_count
      should assign_to :front_page
    end

    context 'GET to show' do

      # FIXME make DRYer between with/without name tests
      context 'of item with name' do
        setup do
          @item = Factory(:item)
          get :show, :id => @item.to_param
        end

        should respond_with :success
        should assign_to :item
        should assign_to :title
        should assign_to :comment

        should "set title from item's title" do
          assert_equal @item.title, assigns(:title)
        end
      end

      context 'of item without name' do
        setup do
          @item = Factory(:item, :name => nil)
          get :show, :id => @item.to_param
        end

        should respond_with :success
        should assign_to :item
        should assign_to :title
        should assign_to :comment

        should "set title from item's title" do
          assert_equal @item.title, assigns(:title)
        end
      end

      context 'with non-existent item' do
        setup do
          get :show, :id => 'nonexistent'
        end
        should respond_with 404
      end
    end

    context 'GET to new' do
      setup do
        get :new
      end

      should respond_with :success
      should render_template :new
      should assign_to :item
    end

    context 'GET to edit' do
      setup do
        @item = Factory(:item)
        get :edit, :id => @item.id
      end
      should "redirect to login" do
        assert_redirect_to login_path
      end
    end

    context 'POST to create with failing captcha' do
      setup do
        @controller.stubs(:passes_captcha?).returns(false)
        post :create, :item => Factory.attributes_for(:item)
        @item = Item.last
      end

      should render_template :new
    end

    context 'POST to create with passing captcha' do
      setup do
        @controller.stubs(:passes_captcha?).returns(true)
        post :create, :item => Factory.attributes_for(:item, :byline => nil)
        @item = Item.last
      end
      should "redirect to item" do
        assert_redirect_to item_path(@item)
      end

      should 'set item byline to Anonymous Coward' do
        assert_equal 'Anonymous Coward', @item.byline
      end
    end
  end

  context 'As a registered user' do
    setup do
      @user = Factory(:user)
      login_as @user
    end

    context 'GET to edit of one of the users item' do
      # FIXME make DRYer between with/without name tests
      context 'with a name' do
        setup do
          @item = Factory(:item, :user => @user)
          get :edit, :id => @item.to_param
        end

        should respond_with :success
        should assign_to :item
      end

      context 'without a name' do
        setup do
          @item = Factory(:item, :name => nil, :user => @user)
          get :edit, :id => @item.to_param
        end

        should respond_with :success
        should assign_to :item
      end
    end

    context 'POST to create' do
      setup do
        post :create, :item => Factory.attributes_for(:item, :content => '<a href="http://icanhascheezburger.com">invisble link!</a>')
        @item = Item.last
      end

      should "redirect to item" do
        assert_redirect_to item_path(@item)
      end

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

    context 'GET to star' do
      setup do
        @item = Factory(:item)
        @request.env['HTTP_REFERER'] = item_url(@item)

        get :star, :id => @item.to_param

        @item.reload
      end

      should "add item to user's list of starred items" do
        assert @item.is_starred_by_user(@user)
      end

      should "redirect to item" do
        assert_redirect_to item_path(@item)
      end
    end

    context 'GET to unstar' do
      setup do
        @item = Factory(:item)
        @star = Star.create(:item => @item, :user => @user)

        @request.env['HTTP_REFERER'] = item_url(@item)

        get :unstar, :id => @item.to_param

        @item.reload
      end

      should "add item to user's list of starred items" do
        assert ! @item.is_starred_by_user(@user)
      end

      should "redirect to item" do
        assert_redirect_to item_path(@item)
      end
    end
  end

  context 'As an admin user' do
    context 'DELETE to destroy' do
      setup do
        @user = Factory(:admin)
        login_as @user

        @item = Factory(:item)
        delete :destroy, :id => @item.id
      end

      should "redirect to item" do
        assert_redirect_to item_path(@item)
      end

      should 'remove item' do
        assert_nil Item.find_by_id(@item.id)
      end
    end
  end
end
