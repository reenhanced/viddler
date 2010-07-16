module Riddler
  class Client
    attr_accessor :api_key, :endpoint, :session_id, :session_cookie
    
    def initialize(options={})
      options = {:api_key => Riddler::Client.api_key}.merge(options)      
      raise Riddler::Exceptions::MissingApiKey if options[:api_key].nil?
      
      self.api_key        = options[:api_key]
      self.session_id     = options[:session_id] unless options[:session_id].nil?
      self.session_cookie = options[:session_cookie] || {}
      
      self.endpoint = 'http://api.viddler.com/api/v2'
    end
    
    # Standard Client Methods
    def get(method, params={}, cookies={})
      params  = add_session_params(params)
      cookies = add_session_cookie(cookies)
      
      JSON.parse(RestClient.get("#{self.endpoint}/#{method}.json", :params => params, :cookies => cookies))
    end
    
    def post(method, params={}, cookies={})
      params  = add_session_params(params)
      cookies = add_session_cookie(cookies)
      
      JSON.parse(RestClient.post("#{self.endpoint}/#{method}.json", params, {:cookies => cookies}))
    end
    
    # Authentication
    def authenticate!(username, password)
      response = self.get('viddler.users.auth', :user => username, :password => password)
      self.session_id = response['auth']['sessionid']
    rescue RestClient::Forbidden
      false
    end
    
    def authenticated?
      !self.session_id.nil?
    end
    
    def has_session?
      !self.session_id.nil? || !self.session_cookie.empty?
    end
    
    def self.api_key=(key)
      @@api_key = key
    end
    
    def self.api_key
      @@api_key ||= nil
    end
    
    protected
    
    def add_session_params(params)
      session_params = {}
      
      session_params[:key]       = self.api_key
      session_params[:sessionid] = self.session_id unless self.session_id.nil?
      
      session_params.merge(params)
    end
    
    def add_session_cookie(cookies)
      session_cookie.merge(cookies)
    end
  end
end
