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
    
    @attributes = {
      :name => "My new playlist",
      :type => "regular"
    }
    
    @client.stub!(:post).and_return(@response)
    
    @playlist = mock(Riddler::Playlist)
    Riddler::RegularPlaylist.stub!(:new).and_return(@playlist)
  end
  
  it "requires a session and attributes" do
    lambda {Riddler::Playlist.create!}.should raise_error(/0 for 2/)
  end

  it "calls viddler.playlists.create with proper attributes" do
    @client.should_receive(:post).with("viddler.playlists.create", hash_including(@attributes)).and_return(@response)
    Riddler::Playlist.create!(@session, @attributes)
  end
  
  context "(regular playlist)" do
    before(:each) do
      @playlist = mock(Riddler::RegularPlaylist)
      Riddler::RegularPlaylist.stub!(:new).and_return(@playlist)
    end
    
    it "returns result of Riddler::RegularPlaylist.new" do
      Riddler::Playlist.create!(@session, @attributes).should == @playlist
    end
  
    it "calls Riddler::RegularPlaylist.new with session and API response" do
      Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
      Riddler::Playlist.create!(@session, @attributes)
    end
  end
  
  context "(smart playlist)" do
    before(:each) do
      @response["list_result"]["playlist"]["type"] = "smart"
      @attributes[:type] = "smart"
      
      @playlist = mock(Riddler::SmartPlaylist)
      Riddler::SmartPlaylist.stub!(:new).and_return(@playlist)
    end
    
    it "returns result of Riddler::SmartPlaylist.new" do
      Riddler::Playlist.create!(@session, @attributes).should == @playlist
    end
    
    it "calls Riddler::SmartPlaylist.new with session and API response" do
      Riddler::SmartPlaylist.should_receive(:new).with(@session, @response)
      Riddler::Playlist.create!(@session, @attributes)
    end
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
  
    @video_list = mock(Riddler::VideoList)
  
    Riddler::VideoList.stub!(:new).and_return(@video_list)
  
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

  it "calls VideoList.new with @session and @response" do
    Riddler::VideoList.should_receive(:new).with(@session, @response)
    @playlist = Riddler::Playlist.new(@session, @response)
  end

  it "assigns videos" do
    @playlist.videos.should == @video_list
  end
end