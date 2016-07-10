module SPOT
  class ApiResponse
    extend Forwardable

    def initialize(response)
      @response = response
    end

    # Return the body of the API response
    def body
      json? ? handle_json : handle_raw
    end

    # Returns true if the response is JSON
    def json?
      content_type = @response.headers[:content_type] || ''
      content_type.include?('application/json')
    end

    private

    def raw_body
      @response.body
    end

    def handle_json
      @json_body ||= JSON.parse(@response.body)
    end

    def handle_raw
      non_json_msg = "Received non-JSON response:\n\n" \
                     "#{@response.body}"

      raise non_json_msg
    end
  end
end
