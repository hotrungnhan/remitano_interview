%i[commands serializers validations filters sorters validations/concerns errors controllers/concerns models/concerns].each do |dir|
  ActiveSupport::Dependencies.autoload_paths.delete "#{Rails.root}/app/#{dir}"
end
ActiveSupport::Dependencies.autoload_paths << "#{Rails.root}/app"
