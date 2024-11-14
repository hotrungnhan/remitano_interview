# frozen_string_literal: true

module Errors
  class ApplicationError < StandardError
    attr_reader :status_code, :code, :type, :description, :details

    TYPE = {
      UNCATEGORY: 'UNCATEGORY',
      VALIDATION: 'VALIDATION',
      INTERNAL_OPERATION: 'INTERNAL_OPERATION',
      THIRD_PARTY: 'THIRD_PARTY',
      DATABASE_VALIDATION: 'DATABASE_VALIDATION',
      DATABASE_INTERNAL: 'DATABASE'
    }.freeze

    def initialize(msg = 'Internal Server Error', # rubocop:disable Metrics/ParameterLists
                   description: nil,
                   code: nil, status_code: 500,
                   details: nil,
                   type: 'UNCATEGORY')
      super(msg)
      @status_code = status_code
      @code = code
      @type = type
      @description = description
      @details = details
    end
  end
end
