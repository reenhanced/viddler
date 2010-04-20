module Riddler
  class Base
    def call(method, params = {})
      if Riddler::V2_METHODS.include?(method)
        endpoint = "http://api.viddler.com/api/v2/#{method}.xml"
      else
        endpoint = 'http://api.viddler.com/rest/v1/'
        params[:method] = method
      end
      
      RestClient.get(endpoint, params)
    end
  end
end