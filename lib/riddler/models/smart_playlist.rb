module Riddler
  class SmartPlaylist < Playlist
    attr_reader :rules
    
    def self.create!(session, attributes)
      attributes[:type] = "smart"
      super
    end
    
    protected
    
    def populate_from_response!(response)
      @rules = response['list_result']['playlist']['rules'] if response['list_result'] && response['list_result']['playlist']
      super
    end
  end
end