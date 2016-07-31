module SPOT
  module Resources
    class Message
      attr_reader :id
      attr_reader :created_at
      attr_reader :type
      attr_reader :latitude
      attr_reader :longitude
      attr_reader :battery_state
      attr_reader :hidden
      attr_reader :show_custom_message
      attr_reader :content
      attr_reader :messenger_id
      attr_reader :messenger_name
      attr_reader :messenger_model

      attr_reader :response

      def initialize(object, response = nil)
        @id = object.fetch('id')
        @created_at = Time.at(object.fetch('unixTime'))
        @type = object.fetch('messageType')
        @latitude = object.fetch('latitude')
        @longitude = object.fetch('longitude')
        @battery_state = object.fetch('batteryState')
        @hidden = object.fetch('hidden') == 1
        @show_custom_message = object.fetch('showCustomMsg') == "Y"
        @content = object.fetch('messageContent', nil)
        @messenger_id = object.fetch('messengerId')
        @messenger_name = object.fetch('messengerName')
        @messenger_model = object.fetch('modelId')

        @object = object
        @response = response
      end

      def to_h
        @hash ||=
          begin
            attribute_ivars =
              (instance_variables - [:@response, :@object, :@hash])

            attribute_ivars.each_with_object({}) do |ivar, hash|
              hash[ivar.to_s.delete('@').to_sym] = instance_variable_get(ivar)
            end
          end
      end

      def to_raw_h
        @object
      end

      def inspect
        attr_list =
          to_h.map { |key, value| "#{key}: #{value.inspect}" }.join(', ')

        "#<#{self.class} #{attr_list}>"
      end
    end
  end
end
