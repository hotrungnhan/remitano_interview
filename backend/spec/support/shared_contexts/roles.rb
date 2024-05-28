RSpec.shared_examples 'system_role' do
  it { expect { described_class.new }.not_to raise_error }

  context 'with an instance' do
    let(:instance) { described_class.new }

    it do
      expect { instance.role_key }.not_to raise_error
    end
  end
end
