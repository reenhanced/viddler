module Riddler
  class Playlist < Riddler::Base
    writable_api_attribute :id, :type, :name
    
    def initialize(session, attrs={})
      super(session, attrs)
    end
    
    def save
      attributes = {
        :name => self.name,
        :type => self.type
      }
      
      populate_from_api_response!(self.session.client.post("viddler.playlists.create", attributes))
    end
    
    protected
    
    def populate_from_api_response!(response)
      playlist  = response["list_result"]["playlist"]

      self.id   = playlist["id"]
      self.type = playlist["type"]
      self.name = playlist["name"]
    end
  end
end