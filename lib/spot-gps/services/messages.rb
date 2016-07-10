module SPOT
  module Services
    class Messages < Base
      def all(page: nil, start_at: nil, end_at: nil)
        query_params = {}
        query_params[:start] = start(page) if page
        query_params[:startDate] = spot_formatted_time(start_at) if start_at
        query_params[:endDate] = spot_formatted_time(end_at) if end_at

        get(path: "message.json", params: query_params)
      end

      def latest
        get(path: "latest.json")
      end

      private

      def spot_formatted_time(time)
        return nil unless time
        time = Time.parse(time) if time.is_a?(String)
        time = time.to_time if time.is_a?(Date) || time.is_a?(DateTime)

        time.gmtime.strftime('%FT%T') + "-0000"
      end

      def start(page)
        return nil unless page
        raise ArgumentError, "page must be an integer" unless page.is_a?(Integer)
        raise ArgumentError, "page must be non-negative" if page < 0

        # SPOT start param is zero-indexed
        (page - 1) * 50
      end
    end
  end
end
