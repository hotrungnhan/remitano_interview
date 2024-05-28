# frozen_string_literal: true

module Commands
  module Movie
    class Create
      def initialize(performer, params)
        @performer = user
        @params = params
      end

      def exec
        youtube_url = @params[:youtube_url]
        youtube_id = get_id_from_url(@youtube_url)

        metadata = fetch_metadata(youtube_id)

        Movie.create!(
          youtube_id: youtube_id,
          title: metadata[:title],
          description: metadata[:description],
          uploader: @performer,
          up_vote: Faker::Number.number(digits: 4),
          down_vote: Faker::Number.number(digits: 4)
        )
      end

      def get_id_from_url(youtube_url)
      end

      def fetch_metadata(youtube_id)
      end
    end
  end
end
