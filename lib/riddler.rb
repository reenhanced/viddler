$LOAD_PATH.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.setup

require 'rest-client'
require 'json'

require 'riddler/client'
require 'riddler/exceptions'

require 'riddler/models/exceptions'
require 'riddler/models/base'
require 'riddler/models/session'
require 'riddler/models/playlist'