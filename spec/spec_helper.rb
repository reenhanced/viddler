require 'rubygems'
require 'spec'
require 'spec/autorun'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'riddler'

def mock_session
  @client = mock(Riddler::Client)
  @session = mock(Riddler::Session, :client => @client)
end
