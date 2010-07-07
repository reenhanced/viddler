module Riddler
  class Playlists
    attr_reader :client
    
    def initialize(client)
      @client = client
    end
    
    def new(options)
      raise Riddler::Exceptions::ArgumentError if options[:title].blank?
    end
  end
end