# frozen_string_literal: true

RSpec.describe 'GET /movies' do
  let(:api_uri) { '/movies' }

  context 'when success' do
    before do
      create_list(:movies, 10)
      get api_uri, params: params
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data].count).to eq(10)
    end
  end
end
