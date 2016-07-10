module SPOT
  class ApiResponse
    extend Forwardable

    def_delegator :@response, :headers
    def_delegator :@response, :status
    def_delegator :@response, :status_code

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
        "status: #{@response.status}\n" \
        "headers: #{@response.headers}\n" \
        "body: #{@response.body}"

      raise non_json_msg
    end
  end
end
