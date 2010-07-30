module Riddler
  class Base
    def initialize(attrs={})
      attrs.each do |key, value|
        if self.respond_to?("#{key}=")
          self.send("#{key}=", value)
        else
          raise Riddler::Exceptions::Models::ReadOnlyAttributeError, "#{key} is read-only"
        end
      end
    end
    
    # Class Attribute Methods
    def self.writable_api_attribute(*attrs)
      attr_accessor *attrs
    end
    
    def self.readable_api_attribute(*attrs)
      attr_reader *attrs
    end
  end
end