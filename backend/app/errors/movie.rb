# frozen_string_literal: true

module Errors
  module Movie
    class BadYoutubeUrl < Errors::ApplicationError
      def initialize(url)
        super(
          'Youtube url invalid',
          code: 'YT_URL_INVALID', status_code: 400,
          type: 'VALIDATION',
          details: [
            {
              field: 'youtube_url',
              messages: ["#{url} is invalid format."]
            }
          ]
       )
      end
    end

    class FetchYoutubeMetadata < Errors::ApplicationError
      def initialize(body)
        super(
          'Youtube Video Not Found',
          description: body,
          code: 'YT_VIDEO_NOT_FOUND', status_code: 422,
          type: 'THIRD_PARTY'
       )
      end
    end

    class NotFoundYoutubeVideo < Errors::ApplicationError
      def initialize
        super(
          'Youtube Video Not Found',
           description: nil,
           code: 'YT_VIDEO_NOT_FOUND', status_code: 422,
           type: 'THIRD_PARTY'
        )
      end
    end
  end
end
