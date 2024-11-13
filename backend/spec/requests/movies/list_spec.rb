# frozen_string_literal: true

RSpec.describe 'Movies API' do
  include_context 'with authenticated headers and user'
  path '/movies' do
    get 'List Movies' do
      tags 'Movies'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Success' do
        let!(:movies) { create_list(:movie, 10, uploader: authenticated_user) } # rubocop:disable RSpec/LetSetup

        run_test! 'returns a list of movies' do
          expect(response_hash[:data].count).to eq(10)
        end
      end
    end
  end
end
