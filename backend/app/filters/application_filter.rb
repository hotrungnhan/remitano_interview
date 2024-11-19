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

    def process_matchable_column(query, column, conditions)
      return if conditions.blank?
      return query.where(column => conditions) if conditions.is_a?(String)

      query = query.where("#{column} LIKE ?", "%#{conditions[:like]}%") if conditions[:like].present?
      query = query.where("#{column} ILIKE ?", "%#{conditions[:ilike]}%") if conditions[:ilike].present?
      query
    end

    def process_comparation_column(query, column, conditions) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      return if conditions.blank?
      return query.where(column => conditions) if conditions.is_a?(String)
      return unless conditions.is_a?(Hash)

      query = query.where(column => ..conditions[:lte]) if conditions[:lte].present?
      query = query.where(column => conditions[:gte]..) if conditions[:gte].present?
      query = query.where(column => conditions[:eq]) if conditions[:eq].present?
      query = query.where.not(column => ..conditions[:gt]) if conditions[:gt].present?
      query = query.where(column => ...conditions[:lt]) if conditions[:lt].present?

      query
    end

    def process_list_column(query, column, conditions)
      return if conditions.blank?

      query.where(column => conditions) if conditions.is_a?(String) || conditions.is_a?(Array)
    end
  end
end
