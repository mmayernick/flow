require 'spec_helper'

describe Star do
  it { should belong_to :user }
  it { should belong_to :item }
  
  # TODO test uniqueness of user_id to item_id
end