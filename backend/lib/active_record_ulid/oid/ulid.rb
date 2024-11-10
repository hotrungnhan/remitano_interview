# frozen_string_literal: true

require_relative '../ulid'

module ActiveRecordULID
  module OID # :nodoc:
    class ULID < ::ActiveRecord::Type::Value # :nodoc:
      # alias serialize deserialize
      def serialize(value)
        value.to_s
      end

      def deserialize(value)
        ActiveRecordULID::ULID.new(value) if value
      end

      def type
        :ulid
      end

      def changed?(old_value, new_value, _new_value_before_type_cast)
        old_value.class != new_value.class ||
          new_value != old_value
      end

      def changed_in_place?(raw_old_value, new_value)
        raw_old_value.class != new_value.class ||
          new_value != raw_old_value
      end

      private

        def cast_value(value)
          value.to_s
        end
    end
  end
end
