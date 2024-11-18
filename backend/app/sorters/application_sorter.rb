# frozen_string_literal: true

module Sorters
  class ApplicationSorter
    attr_reader :params, :query

    def initialize(params, query = nil)
      @params = parse_and_validate_sort_params(params[:_sort] || {})
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

    def parse_and_validate_sort_params(sort_params)
      sort_params.to_h do |field, direction|
        direction = (direction.downcase == 'asc' ? :asc : :desc)
        [field.to_sym, direction.to_sym]
      end
    end

    def exec
      @params.inject(self) do |sorter, params|
        key, dir = params
        result = sorter.send(:"by_#{key}", dir)
        @query = result unless result.nil?
        self
      end

      @query
    end
  end
end
