require 'spec_helper'

describe ItemsController do
  render_views

  describe "requires login" do
    [[:put, :update], [:get, :edit], [:delete, :destroy], [:get, :star], [:get, :unstar]].each do |verb, action|
      it "should #{verb} #{action}" do
        send(verb, action, {:id => '1'})
      end
    end
  end

  describe "searching" do
    before(:each) do
      @big_title = Factory.create(:item, :title => "Big stuff")
      @big_body = Factory.create(:item, :content => "stuff that is big or something")
    end
    
    it "should return two items when I search for 'big'" do
      get :index, :q => 'big'
      
      # TODO: search content at some point.
      assigns[:items].count.should == 1
    end
  end

  describe 'anonymous users' do
    describe 'GET index' do
      before(:each) do
        get :index
      end

      it { should respond_with :success }
      it { should assign_to :items }
      it { should assign_to :items_count }
      it { should assign_to :front_page }
    end

    describe 'GET show' do
      describe 'of item with name' do
        before(:each) do
          @item = Factory.create(:item)
          get :show, :id => @item.to_param
        end

        it { should respond_with :success }
        it { should assign_to :item }
        it { should assign_to :title }
        it { should assign_to :comment }

        it "should set title from item's name" do
          @item.title.should == assigns[:title]
        end
      end

      describe "of item without name" do
        before(:each) do
          @item = Factory(:item, :name => nil)
          get :show, :id => @item.to_param
        end

        it { should respond_with :success }
        it { should assign_to :item }
        it { should assign_to :title }
        it { should assign_to :comment }

        it "should set title from item's title" do
          @item.title.should == assigns[:title]
        end
      end

      describe 'with non-existent item' do
        before(:each) do
          get :show, :id => 'nonexistent'
        end
        it { should respond_with 404 }
      end
    end

    describe 'GET to new' do
      before(:each) do
        get :new
      end

      it { should respond_with :success }
      it { should render_template :new }
      it { should assign_to :item }
    end

    describe 'GET to edit' do
      before(:each) do
        @item = Factory(:item)
        get :edit, :id => @item.id
      end

      it "should redirect to login" do
        response.should redirect_to login_path
      end
    end

    describe 'POST to create with failing captcha' do
      before(:each) do
        ItemsController.any_instance.should_receive(:passes_captcha?).and_return(false)
        post :create, :item => Factory.attributes_for(:item)
        @item = Item.last
      end

      it { should render_template :new }
    end

    describe 'POST to create with passing captcha' do
      before(:each) do
        ItemsController.any_instance.should_receive(:passes_captcha?).and_return(true)
        post :create, :item => Factory.attributes_for(:item, :byline => nil)
        @item = Item.last
      end

      it { should redirect_to(item_path(@item)) }

      it 'should set item byline to Anonymous' do
        @item.byline.should == 'Anonymous'
      end
    end
  end
end