require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  should_belong_to :user
  should_have_many :comments
  should_have_many :stars

  should_ensure_length_in_range :title, (4..255)
  should_ensure_length_in_range :name, (4..255)
  should_ensure_length_in_range :content, (25..1200)
  should_ensure_length_in_range :byline, (0..18)

  # TODO test tagging stuff

  context 'An Item' do
    setup do
      @item = Factory(:item, :name => 'ihasname')
    end
    
    subject { @item }

    should_validate_uniqueness_of :name

    should_allow_values_for :name, 'name-1', 'name_1'
    should_not_allow_values_for :name, 'name 1'
    
    should 'provide tweetable title' do
      short_title = "".rjust(100,"words")
      long_title  = "".rjust(140,"words")
      
      @item.title = short_title
      assert_equal 100, @item.tweetable_title.size
      @item.title = long_title
      assert_equal 119, @item.tweetable_title.size
    end
    
    context 'that has been starred by a user' do
      setup do
        @user = Factory(:user)
        @user.stars.create(:item => @item)
      end

      should 'be starred by user' do
        assert @item.is_starred_by_user(@user)
      end

      should 'generate starred css class' do
        assert_equal 'starred', @item.starred_class(@user)
      end
    end

    context 'that has not been starred by a user' do
      setup do
        @user = Factory(:user)
      end

      should 'be starred by user' do
        assert !@item.is_starred_by_user(@user)
      end

      should 'generate empty css class' do
        assert_equal '', @item.starred_class(@user)
      end
    end
  end

  context 'An Item with a nil byline and user_id' do
    setup do 
      @item = Factory.build(:item, :byline => nil, :user => nil)
    end
    
    subject { @item }

    should 'be anonymous' do
      assert @item.anonymous?
    end

    context 'when saved' do
      setup do
        @item.save
      end

      should 'have byline of Anonymous Coward' do
        assert_equal 'Anonymous Coward', @item.byline
      end

      should 'still be anonymous' do
        assert @item.anonymous?
      end
    end
  end

end