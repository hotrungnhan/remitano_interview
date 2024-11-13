# frozen_string_literal: true

RSpec.describe 'Movies API' do
  include_context 'with authenticated headers and user'

  path '/movies' do
    post 'Create Movies' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :params, in: :body, schema: Validations::Movies::CreateParams.json_schema
      response '200', 'Success' do
        let(:api_uri) { '/api/movies' }
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
        end

        run_test! 'returns a created movie' do
          expect(response_hash[:data]).to include(:id, :youtube_id, :title, :description, :metadata, :uploader)
        end
      end
    end
  end
end
