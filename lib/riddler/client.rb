module Riddler
  class Client
    attr_accessor :api_key, :endpoint, :sessionid
    
    def initialize(api_key=Riddler::Client.api_key)
      raise Riddler::Exceptions::MissingApiKey if api_key.nil?
      
      self.api_key = api_key
      self.endpoint = 'http://api.viddler.com/api/v2'
    end
    
    # Standard Client Methods
    def get(method, params={}, cookies={})
      params = {:key => self.api_key}.merge(params)
      JSON.parse(RestClient.get("#{self.endpoint}/#{method}.json", :params => params, :cookies => cookies))
    end
    
    def post(method, params={}, cookies={})
      params = {:key => self.api_key}.merge(params)
      JSON.parse(RestClient.post("#{self.endpoint}/#{method}.json", params, {:cookies => cookies}))
    end
    
    # Authentication
    def authenticate!(username, password)
      response = self.get('viddler.users.auth', :user => username, :password => password)
      self.sessionid = response['auth']['sessionid']
    rescue RestClient::Forbidden
      false
    end
    
    def authenticated?
      !self.sessionid.nil?
    end
    
    def self.api_key=(key)
      @@api_key = key
    end
    
    def self.api_key
      @@api_key
    end
  end
end