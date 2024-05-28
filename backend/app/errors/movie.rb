# frozen_string_literal: true

module Errors
  module Movie
    class BadYoutubeUrl < Base
      def initialize(msg = 'BadYoutubeUrl',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end

    class FetchYoutubeMetadata < Base
      def initialize(msg = 'FetchYoutubeMetadata',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end

    class NotFoundYoutubeVideo < Base
      def initialize(msg = 'NotFoundYoutubeVideo',
                     error_code_id: Errors::Code::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end
  end
end
