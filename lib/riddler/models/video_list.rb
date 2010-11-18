module Riddler
  class VideoList < List
    def initialize(session, response, list_method, list_method_options={})
      super session, list_method, list_method_options
      
      return if response.empty?
      
      insert_response(response)
    end
    
    private
    
    def insert_response(response)
      page     = response["list_result"]["page"].to_i
      per_page = response["list_result"]["per_page"].to_i
      
      offset   = per_page*(page-1)
      
      response['list_result']['video_list'].each_with_index do |vid, i|
        self[offset+i] = Riddler::Video.new(session, vid)
      end
    end
  end
end
