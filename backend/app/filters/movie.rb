# frozen_string_literal: true

# module Filters
#   class Movie
#     keys %i[privacy]

#     def initialize(base_query)
#       super
#     end

#     def by_privacy(params)
#       return if params[:privacy].blank?

#       query.where(privacy: params[:privacy])
#     end

#     # overide
#     def exec
#       query
#     end
#   end
# end
