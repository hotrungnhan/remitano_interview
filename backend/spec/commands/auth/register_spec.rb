# frozen_string_literal: true

RSpec.describe Commands::Auth::Register, type: :service do
  let(:password) { '12456' }

  let(:params) do
    {
      email: Faker::Internet.email,
      password: password
    }
  end

  context 'when success' do
    it do
      expect do
        session = described_class.new(user, params).perform

        expect(User.count).to eq(1)
        user = User.first
        expect(user.email).to eq(params[:email])

        expect(session).to include(:access_token)
      end.not_to raise_error
    end
  end

  context 'when fail' do
    let(:user) { create(:user, password: password) }

    before do
      params[:email] = user.email
    end

    it 'Exist user' do
      expect do
        described_class.new(user, params).perform
      end.to raise_error(AuthErr::NoUserErr)
    end
  end
end
