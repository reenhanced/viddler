require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::Video, ".new" do
  before(:each) do
    @response = {
      "id" => "73e7156f",
      "status" => "ready",
      "author" => "jhammer",
      "title" => "t",
      "length" => "11",
      "description" => "t\n",
      "url" => "http://www.viddler.com/explore/jhammer/videos/262/",
      "thumbnail_url" => "http://cdn-thumbs.viddler.com/thumbnail_2_73e7156f_v1.jpg",
      "permalink" => "http://www.viddler.com/explore/jhammer/videos/262/",
      "html5_video_source" => "http://www.viddler.com/file/73e7156f/html5",
      "view_count" => "69",
      "upload_time" => "1276693288",
      "made_public_time" => "1276661136",
      "favorite" => "0",
      "comment_count" => "0",
      "files" => [
        {
          "id" => "728a0c5f4621e1ee",
          "status" => "ready",
          "ext" => "avi",
          "type" => "video/x-msvideo",
          "width" => "720",
          "height" => "480",
          "size" => "7782400",
          "url" => "http://www.viddler.com/explore/jhammer/videos/262.avi?vfid=728a0c5f4621e1ee",
          "html5_video_source" => "",
          "source" => "1",
          "flash" => "na",
          "iphone" =>"na",
          "ipad" => "na",
          "itunes" => "na"
        },
        {
          "id" => "728a0c5f4620e1ee",
          "status" => "ready",
          "ext" =>"flv",
          "type" => "video/x-flv",
          "width" => "640",
          "height" => "426",
          "size" => "704696",
          "url" => "http://www.viddler.com/explore/jhammer/videos/262.flv?vfid=728a0c5f4620e1ee",
          "html5_video_source" => "",
          "source" => "0",
          "flash" => "on",
          "iphone" => "na",
          "ipad" => "na",
          "itunes" => "na",
          "profile_id" => "1"
        },
      ]
    }
    
    @session = mock(Riddler::Session)
    @video   = Riddler::Video.new(@session, @response)
  end
  
  it "requires a session and attributes" do
    lambda {Riddler::Video.new}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "sets id" do
    @video.id.should == "73e7156f"
  end
  
  it "sets status" do
    @video.status.should == "ready"
  end
  
  it "sets author" do
    @video.author.should == 'jhammer'
  end
  
  it "sets title" do
    @video.title.should == "t"
  end
  
  it "sets length" do
    @video.length.should == 11
  end
  
  it "sets description" do
    @video.description.should == "t\n"
  end
  
  it "sets url" do
    @video.url.should == "http://www.viddler.com/explore/jhammer/videos/262/"
  end
  
  it "sets thumbnail_url" do
    @video.thumbnail_url.should == "http://cdn-thumbs.viddler.com/thumbnail_2_73e7156f_v1.jpg"
  end
  
  it "sets permalink" do
    @video.permalink.should == "http://www.viddler.com/explore/jhammer/videos/262/"
  end
  
  it "sets html5_video_source" do
    @video.html5_video_source.should == "http://www.viddler.com/file/73e7156f/html5"
  end
  
  it "sets view_count" do
    @video.view_count.should == 69
  end
  
  it "sets uploaded_at" do
    @video.uploaded_at.should == Time.at(1276693288)
  end
  
  it "sets made_public_time" do
    @video.made_public_at.should == Time.at(1276661136)
  end
  
  it "sets is_favorite?" do
    @video.is_favorite?.should be_false
  end
  
  it "sets comment_count" do
    @video.comment_count.should == 0
  end
  
  it "sets files" do
    pending
  end
end

describe Riddler::Video, "#thumbnail_url" do
  before(:each) do
    @original_thumbnail_url = 'http://cdn-thumbs.viddler.com/thumbnail_2_598fdc2f_v2.jpg'
    @medium_thumbnail_url   = 'http://cdn-thumbs.viddler.com/thumbnail_1_598fdc2f_v2.jpg'
    @small_thumbnail_url    = 'http://cdn-thumbs.viddler.com/thumbnail_0_598fdc2f_v2.jpg'
    
    @session = mock(Riddler::Session)
    
    @video = Riddler::Video.new(@session, {
      'id' => "598fdc2f",
      'author' => "kyleslat",
      'title' => "Niagara Falls",
      'thumbnail_url' => @original_thumbnail_url
    })
  end
  
  it "should return thumbnail url" do
    @video.thumbnail_url.should == @original_thumbnail_url
  end
  
  it "should return medium thumbnail url" do
    @video.thumbnail_url(:medium).should == @medium_thumbnail_url
  end

  it "should return small thumbnail url" do
    @video.thumbnail_url(:small).should == @small_thumbnail_url
  end
  
  it "should return original thumbnail if invalid size supplied" do
    @video.thumbnail_url(:shrubbery).should == @original_thumbnail_url
  end
end