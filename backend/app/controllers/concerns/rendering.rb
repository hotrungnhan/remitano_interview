# frozen_string_literal: true

module Concerns
  module Rendering
    extend ActiveSupport::Concern
    included do
      # Custom `render` method to handle rendering JSON responses
      #
      # Arguments:
      # args [Hash]: A hash containing the parameters for rendering the response.
      #   - :serializer [Class, nil]: The serializer class used to format the `json` object.
      #   - :each_serializer [Class, nil]: A serializer to use for an array of objects (alternative to :serializer).
      #   - :status [Integer, nil]: The HTTP status code for the response (defaults to 200).
      #   - :json [Object]: The data to be rendered in the response body. Can be a hash, array, or any object that can be serialized.
      #   - :root [String, nil]: The root key for wrapping the response data in a hash.
      #   - :view [String, nil]: The root key for wrapping the response data in a hash.
      #   - **rest_opts [Hash]: Any additional options to pass to the `Blueprinter#render` method.
      # Block Parameters:
      #   The method also accepts an optional block that can be passed to the `serializer.render` method.
      def render(args, &block) # rubocop:disable Lint/UnusedMethodArgument
        serializer = args[:serializer] || args[:each_serializer]
        status = args[:status] || 200
        json = args[:json]
        root = args[:root]

        rest_opts = args.except(:serializer, :each_serializer, :status, :json)
        rendered_body = if serializer.present?
                          serializer.render(json,
                                            **rest_opts, root: root || :data)
                        else
                          ::MultiJson.dump(root.present? ? { root => json } : json)
                        end
        self.content_type = 'application/json'
        self.status = status
        self.response_body = rendered_body
      end
    end
  end
end
