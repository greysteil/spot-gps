module SPOT
  class API
    attr_reader :feed_id, :feed_password

    def initialize(feed_id:, feed_password: nil)
      @api_service = ApiService.new(feed_id: feed_id, feed_password: feed_password)
    end

    def messages
      @messages ||= Services::Messages.new(@api_service)
    end
  end
end
