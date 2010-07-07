require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Riddler::Playlists, ".new" do
  before(:each) do
    @client = mock(Riddler::Client)
  end
  
  it "should require client to be passed" do
    lambda {Riddler::Playlists.new}.should raise_error(ArgumentError)
  end
  
  it "should set client" do
    Riddler::Playlists.new(@client).client.should == @client
  end
end

describe Riddler::Playlists, "#new" do
  before(:each) do
    @client = mock(Riddler::Client)
    @valid_options = {
      :title => "New playlist",
      :type  => "smart",
      :sort  => "uploaded-desc"
    }
    
    @playlists = Riddler::Playlists.new(@client)
  end
  
  it "should require title" do
    lambda {@playlists.new(@valid_options.merge(:title => nil))}.should raise_error(Riddler::Exceptions::ArgumentError)
  end
end