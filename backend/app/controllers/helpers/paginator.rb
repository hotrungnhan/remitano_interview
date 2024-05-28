# frozen_string_literal: true

module Api
  module Helpers
    module Paginator
      extend ActiveSupport::Concern

      DEFAULT_PAGE = ENV['DEFAULT_PAGE']&.to_i || 1
      MIN_PAGE = ENV['MIN_PAGE']&.to_i || 1

      DEFAULT_PER_PAGE = ENV['DEFAULT_PER_PAGE']&.to_i || 20
      MIN_PER_PAGE = ENV['MIN_PER_PAGE']&.to_i || 1
      MAX_PER_PAGE = ENV['MAX_PER_PAGE']&.to_i || 50

      included do
        def paginate(objects)
          page = params[:page]&.to_i || DEFAULT_PAGE
          per_page = params[:per_page]&.to_i || DEFAULT_PER_PAGE
          validate_pagination_params(page, per_page)

          objects = objects.page(page).per(per_page)
          @page_info = {
            page: page,
            total_pages: objects.total_pages,
            total_count: objects.total_count
          }
          objects
        end

        private

          def validate_pagination_params(page, per_page)
            raise Internal::RequestParameterExceptions::PageParamSmallerThanMinError if page < MIN_PAGE
            raise Internal::RequestParameterExceptions::PerPageParamSmallerThanMinError if per_page < MIN_PER_PAGE
            raise Internal::RequestParameterExceptions::PerPageParamLargerThanMaxError if per_page > MAX_PER_PAGE
          end
      end
    end
  end
end
