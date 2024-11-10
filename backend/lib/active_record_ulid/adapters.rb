# frozen_string_literal: true

module ActiveRecordULID
  module Adapters
    def load_additional_types(oids = nil)
      type_map.register_type 'ulid', ActiveRecordULID::OID::ULID.new
      super
    end
  end
end
