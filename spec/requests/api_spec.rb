require 'spec_helper'

describe "API" do
  
  it "should allow access with the appropriate header" do
    user = Factory.create(:user)
    item = Factory.create(:item)
    
    get '/items.json', nil, {'X-FLOW-API-KEY' => user.api_key}
    response.should be_success
    response.body.should_not be_nil
    response.body.should == [item].to_json
  end

end