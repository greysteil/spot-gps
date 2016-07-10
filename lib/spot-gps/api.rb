module SPOT
  class API
    attr_reader :feed_id, :feed_password

    def initialize(feed_id: nil, feed_password: nil)
      raise ArgumentError, "feed_id is required" unless feed_id

      @api_service = ApiService.new(feed_id: feed_id, feed_password: feed_password)
    end

    def messages
      @messages ||= Services::Messages.new(@api_service)
    end
  end
end
