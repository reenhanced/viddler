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
  
    it "should set API key if given" do
      @client.api_key.should == @api_key
    end    
  end
  
  context "without API key" do
    it "should use Riddler::Client.api_key if it exists" do
      Riddler::Client.api_key = "abc123"
      Riddler::Client.new.api_key.should == "abc123"
    end
    
    it "should raise MissingApiKey exception if Riddler::Client.api_key is blank" do
      Riddler::Client.api_key = nil
      lambda {Riddler::Client.new}.should raise_error(Riddler::Exceptions::MissingApiKey)
    end
  end
end

describe Riddler::Client, "authentication" do
  before(:each) do
    @api_key = "abc123"
    @client = Riddler::Client.new(@api_key)
    
    @success = {
      'auth' => {
        'sessionid'    => 'asdf',
        'record_token' => 'fdsa'
      }
    }
    
    @client.stub!(:get).and_return(@success)
  end
  
  context "#authenticate!" do
    it "should call #post with username and password" do
      @client.should_receive(:get).with('viddler.users.auth', hash_including(:user => 'kyleslat', :password => '123'))
      @client.authenticate!('kyleslat', '123')
    end
    
    it "should set authenticated? to true if successful" do
      @client.authenticate!('kyleslat', '123')
      @client.should be_authenticated
    end
    
    it "should set sessionid" do
      @client.authenticate!('kyleslat', '123')
      @client.sessionid.should == 'asdf'
    end
    
    it "should return false if unsuccessful" do
      @client.stub!(:get).and_raise(RestClient::Forbidden)
      @client.authenticate!('bad', 'user').should be_false
    end
    
    it "should not be authenticated? if unsuccessful" do
      @client.stub!(:get).and_raise(RestClient::Forbidden)
      @client.authenticate!('bad', 'user')
      @client.should_not be_authenticated
    end
  end
  
  it "should not be authenticated? if authenticate! has not been called" do
    @client.authenticated?.should == false
  end
end

describe Riddler::Client, ".get" do
  before(:each) do
    @api_key = '318037e122bc94ce894b594c45534c415479'
    @client = Riddler::Client.new(@api_key)
    RestClient.stub!(:get).and_return("{\"viddler_api\":{\"version\":\"2.2.0\"}}")
  end
  
  it "should not require params" do
    lambda {@client.get('viddler.api.getInfo')}.should_not raise_error(ArgumentError)
  end
  
  it "should return result of JSON.parse" do
    @response = {'a' => 'b'}
    JSON.stub!(:parse).and_return(@response)
    @client.get('viddler.api.getInfo').should == @response
  end
  
  context "mock expectations" do
    it "should call Riddler::Client.get with proper method and extension" do
      RestClient.should_receive(:get).with('http://api.viddler.com/api/v2/viddler.api.getInfo.json', anything)
    end

    it "should include API key for Riddler::Client.get" do
      RestClient.should_receive(:get).with(anything, hash_including(:params => hash_including(:key => @api_key)))
    end
    
    it "should include additional args for Riddler::Client.get" do
      RestClient.should_receive(:get).with(anything, hash_including(:params => hash_including(:a => "b", :c => "d")))
    end
    
    it "should use custom endpoint if set" do
      @client.endpoint = "http://some/endpoint"
      RestClient.should_receive(:get).with(/http:\/\/some\/endpoint\//, anything())
    end
    
    it "should pass along cookies if set" do
      RestClient.should_receive(:get).with(anything, hash_including(:cookies => {:c => 1}))
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
    RestClient.stub!(:post).and_return("{\"viddler_api\":{\"version\":\"2.2.0\"}}")
  end
  
  it "should not require params" do
    lambda {@client.post('viddler.encoding.setOptions')}.should_not raise_error(ArgumentError)
  end
  
  it "should return result of JSON.parse" do
    @response = {'a' => 'b'}
    JSON.stub!(:parse).and_return(@response)
    @client.post('viddler.api.getInfo').should == @response
  end
  
  context "mock expectations" do
    it "should call Riddler::Client.post with proper method and extension" do
      RestClient.should_receive(:post).with('http://api.viddler.com/api/v2/viddler.encoding.setOptions.json', anything, anything)
    end
    
    it "should include API key for Riddler::Client.post" do
      RestClient.should_receive(:post).with(anything, hash_including(:key => @api_key), anything)
    end
    
    it "should include additional args for Riddler::Client.post" do
      RestClient.should_receive(:post).with(anything, hash_including(:a => "b", :c => "d"), anything)
    end
    
    it "should use custom endpoint if set" do
      @client.endpoint = "http://some/endpoint"
      RestClient.should_receive(:post).with(/http:\/\/some\/endpoint\//, anything, anything)
    end
    
    it "should pass along cookies if set" do
      RestClient.should_receive(:post).with(anything, anything, hash_including(:cookies => {:c => 1}))
    end
    
    after(:each) do
      @client.post('viddler.encoding.setOptions', {:a => "b", :c => "d"}, {:c => 1})
    end
  end
end

describe Riddler::Client, ".api_key" do
  before(:each) do
    Riddler::Client.api_key = "abc123"
  end
  
  it "should set the api key" do
    Riddler::Client.api_key.should == "abc123"
  end
end