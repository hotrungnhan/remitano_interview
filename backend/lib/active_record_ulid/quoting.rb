# frozen_string_literal: true

module ActiveRecordULID
  module Quoting
    extend ::ActiveSupport::Concern

    def quote_default_expression(value, column)
      super

      value if column.type == :ulid && value.is_a?(String) && value.include?('()')
    end
  end
end
