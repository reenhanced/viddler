require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Riddler::List, "#all" do
  before(:each) do
    @session = mock_session
    @list    = Riddler::List.new(@session, {}, 'viddler.something')
    @list.stub!(:fetch_page)
    
    [1,2,3,4,5].each do |n|
      @list << n
    end
  end
  
  it "should iterate over all elements" do
    arr = []
    @list.all{|item| arr << item}
    
    arr.should == [1,2,3,4,5]
  end
end

describe Riddler::List, "#[]" do
  before(:each) do
    @session = mock_session
    @list    = Riddler::List.new(@session, {}, 'viddler.something')
    @list.stub!(:fetch_page)
    
    [1,2,3,4,5].each do |n|
      @list << n
    end
  end
  
  it "accepts a range" do
    @list[(1..5)].should == [2,3,4,5]
  end
  
  it "accepts a single parameter" do
    @list[3].should == 4
  end
  
  it "accepts 2 parameters" do
    @list[2, 3].should == [3,4,5]
  end
  
  it "fetches the next page if an item is nil" do
    @list.should_receive(:fetch_page).with(2)
    @list[103]
  end
end

describe Riddler::List, "#page" do
  before(:each) do
    @session = mock_session
    @list    = Riddler::List.new(@session, {}, 'viddler.something')
  end
  
  it "calls [] with correct offset and length for default per_page=10" do
    @list.should_receive(:[]).with(20,10)
    @list.page(3)
  end
  
  it "calls [] with correct offset and length for custom per_page" do
    @list.should_receive(:[]).with(24,12)
    @list.page(3, :per_page => 12)
  end
end