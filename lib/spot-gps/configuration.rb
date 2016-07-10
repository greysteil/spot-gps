module SPOT
  module Configuration
    attr_accessor :open_timeout, :read_timeout

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.open_timeout = 30
      self.read_timeout = 80
    end

    def endpoint
      "https://api.findmespot.com/spot-main-web/consumer/rest-api/2.0/public/feed/"
    end
  end
end
