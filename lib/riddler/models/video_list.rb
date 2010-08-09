module Riddler
  class VideoList < Array
    attr_reader :page, :per_page
    
    def initialize(session, response)
      @page     = response["list_result"]["page"].to_i
      @per_page = response["list_result"]["per_page"].to_i
      
      response["list_result"]["videos_list"].each do |vid|
        self.<< Riddler::Video.new(session, vid)
      end
    end
  end
end
