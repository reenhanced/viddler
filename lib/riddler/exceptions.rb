module Riddler
  module Exceptions
    class ArgumentError < ::ArgumentError; end
    class AuthenticationError < ::StandardError; end
    
    class MissingApiKey < ::StandardError
      def message
        "You haven't defined an API key.  Either set Riddler::Client.api_key, or pass it when calling Riddler::Client.new"
      end
    end
    
    class ApiError < ::StandardError
      attr_accessor :code, :description, :details
      
      def initialize(code, description, details)
        self.code = code
        self.description = description
        self.details = details
        
        super("\##{code.to_s}: #{description.to_s} (#{details})")
      end
    end
  end
end