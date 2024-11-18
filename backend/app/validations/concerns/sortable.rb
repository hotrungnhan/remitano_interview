# frozen_string_literal: true

module Validations
  module Concerns
    module Sortable
      class Schema < Dry::Schema::Params
        define do
          optional(:_sort).value(:hash)
        end
        def self.json_schema
          new.json_schema
        end
      end
    end
  end
end
