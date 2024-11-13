# frozen_string_literal: true

module Validations
  module Movies
    class CreateParams < ApplicationValidation
      define do
        required(:youtube_url).filled(:string)
      end
    end
  end
end
