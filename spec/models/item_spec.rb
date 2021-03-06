require 'spec_helper'

describe Item do
  it { should belong_to :user }
  it { should have_many :comments }

  it { should ensure_length_of(:title).is_at_least(4).is_at_most(255) }
  it { should ensure_length_of(:name).is_at_least(4).is_at_most(255) }
  it { should ensure_length_of(:content).is_at_least(25).is_at_most(1200) }
  it { should ensure_length_of(:byline).is_at_least(0).is_at_most(50) }

  describe "search scope"
  describe "as_json"

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
    it { should validate_uniqueness_of :url }
    
    describe "URLs" do
      it "can be nil" do
        Factory.create(:item, :url => nil).should_not be_new_record
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

      it 'should have byline of Anonymous' do
        @item.byline.should == 'Anonymous'
      end

      it 'should still be anonymous' do
        @item.should be_anonymous
      end
    end
  end
end