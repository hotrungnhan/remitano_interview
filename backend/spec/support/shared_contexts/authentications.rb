# frozen_string_literal: true

RSpec.shared_context 'with authenticated headers and user' do
  include_context 'with regions'
  before do
    HubbleNexus::Role::BASIC_ROLES.each do |role|
      HubbleNexus::Role.where(**role).first_or_create!
    end
  end

  let!(:authenticated_user) do
    create(:user, is_active: true, is_deleted: false, role: HubbleNexus::Role.find_by(key: 'admin'))
  end

  let(:authenticated_headers) do
    token = JWTSessions::Session.new(
      payload: {
        user_id: authenticated_user.id
      }, refresh_by_access_allowed: true
    ).login
    { 'Authorization' => token[:access] }
  end

  let(:authenticated_headers_with_region) do
    regions_headers.merge(authenticated_headers)
  end
end

# RSpec.shared_context 'with authenticated hubble internal service' do
#   let(:authenticated_headers) { { 'Hubble-Gateway-Internal-API-Call' => true } }
# end
