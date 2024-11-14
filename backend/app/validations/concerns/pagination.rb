# frozen_string_literal: true

module Validations
  module Concerns
    module Pagination
      class Schema < Dry::Schema::Params
        define do
          optional(:limit).value(:integer, gt?: 0, lteq?: 100).default(10)
          optional(:page).value(:integer, gt?: 0).default(1)
        end
        def self.json_schema
          new.json_schema
        end
      end
    end
  end
end
