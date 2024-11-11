# frozen_string_literal: true

RSpec.shared_context 'with authenticated headers and user' do
  let!(:authenticated_user) do
    create(:user)
  end

  let(:authenticated_token) do
    token = JWTSessions::Session.new(
      payload: {
        user_id: authenticated_user.id
      }, refresh_by_access_allowed: true
    ).login
    token[:access]
  end

  let(:authenticated_headers) do
    { 'Authorization' => authenticated_token }
  end

  let(:Authorization) { "BEARER #{authenticated_token}" } # rubocop:disable RSpec/VariableName
end
