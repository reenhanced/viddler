require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::Session, ".new" do
  context "with no arguments" do
    before(:each) do
      @client = mock(Riddler::Client)
      Riddler::Client.stub!(:new).and_return(@client)
      
      @session = Riddler::Session.new
    end
    
    it "does not authenticate session" do
      @session.should_not be_authenticated
    end
    
    it "does not set id" do
      @session.id.should be_nil
    end
    
    it "sets client" do
      @session.client.should == @client
    end
    
    it "calls Riddler::Client.new without any arguments" do
      Riddler::Client.should_receive(:new).with(no_args)
      Riddler::Session.new
    end
  end
  
  context "with valid username and password" do
    before(:each) do
      @auth_response = {
        "auth" => {
          "sessionid" => "abc123"
        }
      }
      
      @client = mock(Riddler::Client)
      @client.stub!(:get).and_return(@auth_response)
      
      @client2 = mock(Riddler::Client)
      
      Riddler::Client.stub!(:new).and_return(@client, @client2)      
    end
    
    it "sets id to sessionid" do
      @session = Riddler::Session.new("user", "pass")
      @session.id.should == "abc123"
    end
    
    it "authenticates session" do
      @session = Riddler::Session.new("user", "pass")
      @session.should be_authenticated
    end
    
    it "calls viddler.users.auth with username and password" do
      @client.should_receive(:get).with("viddler.users.auth", hash_including(:user => "user", :password => "pass")).and_return(@auth_response)
      Riddler::Session.new("user", "pass")
    end
    
    it "sets client" do
      @session = Riddler::Session.new("user", "pass")
      @session.client.should == @client2
    end
    
    it "calls Riddler::Client.new with session id" do
      Riddler::Client.should_receive(:new).with(hash_including(:session_id => "abc123"))
      Riddler::Session.new("user", "pass")
    end
  end
end