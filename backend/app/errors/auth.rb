# frozen_string_literal: true

module Errors
  module Auth
    class UserExist < ApplicationError
      def initialize(email)
        super('User exists',
         status_code: 400,
         code: 'USER_EXIST',
         type: 'DATABASE_VALIDATION',
         details: [
           {
             field: 'email',
             message: "Duplicate with email='#{email}'"
           }
         ])
      end
    end

    class LoginFailed < ApplicationError
      def initialize(email)
        super('Login Failed',
        status_code: 401,
        code: 'LOGIN_FAILED',
        type: 'DATABASE_VALIDATION',
        description: "User with email='#{email}' not found or password is incorrect")
      end
    end
  end
end
