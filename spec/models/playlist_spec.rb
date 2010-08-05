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
  
  it "sets session" do
    @playlist.session.should == @session
  end
end

describe Riddler::Playlist, "#update_attributes!" do
  before(:each) do
    @new_response = {
      "list_result" => {
        "page" => "1",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "New name",
          "type" => "regular"
        }
      }
    }    
    
    @client = mock(Riddler::Client)
    @client.stub!(:post).and_return(@new_response)
    
    @session = mock(Riddler::Session, :client => @client)
    Riddler::Session.stub!(:new).and_return(@session)
    
    @videos = mock(Riddler::VideoList)
    Riddler::VideoList.stub!(:new).and_return(@videos)
    
    @attributes = {
      :name => "New name"
    }
    
    @original_response = {
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
    
    @playlist = Riddler::Playlist.new(@session, @original_response)
  end
  
  it "calls post on client with viddler.playlists.setDetails and attributes" do
    @client.should_receive(:post).with("viddler.playlists.setDetails", hash_including(@attributes))
    @playlist.update_attributes!(@attributes)
  end
  
  it "includes playlist id in API call" do
    @client.should_receive(:post).with(anything, hash_including(:playlist_id => "abc123"))
    @playlist.update_attributes!(@attributes)
  end
  
  it "should update the name attribute" do
    @playlist.update_attributes!(@attributes)
    @playlist.name.should == "New name"
  end
end

describe Riddler::Playlist, ".find" do
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
        },
      
        "videos_list" => [@video1_response, @video2_response]
      }
    }
    
    @client = mock(Riddler::Client)
    @client.stub!(:get).and_return(@response)
    
    @session = mock(Riddler::Session)
    @session.stub!(:client).and_return(@client)
    
    @playlist = mock(Riddler::Playlist)
    Riddler::Playlist.stub!(:new).and_return(@playlist)
    
    @regular_playlist = mock(Riddler::RegularPlaylist)
    Riddler::RegularPlaylist.stub!(:new).and_return(@regular_playlist)
    
    @smart_playlist = mock(Riddler::SmartPlaylist)
    Riddler::SmartPlaylist.stub!(:new).and_return(@smart_playlist)
  end
  
  it "requires session and id" do
    lambda {Riddler::Playlist.find}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "calls viddler.playlists.getDetails with id" do
    @client.should_receive(:get).with('viddler.playlists.getDetails', hash_including(:playlist_id => "abc123"))
    Riddler::Playlist.find(@session, "abc123")
  end
  
  it "passes session and response to RegularPlaylist.new if no type" do
    @response['list_result']['playlist'].delete('type')
    Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.find(@session, 'abc123')
  end
  
  it "passes session and response to RegularPlaylist.new if type = regular" do
    @response['list_result']['playlist']['type'] = 'regular'
    Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.find(@session, "abc123")
  end
  
  it "passes session and response to SmartPlaylist.new if smart playlist" do
    @response['list_result']['playlist']['type'] = 'smart'
    Riddler::SmartPlaylist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.find(@session, "abc123")
  end
  
  it "returns result of RegularPlaylist.new if no type" do
    @response['list_result']['playlist'].delete('type')
    Riddler::Playlist.find(@session, "abc123").should == @regular_playlist
  end
  
  it "returns result of RegularPlaylist.new if type = regular" do
    @response['list_result']['playlist']['type'] = 'regular'
    Riddler::Playlist.find(@session, "abc123").should == @regular_playlist
  end
  
  it "returns result of SmartPlaylist.new if type = smart" do
    @response['list_result']['playlist']['type'] = 'smart'
    Riddler::Playlist.find(@session, 'abc123').should == @smart_playlist
  end
end

