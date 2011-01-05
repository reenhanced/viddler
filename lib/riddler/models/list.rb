module Riddler
  class List < Array
    attr_accessor :session, :list_method, :list_method_options
    
    def initialize(session, response, list_method, list_method_options={})
      @session             = session
      @list_method         = list_method
      @list_method_options = list_method_options
      
      insert_response(response) unless response.empty?
    end

    private
    
    def insert_response(response)
      page     = response["list_result"]["page"].to_i
      per_page = response["list_result"]["per_page"].to_i
      
      offset   = per_page*(page-1)
      
      parse_response(response).each do |vid|
        self << vid
      end
    end
  end
end