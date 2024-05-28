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
        metadata = fetch_metadata(youtube_id)

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
            data: Serializers::Movie.new(movie).to_h
          }
        )

        movie
      end

      def get_id_from_url(youtube_url)
        uri = Addressable::URI.parse(youtube_url)
        return unless ['www.youtube.com', 'youtube.com'].include?(uri.host)
        return uri.query_values['v'] if uri.path == '/watch'

        return uri.path.delete_prefix('/shorts/') if uri.path.start_with?('/shorts')

        raise Errors::Movie::BadYoutubeUrl
      end

      def fetch_metadata(youtube_id) # rubocop:disable Metrics/MethodLength
        url = 'https://www.googleapis.com/youtube/v3/videos'
        key = ENV.fetch('GOOGLE_API_KEY')

        raise 'NO GOOGLE API KEY' if key.blank?

        query_params = {
          key: key,
          part: 'snippet',
          id: youtube_id
        }

        header = {
          origin: 'https://mattw.io',
          referer: 'https://mattw.io/'
        }

        options = { query: query_params, headers: header }

        response = HTTParty.get(url, options)

        raise Errors::Movie::FetchYoutubeMetadata, response.body unless response.success?

        body = JsonHash.json_string_to_hash(response.body)

        raise Errors::Movie::NotFoundYoutubeVideo if body[:items].count <= 0

        video_metadata = body[:items].first[:snippet]
        {
          title: video_metadata[:title],
          description: video_metadata[:description]
        }
      end
    end
  end
end
