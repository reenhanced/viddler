module Riddler
  class Base
    def call(method, params = {})
      if method_is_v2?(method)
        endpoint = "http://api.viddler.com/api/v2/#{method}.xml"
      else
        endpoint = 'http://api.viddler.com/rest/v1/'
        params[:method] = method
      end
      
      RestClient.get(endpoint, params)
    end
    
    protected
    
    def method_is_v2?(method)
      Riddler::V2_METHODS.include?(method)
    end
  end
end