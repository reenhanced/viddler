module Riddler
  class Video
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
    
    def is_favorite?
      @favorited == 1
    end
  end
end
