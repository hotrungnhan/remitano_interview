
RSpec.configure do |config|
  # disable this one to allow console output
  config.before { allow($stdout).to receive(:write) }
end
