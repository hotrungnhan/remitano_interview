%i[commands serializers errors].each do |dir|
  ActiveSupport::Dependencies.autoload_paths.delete "#{Rails.root}/app/#{dir}"
end
ActiveSupport::Dependencies.autoload_paths << "#{Rails.root}/app"
# puts ActiveSupport::Dependencies.autoload_paths
