require File.dirname(__FILE__) + '/../test_helper'

class StarTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :item
  
  # TODO test uniqueness of user_id to item_id
end
