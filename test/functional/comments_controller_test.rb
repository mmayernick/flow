require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  should_require_login :get, :edit
  should_require_login :put, :update
  should_require_login :delete, :destroy
  
  should_require_admin :get, :edit
  should_require_admin :put, :update
  should_require_admin :delete, :destroy
  
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
      should_redirect_to('item path') { item_path(@item) }
      should_set_the_flash_to /success/
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
        should_respond_with :success
        should_set_the_flash_to /CAPTCHA/
        should_assign_to :item
        should_assign_to :comment
        should_render_template 'items/show'
      end
      
      context 'with passing captcha' do
        setup do
          @controller.stubs(:passes_captcha?).returns(true)
          post :create, :comment => Factory.attributes_for(:comment), :item_id => @item.id
          @comment = Comment.last
        end
        should_redirect_to('item path') { item_path(@item) }
        should_set_the_flash_to /success/
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
      should_redirect_to('item path') { item_path(@item) }
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
      should_redirect_to('item path') { item_path(@item) }
      should 'update the comment' do
        @comment.reload
        assert_equal 'this is totally new content', @comment.content
      end
    end
  end
end
