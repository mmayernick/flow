require 'test_helper'

class ItemObserverTest < ActiveSupport::TestCase
  should_be_an_observer
  should_observe Item
end