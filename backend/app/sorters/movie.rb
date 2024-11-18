# frozen_string_literal: true

module Sorters
  class Movie < ApplicationSorter
    keys :title, :created_at

    def by_title(dir)
      query.order(title: dir)
    end

    def by_created_at(dir)
      query.order(created_at: dir)
    end
  end
end
