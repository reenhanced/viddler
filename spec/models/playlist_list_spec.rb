require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Riddler::PlaylistList, ".new" do
  before(:each) do
    @session = mock(Riddler::Session)
    
    @playlist1 = {
      'id' => 'playlist1',
      'name' => 'Playlist 1'
    }
    
    @playlist2 = {
      'id' => 'playlist2',
      'name' => 'Playlist 2'
    }
    
    @response = {
      'list_result' => {
        'page' => '1',
        'per_page' => '10',
        'playlists' => [
          @playlist1,
          @playlist2
        ]
      }
    }
  end
  
  it "should contain playlists at correct indices" do
    
  end
end