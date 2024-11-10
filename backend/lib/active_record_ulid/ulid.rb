# frozen_string_literal: true

require 'ulid'

module ActiveRecordULID
  class ULID < String
    BASE32_CHARS = '0123456789ABCDEFGHJKMNPQRSTVWXYZ'
    CANONICAL_ULID = /\A[0-7][0-9A-HJKMNP-TV-Z]{25}\z/

    def initialize(ulid)
      super

      raise ArgumentError, "Invalid ULID: #{ulid}" unless match?(CANONICAL_ULID)
    end

    def self.generate(time = Time.zone.now, suffix: nil)
      new(::ULID.generate(time, suffix: suffix))
    end

    def timestamp
      timestamp_part = self[0, 10]
      # Convert from base32 to integer
      timestamp_part.chars.reduce(0) do |acc, char|
        (acc * 32) + BASE32_CHARS.index(char)
      end
    end

    def time
      Time.zone.at(timestamp)
    end
  end
end
