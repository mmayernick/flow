require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :item
  should ensure_length_of(:content).is_at_least(1).is_at_most(10000)
end
