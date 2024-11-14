# frozen_string_literal: true

module Concerns
  module ErrorRescuer
    extend ActiveSupport::Concern
    include ActiveSupport::Rescuable
    include Concerns::ErrorRenderer

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_errors

      rescue_from ActionController::BadRequest, with: :render_parameter_errors

      rescue_from ActiveRecord::RecordInvalid do |e|
        render_validation_errors(e.record.errors.full_messages)
      end

      rescue_from ActiveRecord::StatementInvalid, with: :render_validation_errors

      rescue_from ActiveSupport::MessageVerifier::InvalidSignature do |_e|
        render_validation_errors('Attachment(s) are not valid!')
      end

      rescue_from JWTSessions::Errors::Malconfigured, with: :render_server_errors

      rescue_from JWTSessions::Errors::Unauthorized, JWTSessions::Errors::ClaimsVerification do |e|
        render_authentication_errors(e)
      end

      rescue_from JWTSessions::Errors::Expired do |_e|
        render_validation_errors(Errors::Code::EXPIRED_TOKEN_ERR)
      end

      rescue_from Errors::ApplicationError do |e|
        render_errors(e.message, status_code: e.status_code,
                                 code: e.code,
                                 type: e.type,
                                 details: e.details,
                                 description: e.description)
      end
    end
  end
end
