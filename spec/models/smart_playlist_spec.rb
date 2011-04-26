require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::SmartPlaylist, ".create!" do
  before(:each) do
    @attributes = {
      :name => "Smart playlist"
    }
    
    @client  = mock(Riddler::Client)
    @session = mock(Riddler::Session, :client => @client)
    
    @video1_response = {
      "id" => "video1",
      "title" => "Video 1"
    }
  
    @video2_response = {
      "id" => "video2",
      "title" => "Video 2"
    }
    
    @rules = {
      "users" => "kyleslat,sandieman",
      "max_age" => 20,
      "tags" => "abc,xyz",
      "visibility" => "public",
      "min_views" => "10",
      "max_views" => "1000",
      "min_upload_date" => "2007-01-01",
      "max_upload_date" => "2009-01-01"
    }
  
    @response = {
      "list_result" => {
        "page" => "1",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "My new playlist",
          "type" => "smart",
          "rules" => @rules
        },
        "videos_list" => [@video1_response, @video2_response],
      }
    }
    @client.stub!(:post).and_return(@response)
    
    Riddler::VideoList.stub!(:new).and_return(mock(Riddler::VideoList))
  end
  
  it "should call api with type" do
    @client.should_receive(:post).with(anything, hash_including(:type => "smart"))
    Riddler::SmartPlaylist.create!(@session, @attributes)
  end
  
  it "sets rules" do
    Riddler::SmartPlaylist.create!(@session, @attributes).rules.should == @rules
  end
end