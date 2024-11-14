# frozen_string_literal: true

module Validations
  class ApplicationValidation < Dry::Validation::Contract
    def self.json_schema
      new.schema.json_schema
    end
  end
end
