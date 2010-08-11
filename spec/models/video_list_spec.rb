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
        
        "videos_list" => [@video1_response, @video2_response]
      }
    }
    
    Riddler::Video.stub!(:new)
    @video_list = Riddler::VideoList.new(@session, @response)
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
        
        "videos_list" => [@video1_response, @video2_response]
      }
    }
    
    @video1 = mock(Riddler::Video)
    @video2 = mock(Riddler::Video)
    
    Riddler::Video.stub!(:new).and_return(@video1, @video2, nil)
    
    @session = mock(Riddler::Session)
    
    @video_list = Riddler::VideoList.new(@session, @response)
  end
  
  it "should set page" do
    @video_list.page.should == 2
  end
  
  it "should set per_page" do
    @video_list.per_page.should == 10
  end
  
  it "should contain videos at correct indices" do
    @video_list[0].should == @video1
    @video_list[1].should == @video2
  end
  
  it "should call Riddler::Video.new with each video" do
    Riddler::Video.should_receive(:new).with(@session, @video1_response).once
    Riddler::Video.should_receive(:new).with(@session, @video2_response).once
    Riddler::VideoList.new(@session, @response)
  end
  
  it "accepts video list parameter" do
    lambda {Riddler::VideoList.new(@session, @response, 'video_list')}.should_not raise_error(ArgumentError)
  end
  
  it "uses the video_list parameter to find list of videos" do
    @response['list_result']['some_crazy_name'] = @response['list_result'].delete('videos_list')
    Riddler::Video.stub!(:new).and_return(@video1, @video2, nil)
    video_list = Riddler::VideoList.new(@session, @response, 'some_crazy_name')
    video_list[0].should == @video1
    video_list[1].should == @video2
  end
end