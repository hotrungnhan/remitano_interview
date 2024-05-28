Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, :callback_path => "/nexus-api/auth/developer/callback", provider_ignores_state: true if Rails.env.development?
  
end

OmniAuth.config.allowed_request_methods = %i[get post]
