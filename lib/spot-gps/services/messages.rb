module SPOT
  module Services
    class Messages < Base
      def list(page: nil, start_at: nil, end_at: nil)
        query_params = {}
        query_params[:start] = start(page) if page
        query_params[:startDate] = spot_formatted_time(start_at) if start_at
        query_params[:endDate] = spot_formatted_time(end_at) if end_at

        response = get(path: "message.json", params: query_params)

        SPOT::ListResponse.new(
          response: response,
          resource_class: SPOT::Resources::Message,
          unenveloped_body: unenvelope_body(response.body)
        )
      end

      def latest
        response = get(path: "latest.json")
        Resources::Message.new(unenvelope_body(response.body), response)
      end

      def unenvelope_body(body)
        body.dig("response", "feedMessageResponse", "messages", "message")
      end

      private

      def spot_formatted_time(time)
        time = Time.parse(time) if time.is_a?(String)
        time = time.to_time if time.is_a?(Date) || time.is_a?(DateTime)

        time.gmtime.strftime('%FT%T') + "-0000"
      end

      def start(page)
        raise ArgumentError, "page must be an integer" unless page.is_a?(Integer)
        raise ArgumentError, "page must be positive" unless page > 0

        # SPOT start param is zero-indexed
        (page - 1) * 50
      end
    end
  end
end
