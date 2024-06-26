# frozen_string_literal: true

RSpec.describe 'POST /auths/login' do
  let(:password) { '123456' }
  let(:user) { create(:user, password: password) }
  let(:api_uri) { '/auths/login' }

  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  context 'when success' do
    before do
      post api_uri, params: params.to_json, headers: { 'Content-Type': 'application/json' }
    end

    include_examples 'an HTTP response with status code', 200
    it do
      expect(response_hash[:data]).to include(:access_token)
    end
  end
end
