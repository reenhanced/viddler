require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Riddler::Base, '#call' do
  before(:each) do
    @base = Riddler::Base.new
    RestClient.stub!(:get).and_return('body')
  end
  
  context "(v2 method)" do
    before(:each) do
      @api_url = 'http://api.viddler.com/api/v2/viddler.api.getInfo.xml'
      @base.stub!(:method_is_v2?).and_return(true)
    end
    
    it "should call RestClient.get with proper url" do
      RestClient.should_receive(:get).with(@api_url, anything)
      @base.call('viddler.api.getInfo')
    end
  end
  
  context "(v1 method)" do
    before(:each) do
      @api_url = 'http://api.viddler.com/rest/v1/'
      @base.stub!(:method_is_v2?).and_return(false)
    end
  
    it "should call RestClient.get with proper url" do
      RestClient.should_receive(:get).with(@api_url, anything)
      @base.call('viddler.users.setOptions')
    end
    
    it "should call RestClient.get with proper url and method as parameter" do
      RestClient.should_receive(:get).with(@api_url, hash_including(:method => 'viddler.users.setOptions'))
      @base.call('viddler.users.setOptions')
    end
  end
  
  context "with parameters" do
    it "should pass parameters to RestClient.get" do
      RestClient.should_receive(:get).with(anything, hash_including(:username => "kyleslat"))
      @base.call('viddler.users.getProfile', :username => "kyleslat")
    end
  end
end