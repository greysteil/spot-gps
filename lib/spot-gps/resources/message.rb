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

      def initialize(object, response = nil)
        @object = object

        @id = object.fetch('id')
        @created_at = Time.at(object.fetch('unixTime'))
        @type = object.fetch('messageType')
        @latitude = object.fetch('latitude')
        @longitude = object.fetch('longitude')
        @battery_state = object.fetch('batteryState')

        @hidden = object['hidden'] == 1
        @show_custom_message = object['showCustomMsg'] == "Y"
        @content = object['messageContent']
        @messenger_id = object['messengerId']
        @messenger_name = object['messengerName']
        @messenger_model = object['modelId']

        @response = response
      end

      def response
        @response
      end

      def to_h
        @object
      end
    end
  end
end
