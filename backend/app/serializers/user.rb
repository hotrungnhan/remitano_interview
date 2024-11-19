# frozen_string_literal: true

module Serializers
  class User < ApplicationSerializer
    view :public do
      fields :email
    end

    view :private do
      include_view :public
      fields :role
    end
  end
end
