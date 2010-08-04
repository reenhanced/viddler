module Riddler
  class Playlist < Riddler::Base
    attr_reader :id, :name, :type, :videos
    
    def initialize(session, response={})
      @videos = VideoList.new(session, response)
      
      return unless response['list_result']
      
      if response['list_result']['playlist']
        playlist_attrs = response['list_result']['playlist']

        @id   = playlist_attrs['id']
        @name = playlist_attrs['name']
        @type = playlist_attrs['type']
      end
    end
    
    def self.create!(session, attrs)
      klass = attrs[:type] == 'smart' ? Riddler::SmartPlaylist : Riddler::RegularPlaylist
      klass.new(session, session.client.post("viddler.playlists.create", attrs))
    end
    
    protected
  end
end
