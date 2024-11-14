# frozen_string_literal: true

module Errors
  class ApplicationError < StandardError
    attr_reader :status_code, :code, :type, :description, :details

    def initialize(msg = 'Internal Server Error', # rubocop:disable Metrics/ParameterLists
                   description: 'An System Error',
                   status_code: 500, code: 'INTERNAL_SERVER_ERROR',
                   details: nil,
                   type: 'BASIC')
      super(msg)
      @status_code = status_code
      @code = code
      @type = type
      @description = description
      @details = details
    end
  end
end
