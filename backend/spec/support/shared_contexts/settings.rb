# frozen_string_literal: true

RSpec.shared_context 'with settings' do
  before do
    HubbleNexus::Setting::DEFAULT.each do |name, value|
      HubbleNexus::Setting.where(name: name).first_or_create!(name: name, **value)
    end
  end
end
