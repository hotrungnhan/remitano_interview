# frozen_string_literal: true

RSpec.describe Commands::Auth::Login, type: :service do
  let(:password) { '12456' }
  let(:user) { create(:user, password: password) }

  let(:params) do
    {
      email: user.email,
      password: password
    }
  end

  context 'when success' do
    it do
      expect do
        described_class.new(user, params).perform
      end.not_to raise_error
    end
  end

  context 'when fail' do
    context 'with mismatch password' do
      before do
        params[:password] = '7890123'
      end

      it do
        expect do
          described_class.new(user, params).perform
        end.to raise_error(UserErr::NoUserErr)
      end
    end

    context 'without exist user' do
      it do
        expect do
          described_class.new(user, params).perform
        end.to raise_error(UserErr::NoUserErr)
      end
    end
  end
end
