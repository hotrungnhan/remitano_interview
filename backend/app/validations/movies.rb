# frozen_string_literal: true

module Validations
  module Movies
    class ListParams < ApplicationValidation
      params(Concerns::Pagination::Schema.new, Concerns::Sortable::Schema.new) do
        optional(:title).value(:string)
      end
    end

    class CreateParams < ApplicationValidation
      params do
        required(:youtube_url).filled(:string)
      end
    end

    class ReactParams < ApplicationValidation
      params(Concerns::Id::Schema.new) do
        required(:type).filled(:string)
      end
    end
  end
end
