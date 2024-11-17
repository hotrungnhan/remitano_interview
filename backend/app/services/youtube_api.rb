# frozen_string_literal: true

class YoutubeApi
  def self.fetch_metadata(youtube_id) # rubocop:disable Metrics/MethodLength
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
