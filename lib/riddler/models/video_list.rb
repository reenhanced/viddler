module Riddler
  class VideoList < Array
    attr_accessor :list_method, :list_method_options, :session
    
    def initialize(session, response, list_method, list_method_options={})
      @session             = session
      @list_method         = list_method
      @list_method_options = list_method_options
      
      return if response.empty?
      
      page     = response["list_result"]["page"].to_i
      per_page = response["list_result"]["per_page"].to_i
      
      offset   = per_page*(page-1)
      
      response['list_result']['video_list'].each_with_index do |vid, i|
        self[offset+i] = Riddler::Video.new(session, vid)
      end
    end
  end
end
