module Riddler
  class Client
    include HTTParty
    
    attr_accessor :api_key, :endpoint
    
    def initialize(api_key)
      self.api_key = api_key
      self.endpoint = 'http://api.viddler.com/api/v2'
    end
    
    def get(method, params={})
      params.merge!(:key => self.api_key)
      Riddler::Client.get("#{self.endpoint}/#{method}.json", :query => params)
    end
    
    def post(method, params={})
      params.merge!(:key => self.api_key)
      Riddler::Client.post("#{self.endpoint}/#{method}.json", :query => params)
    end
  end
end