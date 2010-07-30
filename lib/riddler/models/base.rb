module Riddler
  class Base
    def initialize(attrs={})
      self.attributes = attrs
    end
    
    # Class Attribute Methods
    def self.writable_api_attribute(*attrs)
      attr_accessor *attrs
    end
    
    def self.readable_api_attribute(*attrs)
      attr_reader *attrs
    end
    
    # Instance Attribute Methods
    def attributes=(attribute_hash, force=false)
      attribute_hash.each do |key,value|
        raise Riddler::Exceptions::Models::ReadOnlyAttributeError, "#{key} is read-only" if attribute_is_read_only?(key) && !force
    
        self.instance_variable_set("@#{key}", value)
      end
    end
    
    protected
    
    def attribute_is_read_only?(attribute)
      !self.respond_to?("#{attribute}=")
    end
  end
end