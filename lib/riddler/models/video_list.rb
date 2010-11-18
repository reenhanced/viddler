module Riddler
  class VideoList < List
    def initialize(session, response, list_method, list_method_options={})
      super session, list_method, list_method_options
      
      return if response.empty?
      
      insert_response(response)
    end
    
    def parse(response)
      arr = []
      
      response['list_result']['video_list'].each do |vid|
        arr << Riddler::Video.new(session, vid)
      end
      
      return arr
    end
  end
end
