# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JWTSessions::RailsAuthorization
    identified_by :current_user

    # JWTSessions::RailsAuthorization compatible
    def request_headers
      {
        'Authorization' => request.params[:auth_token].to_s
      }
    end

    def connect
      authorize_access_request!
      self.current_user ||= User.find(payload['user_id']) if session_exists?(:access)
    rescue StandardError
      reject_unauthorized_connection
    end
  end
end
