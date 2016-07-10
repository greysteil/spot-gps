module SPOT
  class ListResponse
    attr_reader :records

    def initialize(response:, resource_class:, unenveloped_body:)
      @response = response
      @resource_class = resource_class
      @unenveloped_body = unenveloped_body

      # SPOT returns a Hash, rather than an array of hashes, if there is only
      # a single record.
      @unenveloped_body = [@unenveloped_body] if @unenveloped_body.is_a?(Hash)

      @records = @unenveloped_body.map do |item|
        @resource_class.new(item)
      end
    end
  end
end
