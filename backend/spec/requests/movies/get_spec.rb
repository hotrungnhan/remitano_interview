# frozen_string_literal: true

RSpec.describe 'Movies API' do
  include_context 'with authenticated headers and user'

  path '/movies/{id}' do
    get 'Get Movies' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string
      #  setup
      let(:movie) { create(:movie, uploader: authenticated_user) }

      response '200', 'Success' do
        let(:id) { movie.id }

        run_test! 'returns a created movie' do
          expect(response_hash[:data]).to include(:id, :youtube_id, :title, :description, :metadata, :uploader)
        end
      end
    end
  end
end
