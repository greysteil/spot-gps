require 'spot'
require 'rspec/its'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
end

def fixture_path(filename)
  File.join(File.dirname(__FILE__), "fixtures", filename)
end

def load_fixture(filename)
  File.read(fixture_path(filename))
end
