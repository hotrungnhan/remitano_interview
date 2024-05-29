# frozen_string_literal: true

module Helpers
  module ErrorRescuer
    extend ActiveSupport::Concern
    include ActiveSupport::Rescuable
    include Helpers::ErrorRenderer

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_errors

      rescue_from ActionController::ParameterMissing do |e|
        render_parameter_errors(e.message)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        render_validation_errors(e.record.errors.full_messages)
      end

      rescue_from ActiveRecord::StatementInvalid do |_e|
        render_validation_errors('Invalid record error')
      end

      rescue_from ActiveSupport::MessageVerifier::InvalidSignature do |_e|
        render_validation_errors('Attachment(s) are not valid!')
      end

      # rescue_from OmniAuth::Strategies::GoogleIdToken::ClaimInvalid do |e|
      #   render_validation_errors(e.message)
      # end

      rescue_from JWTSessions::Errors::Malconfigured do |_e|
        render_server_errors
      end

      rescue_from JWTSessions::Errors::Unauthorized, JWTSessions::Errors::ClaimsVerification do |_e|
        render_authentication_errors
      end

      rescue_from JWTSessions::Errors::Expired do |_e|
        render_validation_errors(Errors::Code::EXPIRED_TOKEN_ERR)
      end

      rescue_from Errors::Base do |e|
        render_validation_errors(e.message, e.error_code_id, e.error_code_data)
      end
      
    end
  end
end
