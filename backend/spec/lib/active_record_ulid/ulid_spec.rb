# frozen_string_literal: true

RSpec.describe ActiveRecordULID::ULID do
  describe '#generate' do
    it 'generates a valid ULID' do
      ulid = described_class.generate
      expect(ulid.match?(/\A[0-7][0-9A-HJKMNP-TV-Z]{25}\z/)).to be true
    end
  end

  describe '#initilize' do
    it 'returns false for an invalid ULID' do
      expect do
        described_class.new('invalid_ulid')
      end.to raise_error(ArgumentError, 'Invalid ULID: invalid_ulid')
    end
  end

  describe '#time' do
    it 'returns correct timestamp from ULID' do
      ulid = described_class.generate(Time.zone.at(0))
      expect(ulid.time.to_i).to eq(0)
    end
  end
end
