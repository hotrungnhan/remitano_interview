# frozen_string_literal: true

module Concerns
  module Paginator
    include Pagy::Backend
    extend ActiveSupport::Concern

    included do
      def paginate(query, params)
        page = params[:_page]
        limit = params[:_limit]
        count = query.async_count
        inject_page_info(count.value, page, limit)

        query.limit(limit).offset((page.to_i - 1) * limit)
      end

      def inject_page_info(count, page, limit)
        total_page = (count.to_f / limit).ceil
        @page_info = {
          limit: limit,
          prev_page: page > 1 ? page - 1 : nil,
          current_page: page,
          next_page: page < total_page ? page + 1 : nil,
          total_page: total_page,
          count: count
        }
        @meta[:pagination] = @page_info unless @meta.nil?
      end
    end
  end
end
