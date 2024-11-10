# frozen_string_literal: true

RSpec.describe ActiveRecordULID::OID::ULID do
  describe '#serialize' do
    it 'serializes a ULID to a string' do
      ulid = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGV8Z')
      oid = described_class.new

      serialized = oid.serialize(ulid)
      expect(serialized).to eq(ulid.to_s)
    end
  end

  describe '#deserialize' do
    it 'deserializes a string to a ULID object' do
      ulid_string = '01ARYZ6S41S6T9JBYF750WGV8Z'
      oid = described_class.new

      deserialized = oid.deserialize(ulid_string)
      expect(deserialized).to be_an_instance_of(ActiveRecordULID::ULID)
      expect(deserialized.to_s).to eq(ulid_string)
    end

    it 'deserializes nil' do
      ulid_string = nil
      oid = described_class.new

      deserialized = oid.deserialize(ulid_string)
      expect(deserialized).to be_nil
    end
  end

  describe '#changed?' do
    it 'returns true when the old and new values are different types' do
      old_value = '01ARYZ6S41S6T9JBYF750WGV8Z' # String type
      new_value = ActiveRecordULID::ULID.new(old_value) # ULID type
      oid = described_class.new

      expect(oid.changed?(old_value, new_value, nil)).to be true
    end

    it 'returns true when the values are different' do
      old_value = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGV8Z')
      new_value = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGXYD')
      oid = described_class.new

      expect(oid.changed?(old_value, new_value, nil)).to be true
    end

    it 'returns false when the values are the same' do
      ulid = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGV8Z')
      oid = described_class.new

      expect(oid.changed?(ulid, ulid, nil)).to be false
    end
  end

  describe '#changed_in_place?' do
    it 'returns true when the raw value and new value are of different types' do
      raw_value = '01ARYZ6S41S6T9JBYF750WGV8Z' # String type
      new_value = ActiveRecordULID::ULID.new(raw_value) # ULID type
      oid = described_class.new

      expect(oid.changed_in_place?(raw_value, new_value)).to be true
    end

    it 'returns true when the raw and new values are different' do
      raw_value = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGV8Z')
      new_value = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGXYY')
      oid = described_class.new

      expect(oid.changed_in_place?(raw_value, new_value)).to be true
    end

    it 'returns false when the values are the same' do
      ulid = ActiveRecordULID::ULID.new('01ARYZ6S41S6T9JBYF750WGV8Z')
      oid = described_class.new

      expect(oid.changed_in_place?(ulid, ulid)).to be false
    end
  end
end
