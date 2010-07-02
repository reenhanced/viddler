require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Riddler::Client, ".new" do
  context "with API key" do
    before(:each) do
      @api_key = '318037e122bc94ce894b594c45534c415479'
      @client = Riddler::Client.new(@api_key)
    end
  
    it "should set API key" do
      @client.api_key.should == @api_key
    end
  end
  
  context "without API key" do
    it "should require API key" do
      lambda {Riddler::Client.new()}.should raise_error
    end
  end
end

describe Riddler::Client, ".get" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
  end
  
  # Mock Expectations
  context "mock expectations" do
    it "should call Riddler::Client.get with proper method and extension" do
      Riddler::Client.should_receive(:get).with('/viddler.api.getInfo.json', anything)
    end

    it "should include API key for Riddler::Client.get" do
      Riddler::Client.should_receive(:get).with(anything, hash_including(:key => @api_key))
    end
    
    it "should include additional args for Riddler::Client.get" do
      Riddler::Client.should_receive(:get).with(anything, hash_including(:a => "b", :c => "d"))
    end
    
    after(:each) do
      @client.get('viddler.api.getInfo', {:a => "b", :c => "d"})
    end
  end
end