RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Rails.root.join('tmp/storage'))
    FileUtils.rm_rf(Rails.root.join('tmp/cache'))
  end
end
