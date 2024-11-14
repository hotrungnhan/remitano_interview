# frozen_string_literal: true

module Validations
  module Auths
    class Login < ApplicationValidation
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end
    end

    class SignUp < ApplicationValidation
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end
    end
  end
end
