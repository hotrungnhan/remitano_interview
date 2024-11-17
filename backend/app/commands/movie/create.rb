# frozen_string_literal: true

module Commands
  module Movie
    class Create
      def initialize(performer, params)
        @performer = performer
        @params = params
      end

      def exec
        youtube_url = @params[:youtube_url]
        youtube_id = get_id_from_url(youtube_url)
        metadata = ::YoutubeApi.fetch_metadata(youtube_id)

        movie = ::Movie.create!(
          youtube_id: youtube_id,
          uploader: @performer,
          up_vote: Faker::Number.number(digits: 4),
          down_vote: Faker::Number.number(digits: 4),
          **metadata
        )

        # broadcast
        ActionCable.server.broadcast(
          'notification_global',
          {
            type: 'new_video',
            data: Serializers::Movie.render_as_hash(movie)
          }
        )

        movie
      end

      def get_id_from_url(youtube_url)
        uri = Addressable::URI.parse(youtube_url)
        return unless ['www.youtube.com', 'youtube.com'].include?(uri.host)
        return uri.query_values['v'] if uri.path == '/watch'

        return uri.path.delete_prefix('/shorts/') if uri.path.start_with?('/shorts')

        raise Errors::Movie::BadYoutubeUrl, youtube_url
      end
    end
  end
end
