# frozen_string_literal: true

module Errors
  class ApplicationError < StandardError
    attr_reader :error_code_id, :error_code_data

    def initialize(msg = '', error_code_id: nil, error_code_data: nil)
      @error_code_id = error_code_id
      @error_code_data = error_code_data
      super(msg)
    end
  end
end
