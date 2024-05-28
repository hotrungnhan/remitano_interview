# frozen_string_literal: true

RSpec.describe 'POST /auths/register' do
  let(:password) { '123456' }
  let(:api_uri) { '/auths/register' }

  let(:params) do
    {
      email: Faker::Internet.email,
      password: password
    }
  end

  context 'when success' do
    before do
      post api_uri, body: params.to_json, headers: authenticated_headers.merge({ 'Content-Type': 'application/json' })
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data]).to include(:token)
      expect(User.count).to eq(1)
    end
  end
end
