# frozen_string_literal: true

require 'benchmark'
require 'benchmark/memory'
require 'benchmark/ips'
require 'parallel'
require 'json'
require 'async'

class Calculator
  FILE = File.read('/Users/kudousterain/Desktop/Joy/webtruyen/backend/spec/benchmarks/sample.json')

  def self.cal(i)
    # JSON.parse(i)
    sleep(1)
  end
end
Ractor.new {} # rubocop:disable Lint/EmptyBlock

OP = 128_000

Benchmark.bm do |x|
  # the warmup phase (default 2) and calculation phase (default 5)
  # x.config(time: 5, warmup: 2)

  # x.report('thread') do
  #   Array.new(OP) do |i|
  #     Thread.new do
  #       Calculator.cal(i)
  #     end
  #   end.map(&:value)
  # end

  x.report('fiber') do
    Async do
      Array.new(OP) do |i|
        Async do
          Calculator.cal(i)
        end
      end.map(&:wait)
    end
  end

  # x.report('ractor') do
  #   Array.new(OP) do |i|
  #     Ractor.new i do |i|
  #       Calculator.cal(i)
  #     end
  #   end.map(&:take)
  # end
  # x.report('parallels - in 2 thread') do
  #   Parallel.map(Array.new(OP)) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 8 thread') do
  #   Parallel.map(Array.new(OP), in_threads: 8) { |i| Calculator.cal(i) }
  # end
  x.report('parallels - in 2040 thread') do
    Parallel.map(Array.new(OP), in_threads: 2040) { |i| Calculator.cal(i) }
  end
  # x.report('parallels - in 2 process') do
  #   Parallel.map(Array.new(OP), in_processes: 2) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 8 process ') do
  #   Parallel.map(Array.new(OP), in_processes: 8) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 128 process ') do
  #   Parallel.map(Array.new(OP), in_processes: 128) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 2 ractor') do
  #   Parallel.map(Array.new(OP), ractor: [Calculator, :cal])
  # end
  # x.report('parallels - in 8 ractor ') do
  #   Parallel.map(Array.new(OP), in_ractors: 8, ractor: [Calculator, :cal])
  # end
  # x.compare!
end

Benchmark.memory do |x|
  # x.report('thread') do
  #   Array.new(OP) do |i|
  #     Thread.new do
  #       Calculator.cal(i)
  #     end
  #   end.map(&:value)
  # end
  # x.report('fiber') do
  #   Async do
  #     Array.new(OP) do |i|
  #       Async do
  #         Calculator.cal(i)
  #       end
  #     end.map(&:wait)
  #   end
  # end
  # x.report('ractor') do
  #   Array.new(OP) do |i|
  #     Ractor.new i do |i|
  #       Calculator.cal(i)
  #     end
  #   end.map(&:take)
  # end
  # x.report('parallels - in 2 thread') do
  #   Parallel.map(Array.new(OP)) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 8 thread') do
  #   Parallel.map(Array.new(OP), in_threads: 8) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 128 thread') do
  #   Parallel.map(Array.new(OP), in_threads: 128) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 2 process') do
  #   Parallel.map(Array.new(OP), in_processes: 2) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 8 process ') do
  #   Parallel.map(Array.new(OP), in_processes: 8) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 128 process ') do
  #   Parallel.map(Array.new(OP), in_processes: 128) { |i| Calculator.cal(i) }
  # end
  # x.report('parallels - in 2 ractor') do
  #   Parallel.map(Array.new(OP), ractor: [Calculator, :cal])
  # end
  # x.report('parallels - in 8 ractor ') do
  #   Parallel.map(Array.new(OP), in_ractors: 8, ractor: [Calculator, :cal])
  # end
  x.compare!
end
