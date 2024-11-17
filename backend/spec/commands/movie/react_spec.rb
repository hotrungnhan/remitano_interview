# frozen_string_literal: true

RSpec.describe Commands::Movie::React, type: :service do
  let(:performer) { create(:user) }
  let(:movie) { create(:movie, uploader: performer) }

  describe 'when success' do
    let(:params) do
      { type: 'upvote' }
    end

    it 'with correct data' do
      expect do
        described_class.new(performer, movie, params).exec
      end.to change(movie, :up_vote).by(1)
    end
  end
end
