# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Helpers::ErrorRenderer
  include Helpers::ErrorRescuer
  include JWTSessions::RailsAuthorization
  before_action :authorize_access_request!

  def current_user
    @current_user ||= User.find(payload['user_id']) if session_exists?(:access)
  end
end
