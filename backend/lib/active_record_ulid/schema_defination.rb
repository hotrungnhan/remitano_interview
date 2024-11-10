# frozen_string_literal: true

module ActiveRecordULID
  module ColumnMethods
    extend ::ActiveSupport::Concern

    included do
      define_column_methods :ulid
    end

    def primary_key(name, type = :primary_key, **options)
      options[:default] = options.fetch(:default, 'gen_ulid()') if type == :ulid

      super
    end
  end
end
