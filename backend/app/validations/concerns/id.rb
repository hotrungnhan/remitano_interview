# frozen_string_literal: true

module Validations
  module Concerns
    module Id
      class Schema < Dry::Schema::Params
        define do
          required(:id).filled(:string)
        end
        def self.json_schema
          new.json_schema
        end
      end
    end
  end
end
