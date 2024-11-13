# frozen_string_literal: true

module Errors
  module Auth
    class UserExist < ApplicationError
      def initialize(msg = 'UserExist',
                     error_code_id: Errors::Code::INVALID_PARAMETER,
                     error_code_data: nil)
        super
      end
    end

    class NoUser < ApplicationError
      def initialize(msg = 'NoUser',
                     error_code_id: Errors::Code::AUTHORIZATION_ERR,
                     error_code_data: nil)
        super
      end
    end

    class PasswordMismatch < ApplicationError
      def initialize(msg = 'PasswordMismatch',
                     error_code_id: Errors::Code::AUTHORIZATION_ERR,
                     error_code_data: nil)
        super
      end
    end
  end
end
