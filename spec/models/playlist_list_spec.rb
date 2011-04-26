require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Riddler::PlaylistList, ".new" do
  before(:each) do
    @session = mock(Riddler::Session)
    
    @playlist1_response = {
      'id' => 'playlist1',
      'name' => 'Playlist 1'
    }
    
    @playlist2_response = {
      'id' => 'playlist2',
      'name' => 'Playlist 2'
    }
    
    @response = {
      'list_result' => {
        'page' => '1',
        'per_page' => '10',
        'playlists' => [
          @playlist1_response,
          @playlist2_response
        ]
      }
    }
    
    @playlist1 = mock(Riddler::Playlist)
    @playlist2 = mock(Riddler::Playlist)
    
    Riddler::Playlist.stub!(:new).and_return(@playlist1, @playlist2, nil)
    
    @list = Riddler::PlaylistList.new(@session, @response)
  end
  
  it "contains playlists at correct indices" do
    @list[0].should == @playlist1
    @list[1].should == @playlist2
  end
  
  it "sets page" do
    @list.page.should == 1
  end
  
  it "sets per_page" do
    @list.per_page.should == 10
  end
  
  it "calls Riddler::Playlist.new with each video" do
    Riddler::Playlist.should_receive(:new).with(@session, @playlist1_response)
    Riddler::Playlist.should_receive(:new).with(@session, @playlist2_response)
    Riddler::PlaylistList.new(@session, @response)
  end
end