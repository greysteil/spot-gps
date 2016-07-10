require 'spot'
require 'rspec/its'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
end
