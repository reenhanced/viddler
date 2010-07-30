require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::Base, "writable api attributes" do
  before(:each) do
    class WritableTestObj < Riddler::Base
      writable_api_attribute :title, :description
    end
    
    @test_obj = WritableTestObj.new
  end
  
  it "should be able to be written" do
    @test_obj.should respond_to(:title=)
    @test_obj.should respond_to(:description=)
  end
  
  it "should be able to be read" do
    @test_obj.should respond_to(:title)
    @test_obj.should respond_to(:description)
  end  
end

describe Riddler::Base, "readable api attributes" do
  before(:each) do
    class ReadableTestObj < Riddler::Base
      readable_api_attribute :title, :description
    end
    
    @test_obj = ReadableTestObj.new
  end
  
  it "should not be able to be written" do
    @test_obj.should_not respond_to(:title=)
    @test_obj.should_not respond_to(:description=)
  end
  
  it "should be able to be read" do
    @test_obj.should respond_to(:title)
    @test_obj.should respond_to(:description)
  end
end

describe Riddler::Base, ".new" do
  before(:each) do
    class NewTestObj < Riddler::Base
      writable_api_attribute :title
      readable_api_attribute :url
    end
  end
  
  it "should set writable attributes" do
    NewTestObj.new(:title => "hello").title.should == "hello"
  end
  
  it "should raise error if trying to set readable attributes" do
    lambda {NewTestObj.new(:url => "http://asdf.com")}.should raise_error(Riddler::Exceptions::Models::ReadOnlyAttributeError, "url is read-only")
  end
end

describe Riddler::Base, ".attributes=" do
  before(:each) do
    class AttributesEqualsTestObj < Riddler::Base
      writable_api_attribute :title, :description
      readable_api_attribute :url
    end
    
    @test_obj = AttributesEqualsTestObj.new
  end
  
  it "should set writable attributes from hash" do
    @test_obj.attributes = {:title => "Title!", :description => "Description!"}
    @test_obj.title.should == "Title!"
    @test_obj.description.should == "Description!"
  end
  
  it "should raise error if trying to set readable attributes by default" do
    lambda {@test_obj.attributes = {:url => "http://asdf.com"}}.should raise_error(Riddler::Exceptions::Models::ReadOnlyAttributeError, "url is read-only")
  end
  
  it "should set readable attributes if `force` is true" do
    @test_obj.send("attributes=", {:url => "http://asdf.com"}, true)
    @test_obj.url.should == "http://asdf.com"
  end
end