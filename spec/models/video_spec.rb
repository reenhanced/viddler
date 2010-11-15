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
      "embed_code" => "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"437\" height=\"288\" id=\"viddler_gamervision_1290\"><param name=\"movie\" value=\"http://www.viddler.com/player/73e7156f/\" /><param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"true\" /><embed src=\"http://www.viddler.com/player/73e7156f/\"  wmode=\"transparent\" width=\"437\" height=\"288\" type=\"application/x-shockwave-flash\" allowScriptAccess=\"always\" allowFullScreen=\"true\" name=\"viddler_gamervision_1290\" /></embed></object>",
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
      ],
      "permissions" => {
        "view" => {
          "level" => "public"
        }
      }
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
  
  it "sets embed_code" do
    @video.embed_code.should == "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"437\" height=\"288\" id=\"viddler_gamervision_1290\"><param name=\"movie\" value=\"http://www.viddler.com/player/73e7156f/\" /><param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"true\" /><embed src=\"http://www.viddler.com/player/73e7156f/\"  wmode=\"transparent\" width=\"437\" height=\"288\" type=\"application/x-shockwave-flash\" allowScriptAccess=\"always\" allowFullScreen=\"true\" name=\"viddler_gamervision_1290\" /></embed></object>"
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
    @video.files.should == [
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
  end
  
  it "sets permissions" do
    @video.permissions.should == {
      "view" => {
        "level" => "public"
      }
    }
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

describe Riddler::Video, "#embed_code" do
  before(:each) do
    @embed_code = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"437\" height=\"288\" id=\"viddler_gamervision_1290\"><param name=\"movie\" value=\"http://www.viddler.com/player/73e7156f/\" /><param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowFullScreen\" value=\"true\" /><embed src=\"http://www.viddler.com/player/73e7156f/\"  wmode=\"transparent\" width=\"437\" height=\"288\" type=\"application/x-shockwave-flash\" allowScriptAccess=\"always\" allowFullScreen=\"true\" name=\"viddler_gamervision_1290\" /></embed></object>"
    @session = mock(Riddler::Session)
    @video = Riddler::Video.new(@session, {
      'id' => "598fdc2f",
      'author' => "kyleslat",
      'title' => "Niagara Falls",
      "embed_code" => @embed_code
    })
    
    @video_without_embed_code = Riddler::Video.new(@session, {
      'id' => "598fdc2f",
      'author' => "kyleslat",
      'title' => "Niagara Falls",
    })
  end
  
  it "should return embed_code" do
    @video.embed_code.should == @embed_code
  end
  
  it "should raise ApiError if embed_code is accessed without being set" do
    lambda {@video_without_embed_code.embed_code}.should raise_error(Riddler::Exceptions::ApiError)
  end
end

describe Riddler::Video, ".find_by_username" do
  before(:each) do
    @response = {'a' => 'b'}
    @client   = mock(Riddler::Client, :get => @response)
    @session  = mock(Riddler::Session, :client => @client)
    
    @video_list = mock(Riddler::VideoList)
    Riddler::VideoList.stub!(:new).and_return(@video_list)
  end
  
  it "requires session, username" do
    lambda {Riddler::Video.find_by_username}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "calls GET viddler.videos.getByUser" do
    @client.should_receive(:get).with('viddler.videos.getByUser', hash_including(:user => "kyleslat"))
    Riddler::Video.find_by_username(@session, 'kyleslat')
  end
  
  it "accepts options" do
    lambda {Riddler::Video.find_by_username(@session, 'kyleslat', :per_page => 10)}.should_not raise_error
  end
  
  it "passes options to GET" do
    @client.should_receive(:get).with(anything, hash_including(:a => "b"))
    Riddler::Video.find_by_username(@session, 'kyleslat', :a => "b")
  end
  
  it "calls VideoList.new with response" do
    Riddler::VideoList.should_receive(:new).with(@session, @response)
    Riddler::Video.find_by_username(@session, "kyleslat")
  end
  
  it "returns result of Riddler::VideoList.new" do
    Riddler::Video.find_by_username(@session, "kyleslat").should == @video_list
  end
end

describe Riddler::Video, ".find" do
  before(:each) do
    @response = {
      'video' => {
        "id" => "d773b049",
      }
    }
    @client = mock(Riddler::Client, :get => @response)
    @session = mock(Riddler::Session, :client => @client)
    @video = mock(Riddler::Video)
    Riddler::Video.stub!(:new).and_return(@video)
  end
  
  it "requires session, video_id" do
    lambda {Riddler::Video.find}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "calls GET viddler.videos.getDetails" do
    @client.should_receive(:get).with('viddler.videos.getDetails', hash_including(:video_id => '1234'))
    Riddler::Video.find(@session, '1234')
  end
  
  it "calls Video.new with session and response" do
    Riddler::Video.should_receive(:new).with(@session, @response['video'])
    Riddler::Video.find(@session, '1234')
  end
  
  it "returns result of Riddler::Video.new" do
    Riddler::Video.find(@session, '1234').should == @video
  end
end

describe Riddler::Video, ".find_by_url" do
  before(:each) do
    @response = {
      'video' => {
        "id" => "d773b049",
      }
    }
    @client = mock(Riddler::Client, :get => @response)
    @session = mock(Riddler::Session, :client => @client)
    @video = mock(Riddler::Video)
    Riddler::Video.stub!(:new).and_return(@video)
  end
  
  it "requires session, url" do
    lambda {Riddler::Video.find_by_url}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "calls GET viddler.videos.getDetails" do
    @client.should_receive(:get).with('viddler.videos.getDetails', hash_including(:url => 'http://viddler.com'))
    Riddler::Video.find_by_url(@session, 'http://viddler.com')
  end
  
  it "calls Video.new with session and response" do
    Riddler::Video.should_receive(:new).with(@session, @response['video'])
    Riddler::Video.find_by_url(@session, 'http://viddler.com')
  end
  
  it "returns result of Riddler::Video.new" do
    Riddler::Video.find_by_url(@session, 'http://viddler.com').should == @video
  end
end

describe Riddler::Video, ".get_embed_code" do
  before(:each) do
    @response = {'video' => {'embed_code' => 'waldo'}}
    @client   = mock(Riddler::Client, :get => @response)
    @session  = mock(Riddler::Session, :client => @client)
  end
  
  it "requires session, video_id" do
    lambda {Riddler::Video.get_embed_code}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "calls GET viddler.videos.getEmbedCode" do
    @client.should_receive(:get).with('viddler.videos.getEmbedCode', hash_including(:video_id => '1234'))
    Riddler::Video.get_embed_code(@session, '1234')
  end
  
  it "accepts options" do
    lambda {Riddler::Video.get_embed_code(@session, '1234', :embed_code_type => 3)}.should_not raise_error
  end
  
  it "passes options to GET" do
    @client.should_receive(:get).with(anything, hash_including(:a => 'b'))
    Riddler::Video.get_embed_code(@session, '1234', :a => 'b')
  end
  
  it "returns embed code portion of response" do
    Riddler::Video.get_embed_code(@session, '1234').should == @response['video']['embed_code']
  end
end
