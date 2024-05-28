# frozen_string_literal: true

RSpec.describe 'POST /movies' do
  include_context 'with authenticated headers and user'
  let(:api_uri) { '/movies' }
  let(:youtube_id) { Faker::Internet.uuid }
  let(:params) do
    {
      youtube_url: "https://www.youtube.com/watch?v=#{youtube_id}"
    }
  end
  let(:mock_data) do
    { title: 'Mock from google API',
      description: 'Description from google API' }
  end

  before do
    ENV['GOOGLE_API_KEY'] = 'google_api_key_sample'
  end

  context 'when success' do
    before do
      stub_request(:get, %r{https://www.googleapis.com/youtube/v3/videos})
        .with(query: hash_including do
                       'key' => 'nexus'
                       'part' => 'snippet'
                       'id' => youtube_id
                     end)
        .to_return(
          status: 200, body: {
            items: [
              {
                snippet: mock_data
              }
            ]
          }.to_json,
          headers: {}
        )
      post api_uri, params: params.to_json, headers: authenticated_headers.merge({ 'Content-Type': 'application/json' })
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data]).to include(:id, :youtube_id, :title, :description, :metadata, :uploaders)
    end
  end
end
