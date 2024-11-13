# frozen_string_literal: true

module Errors
  module Movie
    class BadYoutubeUrl < ApplicationError
      def initialize(msg = 'BadYoutubeUrl',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end

    class FetchYoutubeMetadata < ApplicationError
      def initialize(msg = 'FetchYoutubeMetadata',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end

    class NotFoundYoutubeVideo < ApplicationError
      def initialize(msg = 'NotFoundYoutubeVideo',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end
  end
end
