module Riddler
  class Client
    attr_accessor :api_key, :endpoint
    
    def initialize(api_key)
      self.api_key = api_key
      self.endpoint = 'http://api.viddler.com/api/v2'
    end
    
    # Namespaces
    def playlists
      Riddler::Playlists.new(self)
    end
    
    # Standard Client Methods
    def get(method, params={}, cookies={})
      params.merge!(:key => self.api_key)
      JSON.parse(RestClient.get("#{self.endpoint}/#{method}.json", :params => params, :cookies => cookies))
    end
    
    def post(method, params={}, cookies={})
      params.merge!(:key => self.api_key)
      JSON.parse(RestClient.post("#{self.endpoint}/#{method}.json", :params => params, :cookies => cookies))
    end
  end
end