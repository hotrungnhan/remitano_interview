Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.utc.iso8601 }
  config.method = :generate

  config.extensions << BlueprinterActiveRecord::Preloader.new(auto: true, use: :includes)

end
