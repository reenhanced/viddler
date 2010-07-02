module Riddler
  class Client
    def self.get(method, args = {})
      JSON.parse(RestClient.get("http://api.viddler.com/api/v2/#{method}.json", {:params => args}))
    end
  end
end