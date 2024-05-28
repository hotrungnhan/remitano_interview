# frozen_string_literal: true

module Commands
  module Auth
    class Login
      def initialize(user, params)
        @user = user
        @params = params
      end

      def exec
        raise Errors::Auth::NoUser if @user.blank?
        raise Errors::Auth::PasswordMismatch unless @user.authenticate(@params[:password])

        JWTSessions::Session.new(payload: { user_id: @user.id }).login
      end
    end
  end
end
