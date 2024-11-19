# frozen_string_literal: true

module Serializers
  class User < ApplicationSerializer
    fields :email
    view :public do
      excludes :created_at, :updated_at
    end

    view :private do
      fields :role
    end
  end
end