describe Riddler::Playlist, ".move_video" do
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
        },
      
        "videos_list" => [@video2_response, @video1_response]
      }
    }
    
    @client = mock(Riddler::Client)
    @client.stub!(:get).and_return(@response)

    @session = mock(Riddler::Session, :client => @client)
    
    @regular_playlist = mock(Riddler::RegularPlaylist)
    Riddler::RegularPlaylist.stub!(:new).and_return(@regular_playlist)
    
    @smart_playlist = mock(Riddler::SmartPlaylist)
    Riddler::SmartPlaylist.stub!(:new).and_return(@smart_playlist)
  end
  
  it "requires session, playlist_id, from, to" do
    lambda {Riddler::Playlist.move_video}.should raise_error(ArgumentError, /0 for 4/)
  end
  
  it "calls get viddler.playlists.moveVideo with playlist_id, from, and to" do
    @client.should_receive(:get).with('viddler.playlists.moveVideo', hash_including(:playlist_id => "abc123", :from => "3", :to => "1"))
    Riddler::Playlist.move_video(@session, "abc123", "3", "1")
  end
  
  context "(no type)" do
    before(:each) do
      @response['list_result']['playlist'].delete('type')
    end
    
    it "calls RegularPlaylist.new with session and response" do
      Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
      Riddler::Playlist.move_video(@session, "abc123", "3", "1")
    end
    
    it "returns RegularPlaylist.new" do
      Riddler::Playlist.move_video(@session, "abc123", "3", "1").should == @regular_playlist
    end
  end
  
  context "(type = regular)" do
    before(:each) do
      @response['list_result']['playlist']['type'] = "regular"
    end
    
    it "calls RegularPlaylist.new with session and response" do
      Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
      Riddler::Playlist.move_video(@session, "abc123", "3", "1")
    end
    
    it "returns RegularPlaylist.new" do
      Riddler::Playlist.move_video(@session, "abc123", "3", "1").should == @regular_playlist
    end
  end
  
  context "(type = smart)" do
    before(:each) do
      @response['list_result']['playlist']['type'] = "smart"
    end
    
    it "calls SmartPlaylist.new with session and response" do
      Riddler::SmartPlaylist.should_receive(:new).with(@session, @response)
      Riddler::Playlist.move_video(@session, "abc123", "3", "1")
    end
    
    it "returns SmartPlaylist.new" do
      Riddler::Playlist.move_video(@session, "abc123", "3", "1").should == @smart_playlist
    end
  end
end

describe Riddler::Playlist, ".remove_video" do
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
        },
      
        "videos_list" => [@video2_response, @video1_response]
      }
    }
    
    @client = mock(Riddler::Client)
    @client.stub!(:get).and_return(@response)

    @session = mock(Riddler::Session, :client => @client)
    
    @playlist = mock(Riddler::RegularPlaylist)
    Riddler::RegularPlaylist.stub!(:new).and_return(@playlist)
  end
  
  it "requires session, playlist_id, and position" do
    lambda {Riddler::Playlist.remove_video}.should raise_error(ArgumentError, /0 for 3/)
  end
  
  it "calls get viddler.playlists.removeVideo with session, playlist_id, and position" do
    @client.should_receive(:get).with('viddler.playlists.removeVideo', hash_including(:playlist_id => "abc123", :position => "4"))
    Riddler::Playlist.remove_video(@session, "abc123", "4")
  end
  
  it "returns value of Riddler::RegularPlaylist.new" do
    Riddler::Playlist.remove_video(@session, "abc123", "4").should == @playlist
  end
  
  it "calls Riddler::RegularPlaylist.new with session and response" do
    Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.remove_video(@session, "abc123", "4")
  end
end

describe Riddler::Playlist, ".add_video" do
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
        },
      
        "videos_list" => [@video2_response, @video1_response]
      }
    }
    
    @client = mock(Riddler::Client)
    @client.stub!(:post).and_return(@response)

    @session = mock(Riddler::Session, :client => @client)
    
    @playlist = mock(Riddler::RegularPlaylist)
    Riddler::RegularPlaylist.stub!(:new).and_return(@playlist)
  end
  
  it "requires session, playlist_id, video_id" do
    lambda {Riddler::Playlist.add_video}.should raise_error(ArgumentError, /0 for 3/)
  end
  
  it "calls post viddler.playlists.addVideo with session and params" do
    @client.should_receive(:post).with("viddler.playlists.addVideo", hash_including(:playlist_id => "abc123", :video_id => "123abc"))
    Riddler::Playlist.add_video(@session, "abc123", "123abc")
  end
  
  it "returns value of Riddler::RegularPlaylist.new" do
    Riddler::Playlist.add_video(@session, "abc123", "123abc").should == @playlist
  end
  
  it "calls Riddler::RegularPlaylist.new with session and response" do
    Riddler::RegularPlaylist.should_receive(:new).with(@session, @response)
    Riddler::Playlist.add_video(@session, "abc123", "123abc")
  end
end