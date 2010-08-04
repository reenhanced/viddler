require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::Playlist, ".create!" do
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
    
    @playlist = mock(Riddler::Playlist)
    Riddler::Playlist.stub!(:new).and_return(@playlist)
  end
  
  it "requires a session and attributes" do
    lambda {Riddler::Playlist.create!}.should raise_error(/0 for 2/)
  end
  
  it "calls viddler.playlists.create with proper attributes" do
    @client.should_receive(:post).with("viddler.playlists.create", hash_including(@attributes)).and_return(@response)
    Riddler::Playlist.create!(@session, @attributes)
  end
  
  it "returns result of Riddler::Playlist.new" do
    Riddler::Playlist.create!(@session, @attributes).should == @playlist
  end
  
  it "calls Riddler::Playlist.new with session and API response" do
    Riddler::Playlist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.create!(@session, @attributes)
  end
end

describe Riddler::Playlist, ".new" do
  before(:each) do
    @video1_response = {
      "id" => "video1",
      "title" => "Video 1"
    }
    
    @video2_response = {
      "id" => "video2",
      "title" => "Video 2"
    }
    
    @response = {
      "list_result" => {
        "page" => "1",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "My new playlist",
          "type" => "regular"
        },
        
        "videos_list" => [@video1_response, @video2_response]
      }
    }
    
    @session = mock(Riddler::Session)
    
    @video1 = mock(Riddler::Video)
    @video2 = mock(Riddler::Video)
    
    Riddler::Video.stub!(:new).and_return(@video1, @video2)
    
    @playlist = Riddler::Playlist.new(@session, @response)    
  end
  
  it "requires session" do
    lambda {Riddler::Playlist.new}.should raise_error(ArgumentError)
  end
  
  it "does not require attributes" do
    lambda {Riddler::Playlist.new(@session)}.should_not raise_error
  end
  
  it "assigns id" do
    @playlist.id.should == "abc123"
  end
  
  it "assigns name" do
    @playlist.name.should == "My new playlist"
  end
  
  it "assigns type" do
    @playlist.type.should == "regular"
  end
  
  it "calls Video.new with session and videos" do
    Riddler::Video.should_receive(:new).with(@session, @video1_response).once
    Riddler::Video.should_receive(:new).with(@session, @video2_response).once
    @playlist = Riddler::Playlist.new(@session, @response)
  end
  
  it "assigns videos" do
    @playlist.videos.should == [@video1, @video2]
  end
end