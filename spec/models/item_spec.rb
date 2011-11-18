require 'spec_helper'

describe Item do
  it { should belong_to :user }
  it { should have_many :comments }
  it { should have_many :stars }

  it { should ensure_length_of(:title).is_at_least(4).is_at_most(255) }
  it { should ensure_length_of(:name).is_at_least(4).is_at_most(255) }
  it { should ensure_length_of(:content).is_at_least(25).is_at_most(1200) }
  it { should ensure_length_of(:byline).is_at_least(0).is_at_most(50) }

  # TODO test tagging stuff

  describe 'An Item' do
    before(:each) do
      @item = Factory(:item, :name => 'ihasname')
    end

    subject { @item }

    it { should validate_uniqueness_of :name }
    it { should allow_value('name_1').for(:name) }
    it { should allow_value('name-1').for(:name) }
    it { should_not allow_value('name 1').for(:name) }

    it 'should provide tweetable title' do
      short_title = "".rjust(100,"words")
      long_title  = "".rjust(140,"words")

      @item.title = short_title
      @item.tweetable_title.size.should == 100 
      @item.title = long_title
      @item.tweetable_title.size.should == 119
    end

    describe 'that has been starred by a user' do
      before(:each) do
        @user = Factory(:user)
        @user.stars.create(:item => @item)
      end

      it 'should be starred by user' do
        @item.is_starred_by_user(@user).should be_true
      end

      it 'should generate starred css class' do
        @item.starred_class(@user).should == 'starred'
      end
    end

    describe 'that has not been starred by a user' do
      before(:each) do
        @user = Factory(:user)
      end

      it 'should be starred by user' do
        @item.is_starred_by_user(@user).should be_false
      end

      it 'should generate empty css class' do
        @item.starred_class(@user).should be_blank
      end
    end
  end

  describe 'An Item with a nil byline and user_id' do
    before(:each) do
      @item = Factory.build(:item, :byline => nil, :user => nil)
    end

    subject { @item }

    it 'should be anonymous' do
      @item.should be_anonymous
    end

    describe 'when saved' do
      before(:each) do
        @item.save
      end

      it 'should have byline of Anonymous Coward' do
        @item.byline.should == 'Anonymous Coward'
      end

      it 'should still be anonymous' do
        @item.should be_anonymous
      end
    end
  end
end