# https://gist.github.com/marekciupak/05c86dd0b5e9cd20a859a231364cb466
# frozen_string_literal: true

module Concerns
  module Validator
    extend ActiveSupport::Concern
    included do
      before_action :init_validations
      def init_validations
        @validations = {}
      end

      def validate_params!(schema)
        result = get_validation_instance(schema).call(params)
        if result.failure?
          raise Errors::Validation.new(result.errors.to_h.map do |k, v| # rubocop:disable Style/RaiseArgs,Rails/DeprecatedActiveModelErrorsMethods
            {
              field: k,
              messages: v
            }
          end)
        end
        @meta[:params] = result.to_h unless @meta.nil?
        result.to_h
      end

      def with_validated_params!(schema)
        result = validate_params!(schema)
        yield result.to_h
      end

      private

        def get_validation_instance(class_or_instance)
          return class_or_instance unless class_or_instance.is_a?(Class)
          return @validations[class_or_instance] if @validations.key?(class_or_instance)

          @validations[class_or_instance] = class_or_instance.new
        end
    end
  end
end
