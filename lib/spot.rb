require 'json'
require 'rest-client'

require 'spot-gps/version'
require 'spot-gps/configuration'
require 'spot-gps/null_logger'
require 'spot-gps/client'
require 'spot-gps/api_response'
require 'spot-gps/api_service'
require 'spot-gps/list_response'
require 'spot-gps/resources/message'
require 'spot-gps/services/base'
require 'spot-gps/services/messages'

module SPOT
  extend Configuration
end
