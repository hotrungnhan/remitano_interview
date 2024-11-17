# frozen_string_literal: true

class ApplicationController < ActionController::Metal
  abstract!

  # system
  # include ActionController::StrongParameters
  include ActionController::Logging
  include ActionController::Head
  include AbstractController::Callbacks

  # user
  include JWTSessions::RailsAuthorization
  include Concerns::Logger
  include Concerns::ErrorRenderer
  include Concerns::Validator
  include Concerns::Rendering
  include Concerns::ErrorRescuer

  # system
  include ActionController::Rescue

  before_action :authorize_access_request!

  def current_user
    @current_user ||= User.find(payload['user_id']) if session_exists?(:access)
  end

  def current_ability
    @current_ability ||= ApplicationAbility.new(current_user)
  end
  ActiveSupport.run_load_hooks(:action_controller_api, self)
  ActiveSupport.run_load_hooks(:action_controller, self)
end
