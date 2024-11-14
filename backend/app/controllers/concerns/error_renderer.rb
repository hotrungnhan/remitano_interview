# frozen_string_literal: true

module Concerns
  module ErrorRenderer
    def render_errors(message, # rubocop:disable Metrics/ParameterLists
                      status_code: 400,
                      code: nil,
                      type: 'UNCATEGORY',
                      description: nil,
                      details: nil)
      json_resp = {
        message: message,
        code: code,
        type: type,
        description: description || message
      }

      json_resp[:details] = details if details.present?

      render json: json_resp, status: status_code, root: nil
    end

    def render_authentication_errors(e) # rubocop:disable Naming/MethodParameterName
      render_errors('Unauthorized', status_code: 401, code: 'UNAUTHORIZED', description: e.to_s)
    end

    def render_not_found_errors(e) # rubocop:disable Naming/MethodParameterName
      render_errors('Not Found', status_code: 404, code: 'NOT_FOUND', description: e.to_s)
    end

    def render_parameter_errors(e) # rubocop:disable Naming/MethodParameterName
      render_errors('Bad Request', status_code: 400, code: 'BAD_REQUEST', description: e.to_s)
    end

    def render_server_errors(e) # rubocop:disable Naming/MethodParameterName
      render_errors('Internal Server Error', status_code: 500, code: 'INTERNAL_SERVER_ERROR', description: e.to_s)
    end
  end
end
