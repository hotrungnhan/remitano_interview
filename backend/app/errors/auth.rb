# frozen_string_literal: true

module Errors
  module Auth
    class UserExist < Base
      def initialize(msg = 'Bad youtube url',
                     error_code_id: ErrorCode::PARAMETER_MISSING_ERR,
                     error_code_data: nil)
        super
      end
    end

    class NoUser < Base
      def initialize(msg = 'Invalid Login',
                     error_code_id: ErrorCode::AUTHORIZATION_ERR,
                     error_code_data: nil)
        super
      end
    end

    class PasswordMismatch < Base
      def initialize(msg = 'Password Mismatch',
                     error_code_id: ErrorCode::AUTHORIZATION_ERR,
                     error_code_data: nil)
        super
      end
    end
  end
end
