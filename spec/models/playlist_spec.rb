require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::Playlist, ".new" do
  it "should require session" do
    lambda{Riddler::Playlist.new}.should raise_error(ArgumentError, /wrong number of arguments/)
  end
end

describe Riddler::Playlist, ".save on new playlist" do
  before(:each) do
    @session  = mock(Riddler::Session)
    @client   = mock(Riddler::Client)
    
    @session.stub!(:client).and_return(@client)
    
    @response = {
      "list_result" => {
        "page" => "1",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "My new playlist",
          "type" => "regular"
        }
      }
    }
    @client.stub!(:post).and_return(@response)
    
    @attributes = {
      :name => "My new playlist",
      :type => "regular"
    }
    
    @playlist = Riddler::Playlist.new(@session, @attributes)
  end
  
  it "should call viddler.playlists.create with proper attributes" do
    @client.should_receive(:post).with("viddler.playlists.create", hash_including(@attributes)).and_return(@response)
    @playlist.save
  end
  
  it "should set id from API response" do
    @playlist.save
    @playlist.id.should == "abc123"
  end
end