module Riddler
  class VideoList < Array
    attr_accessor :list_method, :list_method_options, :session
    
    def initialize(session, response, list_method, list_method_options={})
      @session             = session
      @list_method         = list_method
      @list_method_options = list_method_options
      
      return if response.empty?
      
      insert_response(response)
    end
    
    def each
      i = 0
      keep_going = true
      
      while keep_going
        fetch_page(i/100+1) if self[i].nil?
        
        if self[i].nil?
          keep_going = false
        else
          yield self[i]
          i += 1
        end
      end
    end
    
    def [](start, length=1)
      if start.is_a?(Range)
        length = start.end - start.begin + 1
        start  = start.begin
      end
      
      i   = start
      arr = []
      
      length.times do
        fetch_page(i/100+1) if super(i).nil?
        arr << super(i) unless super(i).nil?
        i += 1
      end
      
      if length == 1
        return arr[0]
      else
        return arr
      end
    end
    
    def slice(start, length=1)
      self.[](start, length)
    end
    
    private
    
    def fetch_page(page)
      insert_response(session.client.get(list_method, list_method_options.merge(:page => page, :per_page => 100)))
    end
    
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
