# frozen_string_literal: true

module Validations
  module Movies
    class ListParams < ApplicationValidation
      params(Concerns::Pagination::Schema.new, Concerns::Sortable::Schema.new) do
        optional(:title) { hash? | str? }
        optional(:upvote) { hash? | str? }
        optional(:downvote) { hash? | str? }
        optional(:privacy) { array? | str? }
        optional(:uploader_id) { array? | str? }
        optional(:created_at) { hash? | str? }
        optional(:updated_at) { hash? | str? }
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

    class BulkDeleteParams < ApplicationValidation
      json do
        required(:ids).filled(:array)
      end
    end
  end
end
