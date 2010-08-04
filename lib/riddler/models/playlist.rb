module Riddler
  class Playlist < Riddler::Base
    attr_reader :id, :name, :type, :videos
    
    def initialize(session, response={})
      @videos ||= []
      
      return unless response['list_result']
      
      if response['list_result']['playlist']
        playlist_attrs = response['list_result']['playlist']

        @id   = playlist_attrs['id']
        @name = playlist_attrs['name']
        @type = playlist_attrs['type']
      end
      
      if response['list_result']['videos_list']
        videos_list = response['list_result']['videos_list']
        
        videos_list.each do |vid|
          @videos << Riddler::Video.new(session, vid)
        end
      end
    end
    
    def self.create!(session, attrs)
      Riddler::Playlist.new(session, session.client.post("viddler.playlists.create", attrs))
    end
    
    protected
  end
end
