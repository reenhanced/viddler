module Riddler
  class PlaylistList < Array
    attr_reader :page, :per_page
    
    def initialize(session, response)
      @page     = response['list_result']['page'].to_i
      @per_page = response['list_result']['per_page'].to_i
      
      response['list_result']['playlists'].each do |playlist|
        self.<< Riddler::Playlist.new(session, playlist)
      end
    end
  end
end
