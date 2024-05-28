# frozen_string_literal: true

module Serializers
  class Auth < ActiveModel::Serializer
    attributes :access_token

    def access_token
      object[:access]
    end
  end
end
