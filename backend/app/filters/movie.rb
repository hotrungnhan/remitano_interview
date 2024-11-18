# frozen_string_literal: true

module Filters
  class Movie < ApplicationFilter
    keys :privacy, :title
    default_query Movie

    def by_title
      return if params[:title].blank?

      query.where(title: params[:title])
    end

    def by_privacy
      return if params[:privacy].blank?

      query.where(privacy: params[:privacy])
    end
  end
end
