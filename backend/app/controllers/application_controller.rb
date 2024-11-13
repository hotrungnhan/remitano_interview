# frozen_string_literal: true

class ApplicationController < ActionController::Metal
  abstract!

  # system
  # include ActionController::StrongParameters
  include ActionController::Logging
  include ActionController::Rescue
  include AbstractController::Callbacks

  # user
  include Concerns::Logger
  include Concerns::ErrorRenderer
  include Concerns::Validator
  include Concerns::ErrorRescuer
  include Concerns::Rendering
  include JWTSessions::RailsAuthorization

  before_action :authorize_access_request!

  def current_user
    @current_user ||= User.find(payload['user_id']) if session_exists?(:access)
  end

  ActiveSupport.run_load_hooks(:action_controller_api, self)
  ActiveSupport.run_load_hooks(:action_controller, self)
end
