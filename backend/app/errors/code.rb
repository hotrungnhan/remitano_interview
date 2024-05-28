# frozen_string_literal: true

module Errors
  module Code
    app_namespace = 'app-name'
    SERVER_ERR = "#{app_namespace}.1_server_error".freeze
    RECORD_NOT_FOUND_ERR = "#{app_namespace}.2_record_not_found_error".freeze
    FILE_NOT_FOUND_ERR = "#{app_namespace}.3_file_not_found_error".freeze
    AUTHENTICATION_ERR = "#{app_namespace}.4_authentication_error".freeze
    AUTHORIZATION_ERR = "#{app_namespace}.5_authorization_error".freeze
    PARAMETER_MISSING_ERR = "#{app_namespace}.6_parameter_missing_error".freeze
    VALIDATION_ERR = "#{app_namespace}.7_validation_error".freeze
    EXPIRED_TOKEN_ERR = "#{app_namespace}.8_expired_token".freeze
    TOKEN_ERR = "#{app_namespace}.0_token_validation_error".freeze
    PAGE_PARAM_SMALLER_THAN_MIN_ERR = "#{app_namespace}.9_page_params_smaller_than_min".freeze
    PER_PAGE_PARAM_SMALLER_THAN_MIN_ERR = "#{app_namespace}.10_per_page_params_smaller_than_min".freeze
    PER_PAGE_PARAM_LARGER_THAN_MAX_ERR = "#{app_namespace}.11_per_page_params_larger_than_max".freeze
    PERMISSION_POLICY_CLASS_ERR = "#{app_namespace}.12_permission_policy_class_not_defined".freeze
    NO_PERMISSION_ERR = "#{app_namespace}.13_no_permission".freeze
    INVALID_PARAMETER = "#{app_namespace}.14_invalid_parameter".freeze
  end
end
