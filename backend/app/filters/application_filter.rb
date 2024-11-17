# frozen_string_literal: true

# A base filter module that all other filter classes can include
# Note: Default mode when filter by multiple fields is AND
#
# *** For a filter class (e.g. UserFilter) when include this module: ***
#
# 1. Implement private method #permissible_filter_keys
#    to return an array of filter keys that the filter class support
#
#    _ Example return: %i[status]
#
# 2. Implement private method #base_query
#    to return an ActiveRecord::Relation
#
#    _ Example return: HubbleNexus::User.all
#
# 3. For each key in (1) define a private method
#    by_#{key} to implement the filter.
#
#    Use helper method #reflect so that
#    it returns self and update @query.
#
#    _ Example:
#
#     def by_status
#       reflect(query.where(status: params[:status]))
#     end
#
# *** To use the filter class: ***
#
# 1. Pass in the params when initialize
#    Example: user_filter = UserFilter.new(params)
#
# 2. Apply method #execute to filter and get results
#    Example: filtered_users = user_filter.execute

class ApplicationFilter
  include ArelTables::BaseArelTable

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def execute
    filter_methods
      .inject(self) { |filter, method| filter.send(method) }
      .send(:query)
  end

  private

    def filter_methods
      params
        .slice(*permissible_filter_keys)
        .keys.filter_map { |key| "by_#{key}" }
    end

    def prefix_for_dynamic_filter_method
      nil
    end

    def permissible_filter_keys
      raise NotImplementedError,
            "#{self.class.name}#permissible_filter_keys is not implemented yet!"
    end

    def query
      @query ||= base_query
    end

    def base_query
      raise NotImplementedError,
            "#{self.class.name}#base_query is not implemented yet!"
    end

    def reflect(query)
      @query = query
      self
    end
end
