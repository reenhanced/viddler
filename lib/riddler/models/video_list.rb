module Riddler
  class VideoList < Array
    attr_reader :page, :per_page
    
    def initialize(session, response, list_name="videos_list")
      @page     = response["list_result"]["page"].to_i
      @per_page = response["list_result"]["per_page"].to_i
      
      response["list_result"][list_name].each do |vid|
        self.<< Riddler::Video.new(session, vid)
      end
    end
  end
end
