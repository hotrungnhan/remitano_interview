# frozen_string_literal: true

module Filters
  class ApplicationFilter
    attr_reader :params, :query

    def initialize(params, query = nil)
      @params = params
      @query = query || self.class.instance_variable_get(:@default_query)
      raise "Query isn't defined, please pass to Filter#new method or defined the default_query" if @query.nil?
    end

    def self.keys(*keys)
      @keys ||= [] # Initialize keys storage

      @keys.concat(keys).uniq if keys.size.positive?
    end

    def self.default_query(query = nil)
      @default_query = query
    end

    def exec
      self.class.instance_variable_get(:@keys)
          .inject(self) do |filter, key|
        result = filter.send(:"by_#{key}")
        @query = result unless result.nil?
        self
      end

      @query
    end
  end
end
