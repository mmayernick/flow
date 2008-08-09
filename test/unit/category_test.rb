require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  should_require_attributes :title
  should_ensure_length_in_range :title, (4..255)
  should_ensure_length_in_range :name, (4..255)
  # TODO test validates_format_of values
  
  context 'Category' do
    setup do
      @category = Factory(:category, :name => 'ever-so-slightly-longer')
    end
    
    should 'use name for #to_param' do
      assert_equal @category.name, @category.to_param
    end
    should_require_unique_attributes :name
  end
  
  # TODO contexts for Category with short/long title to test publicly_facing_name
end
