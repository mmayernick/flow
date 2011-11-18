require 'spec_helper'

describe CommentsController do
  render_views
  
  describe "as an anonymous user" do
    [[:put, :update], [:get, :edit], [:delete, :destroy]].each do |verb, action|
      it "should #{verb} #{action}" do
        send(verb, action, {:id => '1'})
      end
    end
  end
  
  describe "as a registered user" do
    before(:each) do
      @user = Factory.create(:user)
      login_as @user
    end
    
    describe "admin actions are protected" do
      [[:get, :edit], [:put, :update], [:delete, :destroy]].each do |verb, action|
        it "should #{verb} #{action}" do
          send(verb, action, {:id => '1'})
        end
      end      
    end
    
    describe 'POST to create' do
      before(:each) do
        @item = Factory.create(:item)
        post :create, :comment => Factory.attributes_for(:comment, :item_id => @item.id), :item_id => @item.id
        @comment = Comment.last
      end
      
      it { should redirect_to(item_path(@item)) }
      it { should set_the_flash.to(/success/) }

      it 'should assign current user to comment' do
        @user.should == @comment.user
      end
    end    
  end

  describe 'As an anonymous user' do
    describe 'POST to create' do
      before(:each) do
        @item = Factory.create(:item)
      end
      
      describe 'with failing captcha' do
        before(:each) do
          CommentsController.any_instance.should_receive(:passes_captcha?).and_return(false)
          post :create, :comment => Factory.attributes_for(:comment), :item_id => @item.id
          @comment = Comment.last
        end
        
        it { should respond_with :success }
        #it { should set_the_flash.to /CAPTCHA/ }
        it { should set_the_flash }
        it { should assign_to :item }
        it { should assign_to :comment }
        it { should render_template 'items/show' }
      end
      
      describe 'with passing captcha' do
        before(:each) do
          CommentsController.any_instance.should_receive(:passes_captcha?).and_return(true)
          post :create, :comment => Factory.attributes_for(:comment), :item_id => @item.id
          @comment = Comment.last
        end
        
        it { should redirect_to(item_path(@item)) }
        it { should set_the_flash.to /success/ }
        
        it 'should assign current user to comment' do
          @user.should == @comment.user
        end
        
      end
    end
  end

  ####
  
  describe 'As an admin user' do
    before(:each) do
      @user = Factory.create(:admin)
      login_as @user
    end
    
    describe 'DELETE to destroy' do
      before(:each) do
        @item = Factory.create(:item)
        @comment = Factory.create(:comment, :item => @item)
        delete :destroy, :id => @comment.id, :item_id => @item.id
      end
      
      it { should redirect_to(item_path(@item)) }
      it 'should remove comment' do
        Comment.find_by_id(@comment.id).should be_nil
      end
    end
    
    describe 'PUT to update' do
      before(:each) do
        @item = Factory.create(:item)
        @comment = Factory.create(:comment, :item => @item)
        put :update, :id => @comment.id, :item_id => @item.id, :comment => Factory.attributes_for(:comment, :content => 'this is totally new content')
      end
      
      it { should redirect_to(item_path(@item)) }
      it 'should update the comment' do
        @comment.reload
        @comment.content.should == 'this is totally new content'
      end
    end
  end
end