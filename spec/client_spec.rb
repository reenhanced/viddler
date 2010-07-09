require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Riddler::Client, "configuration" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
  end
  
  it "should allow endpoint to be set" do
    lambda {@client.endpoint = "http://some/other/endpoint"}.should_not raise_error
  end
  
  it "should have correct default endpoint" do
    @client.endpoint.should == "http://api.viddler.com/api/v2"
  end
end

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
      lambda {Riddler::Client.new()}.should raise_error(ArgumentError)
    end
  end
end

describe Riddler::Client, ".get" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
  end
  
  it "should not require params" do
    lambda {@client.get('viddler.api.getInfo')}.should_not raise_error(ArgumentError)
  end
  
  context "mock expectations" do
    it "should call Riddler::Client.get with proper method and extension" do
      Riddler::Client.should_receive(:get).with('http://api.viddler.com/api/v2/viddler.api.getInfo.json', anything)
    end

    it "should include API key for Riddler::Client.get" do
      Riddler::Client.should_receive(:get).with(anything, hash_including(:query => hash_including(:key => @api_key)))
    end
    
    it "should include additional args for Riddler::Client.get" do
      Riddler::Client.should_receive(:get).with(anything, hash_including(:query => hash_including(:a => "b", :c => "d")))
    end
    
    it "should use custom endpoint if set" do
      @client.endpoint = "http://some/endpoint"
      Riddler::Client.should_receive(:get).with(/http:\/\/some\/endpoint\//, anything())
    end
    
    it "should pass along cookies if set" do
      Riddler::Client.should_receive(:get).with(anything, hash_including(:cookies => {:c => 1}))
    end
    
    after(:each) do
      @client.get('viddler.api.getInfo', {:a => "b", :c => "d"}, {:c => 1})
    end
  end
end

describe Riddler::Client, ".post" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
  end
  
  it "should not require params" do
    lambda {@client.post('viddler.encoding.setOptions')}.should_not raise_error(ArgumentError)
  end
  
  context "mock expectations" do
    it "should call Riddler::Client.post with proper method and extension" do
      Riddler::Client.should_receive(:post).with('http://api.viddler.com/api/v2/viddler.encoding.setOptions.json', anything)
    end
    
    it "should include API key for Riddler::Client.post" do
      Riddler::Client.should_receive(:post).with(anything, hash_including(:query => hash_including(:key => @api_key)))
    end
    
    it "should include additional args for Riddler::Client.post" do
      Riddler::Client.should_receive(:post).with(anything, hash_including(:query => hash_including(:a => "b", :c => "d")))
    end
    
    it "should use custom endpoint if set" do
      @client.endpoint = "http://some/endpoint"
      Riddler::Client.should_receive(:post).with(/http:\/\/some\/endpoint\//, anything())
    end
    
    it "should pass along cookies if set" do
      Riddler::Client.should_receive(:post).with(anything, hash_including(:cookies => {:c => 1}))
    end
    
    after(:each) do
      @client.post('viddler.encoding.setOptions', {:a => "b", :c => "d"}, {:c => 1})
    end
  end
end

describe Riddler::Client, "#playlists" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
    
    @playlists = mock(Riddler::Playlists)
    Riddler::Playlists.stub!(:new).and_return(@playlists)
  end
  
  it "should return result of Riddler::Playlists.new" do
    @client.playlists.should == @playlists
  end
  
  it "should pass self to Riddler::Playlists.new" do
    Riddler::Playlists.should_receive(:new).with(@client)
    @client.playlists
  end
end