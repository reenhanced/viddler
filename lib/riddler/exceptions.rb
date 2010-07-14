module Riddler
  module Exceptions
    class ArgumentError < ::ArgumentError; end
    class MissingApiKey < ::StandardError
      def message
        "You haven't defined an API key.  Either set Riddler::Client.api_key, or pass it when calling Riddler::Client.new"
      end
    end
  end
end