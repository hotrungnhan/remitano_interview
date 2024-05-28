# frozen_string_literal: true

RSpec.shared_context 'with regions' do
  before do
    HubbleNexus::Region::ALL_REGION.each do |region|
      HubbleNexus::Region.where(**region).first_or_create!
    end
  end

  let(:region) do
    HubbleNexus::Region.first
  end
  let(:regions_headers) do
    { 'Hubble-Nexus-Region-Id' => HubbleNexus::Region.first.id }
  end
end
