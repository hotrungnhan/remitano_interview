# frozen_string_literal: true

RSpec.describe ActiveRecordULID::ULID do
  let(:n) { 1_000 } # Set the number of iterations for benchmarking

  it 'benchmarks ULID.generate' do
    time = Benchmark.measure do
      n.times { described_class.generate }
    end
    p "Benchmark for ULID.generate: #{time.real} seconds"
    expect(time.real).to be < 0.05 # Example threshold
  end

  it 'benchmarks ULID#timestamp' do
    ulid = described_class.generate
    time = Benchmark.measure do
      n.times { ulid.timestamp }
    end
    p "Benchmark for ULID#timestamp: #{time.real} seconds"
    expect(time.real).to be < 0.01 # Example threshold
  end

  it 'benchmarks ULID#time' do
    ulid = described_class.generate
    time = Benchmark.measure do
      n.times { ulid.time }
    end
    p "Benchmark for ULID#time: #{time.real} seconds"
    expect(time.real).to be < 0.02 # Example threshold
  end
end
