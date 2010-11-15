module Riddler
  class VideoList < Array
    def initialize(session, response)
      page     = response["list_result"]["page"].to_i
      per_page = response["list_result"]["per_page"].to_i
      
      offset   = per_page*(page-1)
      
      response['list_result']['video_list'].each_with_index do |vid, i|
        self[offset+i] = Riddler::Video.new(session, vid)
      end
    end
  end
end
