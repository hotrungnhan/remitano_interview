# frozen_string_literal: true

require 'redis'
require 'mock_redis'

RSpec.configure do |config|
  config.before(:each) do
    mock_redis = MockRedis.new
    allow(Redis).to receive(:new).and_return(mock_redis)
  end
end
