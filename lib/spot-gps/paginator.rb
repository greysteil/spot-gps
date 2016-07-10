module SPOT
  # A class that can take an API LIST query and auto paginate through results
  class Paginator
    def initialize(service:, resource_class:, path:, params: {})
      @service = service
      @resource_class = resource_class
      @path = path
      @params = (params || {}).dup
    end

    # Get a lazy enumerable for listing data from the API
    def enumerator
      response = get_initial_response
      Enumerator.new do |yielder|
        loop do
          items = SPOT::ListResponse.new(
            response: response,
            resource_class: @resource_class,
            unenveloped_body: @service.unenvelope_body(response.body)
          ).records

          # If there are no records, we're done
          break if items.empty?

          # Otherwise, iterate through the records...
          items.each { |item| yielder << item }

          # ...and fetch the next page
          @params ||= {}
          @params[:page] ||= 1
          @params[:page] += 1

          response = @service.get(path: @path, params: @params)
        end
      end.lazy
    end

    private

    def get_initial_response
      @initial_response ||= @service.get(path: @path, params: @params)
    end
  end
end
