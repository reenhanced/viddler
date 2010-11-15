require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::VideoList, "methods" do
  before(:each) do
    @session = mock(Riddler::Session)
    @video1_response = {
      "id" => "video1",
      "title" => "Video 1"
    }
    
    @video2_response = {
      "id" => "video2",
      "title" => "Video 2"
    }
    
    @response = {
      "list_result" => {
        "page" => "2",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "My new playlist",
          "type" => "regular"
        },
        
        "video_list" => [@video1_response, @video2_response]
      }
    }
    
    Riddler::Video.stub!(:new)
    @video_list = Riddler::VideoList.new(@session, @response, 'viddler.videos.getByUser')
  end
  
  it "responds to []" do
    @video_list.should respond_to(:[])
  end
  
  it "responds to each" do
    @video_list.should respond_to(:each)
  end
  
  it "does not respond to <<" do
    pending
    @video_list.should_not respond_to(:<<)
  end
  
  it "does not respond to []=" do
    pending
    @video_list.should_not respond_to(:[]=)
  end
end

describe Riddler::VideoList, ".new" do
  before(:each) do
    @video1_response = {
      "id" => "video1",
      "title" => "Video 1"
    }
    
    @video2_response = {
      "id" => "video2",
      "title" => "Video 2"
    }
    
    @response = {
      "list_result" => {
        "page" => "2",
        "per_page" => "10",
        "playlist" => {
          "id" => "abc123",
          "name" => "My new playlist",
          "type" => "regular"
        },
        
        "video_list" => [@video1_response, @video2_response]
      }
    }
    
    @video1 = mock(Riddler::Video)
    @video2 = mock(Riddler::Video)
    
    Riddler::Video.stub!(:new).and_return(@video1, @video2, nil)
    
    @session = mock(Riddler::Session)
    
    @video_list = Riddler::VideoList.new(@session, @response, 'viddler.videos.getByUser', {:user => 'kyleslat'})
  end
  
  it "should contain videos at correct indices" do
    @video_list[10].should == @video1
    @video_list[11].should == @video2
  end
  
  it "should call Riddler::Video.new with each video" do
    Riddler::Video.should_receive(:new).with(@session, @video1_response).once
    Riddler::Video.should_receive(:new).with(@session, @video2_response).once
    Riddler::VideoList.new(@session, @response, 'viddler.videos.getByUser')
  end
  
  it "sets list_method" do
    @video_list.list_method.should == 'viddler.videos.getByUser'
  end
  
  it "sets list_method_options" do
    @video_list.list_method_options.should == {:user => 'kyleslat'}
  end
end

describe Riddler::VideoList, "#each" do
  before(:each) do
    @session = mock_session
    # @video_list = Riddler::VideoList.new(@session)
  end
  
  it "yields all videos" do
    pending
  end
  
  it "calls API if video doesn't exist yet" do
    pending
  end
end