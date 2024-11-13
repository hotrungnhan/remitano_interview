# https://gist.github.com/marekciupak/05c86dd0b5e9cd20a859a231364cb466
# frozen_string_literal: true

module Concerns
  module Validator
    extend ActiveSupport::Concern
    included do
      def initialize
        @validations = {}
      end

      def validate_params!(schema)
        result = get_validation_instance(schema).call(params)

        result.to_h
      end

      def with_validated_params!(schema)
        result = get_validation_instance(schema).call(params)

        return yield result.to_h if result.success?

        render_validation_error(result)
      end

      private

        def render_validation_error(result)
          raise Errors::Base.new('Invalid HTTP parameters.', error_code_data: result.errors.to_h) # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods
        end

        def get_validation_instance(class_or_instance)
          return class_or_instance unless class_or_instance.is_a?(Class)
          return @validations[class_or_instance] if @validations.key?(class_or_instance)

          @validations[class_or_instance] = class_or_instance.new
        end
    end
  end
end
