# frozen_string_literal: true

module Concerns
  module Rendering
    extend ActiveSupport::Concern
    included do
      def render(args, &block) # rubocop:disable Lint/UnusedMethodArgument
        serializer = args[:serializer] || args[:each_serializer]
        status = args[:status] || 200
        opts = args.slice(:root, :view)
        json = args[:json]
        root = opts[:root]

        rendered_body = if serializer.nil? || json.nil?
                          ::MultiJson.dump(root.present? ? { root => json } : json)
                        else
                          serializer.render_as_json(json, **opts).to_json
                        end

        self.status = status
        self.response_body = rendered_body
      end
    end
  end
end
