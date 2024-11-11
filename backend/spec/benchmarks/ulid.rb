# frozen_string_literal: true

require 'benchmark/ips'
require 'active_support/all'

# Benchmark the ULID generation, initialization, and timestamp extraction
Benchmark.ips do |x|
  x.report('ULID generation') do
    ActiveRecordULID::ULID.generate
  end

  x.report('ULID initialization') do
    ulid_str = ULID.generate # Generate a ULID string
    ActiveRecordULID::ULID.new(ulid_str)
  end

  x.report('ULID timestamp extraction') do
    ulid = ActiveRecordULID::ULID.generate
    ulid.timestamp
  end

  x.compare!
end
