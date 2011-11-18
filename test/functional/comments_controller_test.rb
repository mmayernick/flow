require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  should_require_login do
    get edit, {:id => '1'}
  end
  should_require_login :get, :edit, 1
  should_require_login :put, :update, 1
  should_require_login :delete, :destroy, 1
  
  should_require_admin :get, :edit, 1
  should_require_admin :put, :update, 1
  should_require_admin :delete, :destroy, 1
  
  context 'As a registered user' do
    setup do
      @user = Factory(:user)
      login_as @user
    end
    
    context 'POST to create' do
      setup do
        @item = Factory(:item)
        post :create, :comment => Factory.attributes_for(:comment, :item_id => @item.id), :item_id => @item.id
        @comment = Comment.last
      end
      should redirect_to('item path') { item_path(@item) }
      should set_the_flash.to(/success/)
      should 'assign current user to comment' do
        assert_equal @user, @comment.user
      end
    end
    
  end
  
  context 'As an anonymous user' do
    context 'POST to create' do
      setup do
        @item = Factory(:item)
      end
      context 'with failing captcha' do
        setup do
          @controller.stubs(:passes_captcha?).returns(false)
          post :create, :comment => Factory.attributes_for(:comment), :item_id => @item.id
          @comment = Comment.last
        end
        should respond_with :success
        should set_the_flash.to /CAPTCHA/
        should assign_to :item
        should assign_to :comment
        should render_template 'items/show'
      end
      
      context 'with passing captcha' do
        setup do
          @controller.stubs(:passes_captcha?).returns(true)
          post :create, :comment => Factory.attributes_for(:comment), :item_id => @item.id
          @comment = Comment.last
        end
        should redirect_to('item path') { item_path(@item) }
        should set_the_flash.to /success/
        should 'assign current user to comment' do
          assert_equal @user, @comment.user
        end
      end
    end
  end
  
  context 'As an admin user' do
    setup do
      @user = Factory(:admin)
      login_as @user
    end
    
    context 'DELETE to destroy' do
      setup do
        @item = Factory(:item)
        @comment = Factory(:comment, :item => @item)
        delete :destroy, :id => @comment.id, :item_id => @item.id
      end
      should redirect_to('item path') { item_path(@item) }
      should 'remove comment' do
        assert_nil Comment.find_by_id(@comment.id)
      end
    end
    
    context 'PUT to update' do
      setup do
        @item = Factory(:item)
        @comment = Factory(:comment, :item => @item)
        put :update, :id => @comment.id, :item_id => @item.id, :comment => Factory.attributes_for(:comment, :content => 'this is totally new content')
      end
      should redirect_to('item path') { item_path(@item) }
      should 'update the comment' do
        @comment.reload
        assert_equal 'this is totally new content', @comment.content
      end
    end
  end
end
