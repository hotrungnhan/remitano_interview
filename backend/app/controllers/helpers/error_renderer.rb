# frozen_string_literal: true
  module Api
    module Helpers
      module ErrorRenderer
        def render_errors(messages, http_status_code, error_code_id, error_code_data)
          messages = [messages] unless messages.is_a? Array

          Thread.current[:error_code_id] = error_code_id
          error_code = {
            id: error_code_id,
            data: error_code_data,
            description: messages.join(' | ')
          }
          render json: { errors: messages, error_code: error_code }, status: http_status_code
        end

        def render_authentication_errors(messages = I18n.t('controllers.defaults.errors.authentication_error'),
                                         error_code_id = ErrorCode::AUTHENTICATION_ERR, error_code_data = nil)
          render_errors(messages, :unauthorized, error_code_id, error_code_data)
        end

        def render_authorization_errors(messages = I18n.t('controllers.defaults.errors.authorization_error'),
                                        error_code_id = ErrorCode::AUTHORIZATION_ERR, error_code_data = nil)
          render_errors(messages, :forbidden, error_code_id, error_code_data)
        end

        def render_not_found_errors(messages = I18n.t('controllers.defaults.errors.not_found_error'),
                                    error_code_id = ErrorCode::RECORD_NOT_FOUND_ERR, error_code_data = nil)
          render_errors(messages, :not_found, error_code_id, error_code_data)
        end

        def render_parameter_errors(messages = I18n.t('controllers.defaults.errors.parameter_error'),
                                    error_code_id = ErrorCode::PARAMETER_MISSING_ERR, error_code_data = nil)
          render_errors(messages, :bad_request, error_code_id, error_code_data)
        end

        def render_validation_errors(messages = I18n.t('controllers.defaults.errors.validation_error'),
                                     error_code_id = ErrorCode::VALIDATION_ERR, error_code_data = nil)
          logger.debug 'Validation Error: the error messages as follows:'
          messages = [messages] unless messages.is_a? Array
          messages.each { |message| logger.debug "  '#{message}'" }
          render_errors(messages, :unprocessable_entity, error_code_id, error_code_data)
        end

        def render_server_errors(messages = I18n.t('controllers.defaults.errors.server_error'),
                                 error_code_id = ErrorCode::SERVER_ERR, error_code_data = nil)
          render_errors(messages, :internal_server_error, error_code_id, error_code_data)
        end
      end
    end
end
