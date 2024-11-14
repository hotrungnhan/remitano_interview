# frozen_string_literal: true

module Errors
  module Auth
    class UserExist < ApplicationError
      def initialize(email)
        super('User exists',
         status_code: 400,
         code: 'USER_EXIST',
         type: 'VALIDATION',
         details: [
           {
             field: 'email',
             message: "Duplicate with email = #{email}"
           }
         ])
      end
    end

    class Login < ApplicationError
      def initialize(email)
        super('Login Failed',
        status_code: 401,
        code: 'LOGIN_FAIL',
        description: "User with email='#{email}' not found or password is incorrect")
      end
    end
  end
end
