require 'uri'
require 'base64'

module SPOT
  class ApiService
    def initialize(feed_id:, feed_password: nil)
      @feed_id = feed_id
      @feed_password = feed_password
    end

    # Make a GET request to the SPOT API
    def get(path:, params: {})
      params ||= {}
      params = params.merge(feedPassword: feed_password) if feed_password

      uri = URI.join(base_uri, path)
      uri.query = URI.encode_www_form(params) if params.any?

      request_options = {
        url: uri.to_s,
        method: :get,
        headers: headers,
        open_timeout: SPOT.open_timeout,
        timeout: SPOT.read_timeout
      }

      response = RestClient::Request.execute(request_options)

      SPOT::ApiResponse.new(response)
    end

    private

    attr_reader :feed_id, :feed_password

    def base_uri
      URI.join(SPOT.endpoint, feed_id + '/')
    end

    def headers
      { 'Accept' => "application/json" }
    end
  end
end
