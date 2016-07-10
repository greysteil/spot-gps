module SPOT
  module Services
    class Base
      extend Forwardable

      def initialize(api_service)
        @api_service = api_service
      end

      def_delegator :@api_service, :get
    end
  end
end
