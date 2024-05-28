# frozen_string_literal: true

RSpec.describe 'GET /auths' do
  include_context 'with authenticated headers and user'

  let(:api_uri) { '/auths' }

  context 'when success' do
    before do
      get api_uri, headers: authenticated_headers
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data]).to include(:id, :email)
    end
  end
end
