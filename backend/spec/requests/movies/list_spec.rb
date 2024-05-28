# frozen_string_literal: true

RSpec.describe 'GET /movies' do
  include_context 'with authenticated headers and user'
  let(:api_uri) { '/movies' }

  context 'when success' do
    before do
      create_list(:movie, 10, uploader: authenticated_user)

      get api_uri, headers: authenticated_headers
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data].count).to eq(10)
    end
  end
end
