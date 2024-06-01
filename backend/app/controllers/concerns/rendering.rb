# frozen_string_literal: true

module Concerns
  module Rendering
    def render(args, &block) # rubocop:disable Lint/UnusedMethodArgument
      serializer = args[:serializer] || args[:each_serializer]
      status = args[:status] || 200
      opts = args.slice(:root, :view).reverse_merge(root: :data)
      json = args[:json]
      root = opts[:root]

      rendered_body = serializer.present? ? serializer.render(json, **opts) : ::MultiJson.dump(root => json)

      self.status = status
      self.response_body = rendered_body
    end
  end
end
