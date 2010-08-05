module Riddler
  class Playlist < Riddler::Base
    attr_reader :id, :name, :type, :videos, :session
    
    def initialize(session, response={})
      @session = session
      self.populate_from_response!(response)
    end
    
    def self.create!(session, attrs)
      klass = attrs[:type] == 'smart' ? Riddler::SmartPlaylist : Riddler::RegularPlaylist
      klass.new(session, session.client.post("viddler.playlists.create", attrs))
    end
    
    def update_attributes!(attributes)
      attributes[:playlist_id] = self.id
      populate_from_response! self.session.client.post('viddler.playlists.setDetails', attributes)
    end
    
    protected
    
    def populate_from_response!(response)
      @videos = Riddler::VideoList.new(@session, response)
      
      return unless response['list_result']
      
      if response['list_result']['playlist']
        playlist_attrs = response['list_result']['playlist']

        @id   = playlist_attrs['id']
        @name = playlist_attrs['name']
        @type = playlist_attrs['type']
      end
    end
  end
end
