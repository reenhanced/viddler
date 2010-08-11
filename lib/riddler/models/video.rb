module Riddler
  class Video
    DEFAULT_THUMBNAIL_URL = 'http://cdn-thumbs.viddler.com/images/videothmb.gif'
    THUMBNAIL_DIMENSIONS  = [[76, 56], [114, 86]]
    THUMBNAIL_SIZES       = [:small, :medium, :original]
    
    attr_reader :id, :status, :author, :title, :length, :description, :url,
                :thumbnail_url, :permalink, :html5_video_source, :view_count,
                :comment_count, :uploaded_at, :made_public_at
    
    def initialize(session, response)
      @id                 = response["id"]
      @status             = response["status"]
      @author             = response["author"]
      @title              = response["title"]
      @length             = response["length"].to_i
      @description        = response["description"]
      @url                = response["url"]
      @thumbnail_url      = response["thumbnail_url"]
      @permalink          = response["permalink"]
      @html5_video_source = response["html5_video_source"]
      @view_count         = response["view_count"].to_i
      @comment_count      = response["comment_count"].to_i
      @favorited          = response["favorite"].to_i
      @uploaded_at        = Time.at(response["upload_time"].to_i)
      @made_public_at     = Time.at(response["made_public_time"].to_i)
    end
    
    def self.find_by_username(session, username, options={})
      response = session.client.get("viddler.videos.getByUser", options.merge(:user => username))
      Riddler::VideoList.new(session, response, 'video_list')
    end
    
    def is_favorite?
      @favorited == 1
    end
    
    def thumbnail_url(size = nil)
      url = @thumbnail_url || DEFAULT_THUMBNAIL_URL

      if THUMBNAIL_SIZES.include?(size)
        url.gsub!(/_[0-9]_/, "_#{THUMBNAIL_SIZES.rindex(size)}_")
      end
      url
    end
  end
end
