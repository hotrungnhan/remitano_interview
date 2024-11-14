# frozen_string_literal: true

module Errors
  class Validation < ApplicationError
    # details: {field: string, messages: string}
    attr_reader :details

    def initialize(details)
      super('Params Invalid',
      status_code: 400,
      code: 'INPUT_PARAMS',
      type: 'VALIDATION',
      description: 'Input Params Validation Error',
      details: details
      )
    end
  end
end
