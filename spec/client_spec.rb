require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Riddler::Client, ".get" do
  before(:each) do
    @response = '{"viddler_api":{"version":"2.0.0"}}'
    RestClient.stub!(:get).and_return(@response)
    
    @proper_url = "http://api.viddler.com/api/v2/viddler.api.getInfo.json"
  end    
  
  it "should call RestClient with the proper URL" do
    RestClient.should_receive(:get).with(@proper_url, anything()).and_return(@response)
    Riddler::Client.get('viddler.api.getInfo')
  end
  
  it "should return a hash" do
    Riddler::Client.get('viddler.api.getInfo').should be_kind_of(Hash)
  end

  it "should call JSON.parse with response" do
    JSON.should_receive(:parse).with(@response)
    Riddler::Client.get('viddler.api.getInfo')
  end
end