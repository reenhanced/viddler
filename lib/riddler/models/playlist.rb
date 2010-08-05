module Riddler
  class Playlist < Riddler::Base
    attr_reader :id, :name, :type, :videos, :session
    
    def initialize(session, response={})
      @session = session
      self.populate_from_response!(response)
    end
    
    def self.create!(session, attrs)
      response = session.client.post("viddler.playlists.create", attrs)
      self.new_with_proper_class(session, response)
    end
    
    def self.find(session, id)
      response = session.client.get("viddler.playlists.getDetails", :playlist_id => id)
      self.new_with_proper_class(session, response)
    end
    
    def self.move_video(session, playlist_id, from_index, to_index)
      response = session.client.get("viddler.playlists.moveVideo", {
        :playlist_id => playlist_id,
        :from        => from_index,
        :to          => to_index 
      })
      
      self.new_with_proper_class(session, response)
    end
    
    def update_attributes!(attributes)
      attributes[:playlist_id] = self.id
      populate_from_response! self.session.client.post('viddler.playlists.setDetails', attributes)
    end
    
    protected
    
    def self.new_with_proper_class(session, response)
      klass = response['list_result']['playlist']['type'] == 'smart' ? Riddler::SmartPlaylist : Riddler::RegularPlaylist
      klass.new(session, response)
    end
    
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
