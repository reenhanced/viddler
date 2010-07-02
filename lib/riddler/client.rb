module Riddler
  class Client
    include HTTParty
    base_uri 'api.viddler.com/api/v2/'
    
    attr_accessor :api_key
    
    def initialize(api_key)
      self.api_key = api_key
    end
    
    def get(method, params={})
      params.merge!(:key => self.api_key)
      Riddler::Client.get("/#{method}.json", :query => params)
    end
    
    def post(method, params={})
      params.merge!(:key => self.api_key)
      Riddler::Client.post("/#{method}.json", :query => params)
    end
  end
end