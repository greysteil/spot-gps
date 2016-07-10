module SPOT
  # A class that can take an API LIST query and auto paginate through results
  class Paginator
    def initialize(service:, params: {})
      @service = service
      @params = (params || {}).dup
    end

    # Get a lazy enumerable for listing data from the API
    def enumerator
      Enumerator.new do |yielder|
        response = get_initial_response

        loop do
          items = response.records

          # If there are no records, we're done
          break if items.empty?

          # Otherwise, iterate through the records...
          items.each { |item| yielder << item }

          # ...and fetch the next page
          @params ||= {}
          @params[:page] ||= 1
          @params[:page] += 1

          response = @service.list(**@params)
        end
      end.lazy
    end

    private

    def get_initial_response
      @initial_response ||= @service.list(**@params)
    end
  end
end
