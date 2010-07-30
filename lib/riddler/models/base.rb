module Riddler
  class Base
    def initialize(attrs={})
      self.attributes = attrs
    end
    
    # Class Attribute Methods
    def self.writable_api_attribute(*attrs)
      attr_accessor *attrs
      @@api_attributes ||= []
      @@api_attributes  += attrs
    end
    
    def self.readable_api_attribute(*attrs)
      attr_reader *attrs
      @@api_attributes ||= []
      @@api_attributes  += attrs
    end
    
    # Instance Attribute Methods
    def attributes=(attribute_hash, force=false)
      filtered_attributes = filter_attributes(attribute_hash)
      
      filtered_attributes.each do |key,value|
        raise Riddler::Exceptions::Models::ReadOnlyAttributeError, "#{key} is read-only" if attribute_is_read_only?(key) && !force
    
        self.instance_variable_set("@#{key}", value)
      end
    end
    
    protected
    
    def filter_attributes(hash)
      new_hash = hash.dup
      new_hash.each do |key, value|
        new_hash.delete(key) unless @@api_attributes.include?(key)
      end
    end
    
    def attribute_is_read_only?(attribute)
      !self.respond_to?("#{attribute}=")
    end
  end
end