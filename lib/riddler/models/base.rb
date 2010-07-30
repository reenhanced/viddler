module Riddler
  class Base
    # Class Attribute Methods
    def self.writable_api_attribute(*attrs)
      attr_accessor *attrs
    end
    
    def self.readable_api_attribute(*attrs)
      attr_reader *attrs
    end
  end
end