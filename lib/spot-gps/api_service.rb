require 'uri'
require 'base64'

module SPOT
  class ApiService
    def initialize(feed_id:, feed_password: nil)
      @feed_id = feed_id
      @feed_password = feed_password

      connection_options = {
        request: {
          timeout: SPOT.read_timeout,
          open_timeout: SPOT.open_timeout
        }
      }

      @connection =
        Faraday.new(base_uri, connection_options) do |f|
          f.adapter Faraday::Adapter::NetHttp
        end
    end

    # Make a GET request to the SPOT API
    def get(path:, params: {})
      params ||= {}

      if feed_password && !feed_password.empty?
        params = params.merge(feedPassword: feed_password)
      end

      response = make_request(:get, path, params)

      SPOT::ApiResponse.new(response)
    end

    private

    attr_reader :feed_id, :feed_password

    def make_request(method, path, params = {})
      @connection.send(method.to_sym) do |request|
        request.url path
        request.body = @request_body
        request.params = params
        request.headers = headers
      end
    end

    def base_uri
      URI.join(SPOT.endpoint, feed_id + '/')
    end

    def headers
      { 'Accept' => "application/json" }
    end
  end
end
