# frozen_string_literal: true

module Validations
  class ApplicationValidation < ::Dry::Schema::Params
    def self.json_schema
      new.json_schema
    end
  end
end
