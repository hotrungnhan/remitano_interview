# frozen_string_literal: true

module Serializers
  class User < ApplicationSerializer
    identifier :id
    fields :email, :role

    view :public do
      fields :id, :email
    end

    view :private do
      include_view :public
      fields :role
    end
  end
end
