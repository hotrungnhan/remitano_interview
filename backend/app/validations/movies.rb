# frozen_string_literal: true

module Validations
  module Movies
    class ListParams < ApplicationValidation
      params(Validations::Concerns::Pagination::Schema.new)
    end

    class CreateParams < ApplicationValidation
      params do
        required(:youtube_url).filled(:string)
      end
    end
  end
end
