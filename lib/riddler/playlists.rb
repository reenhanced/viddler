module Riddler
  class Playlists
    attr_reader :client
    
    def initialize(client)
      @client = client
    end
  end
end