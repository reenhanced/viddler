require 'rest_client'
require 'riddler/client'

module Riddler
  V2_METHODS = [
    'viddler.api.getInfo',
    'viddler.users.auth',
    'viddler.users.getProfile',
    'viddler.users.getFriends'
  ]
end