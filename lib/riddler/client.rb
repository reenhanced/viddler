module Riddler
  class Client
    include HTTParty
    base_uri 'api.viddler.com/api/v2/'
    
    attr_accessor :api_key
    
    def initialize(api_key)
      self.api_key = api_key
    end
    
    def get(method, params)
      Riddler::Client.get("/#{method}.json", {:key => self.api_key}.merge(params))
    end
  end
end