require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    # config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true
    config.active_record.primary_key = :ulid

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: 'remintano'
    config.middleware.delete ActionDispatch::Static
    config.middleware.delete Rack::ConditionalGet
    config.middleware.delete Rack::Sendfile
    config.middleware.delete Rack::ETag
    config.middleware.delete Rack::Head

    config.generators do |g|
      g.orm :active_record, primary_key_type: :ulid
      g.orm :active_record, foreign_key_type: :ulid
    end

  end
end
