# frozen_string_literal: true

module Commands
  module Auth
    class Register
      def initialize(user, params)
        @user = user
        @params = params
      end

      def exec
        raise Errors::Auth::UserExist, @user[:email] if @user.present?

        @user = User.create!(@params)

        Login.new(@user, @params).exec
      end
    end
  end
end
