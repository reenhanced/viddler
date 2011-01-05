require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::User, ".new" do
  before(:each) do
    @response = {
      "user" => {
        "username" => "kyleslat",
        "first_name" => "Kyle",
        "last_name" => "Slattery",
        "about_me" => "Some about me",
        "avatar" => "http://myavatar.com/image.jpg",
        "age" => "99",
        "video_upload_count" => "50",
        "video_watch_count" => "111",
        "homepage" => "http://www.viddler.com",
        "gender" => "m",
        "company" => "Viddler",
        "city" => "Bethlehem, PA",
        "friend_count" => "200",
        "favourite_video_count" => "1999",
        "email" => "kyle@viddler.com"
      }
    }
    
    @client  = mock(Riddler::Client, :get => @response)
    @session = mock(Riddler::Session, :client => @client)
    
    @user = Riddler::User.new(@session, @response)
  end
  
  it "requires session and response" do
    lambda {Riddler::User.new}.should raise_error(ArgumentError, /0 for 2/)
  end
  
  it "sets raw_response" do
    @user.raw_response.should == @response['user']
  end
  
  it "sets username" do
    @user.username.should == "kyleslat"
  end
  
  it "sets first_name" do
    @user.first_name.should == "Kyle"
  end
  
  it "sets last_name" do
    @user.last_name.should == "Slattery"
  end
  
  it "sets about_me" do
    @user.about_me.should == "Some about me"
  end
  
  it "sets avatar" do
    @user.avatar.should == "http://myavatar.com/image.jpg"
  end
  
  it "sets age" do
    @user.age.should == 99
  end
  
  it "sets video_upload_count" do
    @user.video_upload_count.should == 50
  end
  
  it "sets video_watch_count" do
    @user.video_watch_count.should == 111
  end
  
  it "sets homepage" do
    @user.homepage.should == "http://www.viddler.com"
  end
  
  it "sets gender" do
    @user.gender.should == "m"
  end
  
  it "sets company" do
    @user.company.should == "Viddler"
  end
  
  it "sets city" do
    @user.city.should == "Bethlehem, PA"
  end
  
  it "sets friend_count" do
    @user.friend_count.should == 200
  end
  
  it "sets favourite_video_count" do
    @user.favourite_video_count.should == 1999
  end
  
  it "sets email" do
    @user.email.should == "kyle@viddler.com"
  end
  
  context "with no user node" do
    before(:each) do
      @response = @response['user']
      @user = Riddler::User.new(@session, @response)
    end
    
    it "sets username" do
      @user.username.should == "kyleslat"
    end

    it "sets first_name" do
      @user.first_name.should == "Kyle"
    end

    it "sets last_name" do
      @user.last_name.should == "Slattery"
    end

    it "sets about_me" do
      @user.about_me.should == "Some about me"
    end

    it "sets avatar" do
      @user.avatar.should == "http://myavatar.com/image.jpg"
    end

    it "sets age" do
      @user.age.should == 99
    end

    it "sets video_upload_count" do
      @user.video_upload_count.should == 50
    end

    it "sets video_watch_count" do
      @user.video_watch_count.should == 111
    end

    it "sets homepage" do
      @user.homepage.should == "http://www.viddler.com"
    end

    it "sets gender" do
      @user.gender.should == "m"
    end

    it "sets company" do
      @user.company.should == "Viddler"
    end

    it "sets city" do
      @user.city.should == "Bethlehem, PA"
    end

    it "sets friend_count" do
      @user.friend_count.should == 200
    end

    it "sets favourite_video_count" do
      @user.favourite_video_count.should == 1999
    end
  end
end

describe Riddler::User, "#videos" do
  before(:each) do
    @session = mock_session
    
    @response = {
      "user" => {
        "username" => "kyleslat",
        "first_name" => "Kyle",
        "last_name" => "Slattery",
        "about_me" => "Some about me",
        "avatar" => "http://myavatar.com/image.jpg",
        "age" => "99",
        "video_upload_count" => "50",
        "video_watch_count" => "111",
        "homepage" => "http://www.viddler.com",
        "gender" => "m",
        "company" => "Viddler",
        "city" => "Bethlehem, PA",
        "friend_count" => "200",
        "favourite_video_count" => "1999",
        "email" => "kyle@viddler.com"
      }
    }
    
    @user = Riddler::User.new(@session, @response)
    @video_list = mock(Riddler::VideoList)
    Riddler::VideoList.stub!(:new).and_return(@video_list)
  end
  
  it "calls Riddler::VideoList.new with proper arguments on first call" do
    Riddler::VideoList.should_receive(:new).with(@session, {}, 'viddler.videos.getByUser', hash_including(:user => 'kyleslat'))
    @user.videos
  end
  
  it "does not call VideoList.new on second call" do
    @user.videos
    Riddler::VideoList.should_not_receive(:new)
    @user.videos
  end
  
  it "returns result of Riddler::VideoList.new" do
    @user.videos.should == @video_list
  end
  
  it "passes any options along" do
    Riddler::VideoList.should_receive(:new).with(anything, anything, anything, hash_including(:pageasdf => 10))
    @user.videos(:pageasdf => 10)
  end
  
  it "prepopulates if page is given"
end

describe Riddler::User, "#playlists" do
  before(:each) do
    @session = mock_session
    @user    = Riddler::User.new(@session, 'username' => 'kyleslat')
  end
  
  it "does the same things as VideoList"
end