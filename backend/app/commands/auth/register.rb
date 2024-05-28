# frozen_string_literal: true

module Commands
  module Auth
    class Register
      def initialize(user, params)
        @user = user
        @params = params
      end

      def exec
        raise User::ExistErr if @user.present?

        @user = User.create!

        Commands::Login.new(@user, params)
      end
    end
  end
end
