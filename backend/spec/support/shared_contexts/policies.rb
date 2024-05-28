RSpec.shared_examples 'policies' do
  it { expect { described_class.new(nil, nil) }.not_to raise_error }

  context 'with an instance' do
    let(:instance) { described_class.new(nil, nil) }

    let(:role_actions_methods) do
      %w[
        available_actions
        available_actions_for_csm
        available_actions_for_finance
        available_actions_for_admin
        available_actions_for_sale
        available_actions_for_engineer
      ]
    end

    it 'will not raise exception' do
      role_actions_methods.each do |role_actions_method|
        expect { instance.send(role_actions_method) }.not_to raise_error
      end
    end
  end
end
