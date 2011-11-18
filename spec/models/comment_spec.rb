require 'spec_helper'

describe Comment do
  it { should belong_to :user }
  it { should belong_to :item }
  it { should ensure_length_of(:content).is_at_least(1).is_at_most(10000) }
end