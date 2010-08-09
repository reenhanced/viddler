module Riddler
  class Session
    attr_reader :id, :client
    
    def initialize(username=nil, password=nil)
      unless username.nil? || password.nil?
        authenticate!(username, password)
        @client = Riddler::Client.new(:session_id => self.id)
      else
        @client = Riddler::Client.new
      end
    rescue RestClient::Forbidden
      raise Riddler::Exceptions::AuthenticationError, "You supplied an incorrect username or password"
    end
    
    def authenticated?
      !self.id.nil?
    end
    
  protected
  
    def authenticate!(username, password)
      auth = Riddler::Client.new.get("viddler.users.auth", :user => username, :password => password)
      @id = auth["auth"]["sessionid"]
    end
  end
end