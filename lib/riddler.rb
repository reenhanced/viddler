$LOAD_PATH.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.setup

require 'httparty'

require 'riddler/client'
require 'riddler/playlists'
require 'riddler/exceptions'