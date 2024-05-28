# frozen_string_literal: true

RSpec.shared_context 'with authenticated headers and user' do
  let!(:authenticated_user) do
    create(:user)
  end

  let(:authenticated_headers) do
    token = JWTSessions::Session.new(
      payload: {
        user_id: authenticated_user.id
      }, refresh_by_access_allowed: true
    ).login
    { 'Authorization' => token[:access] }
  end
end
