# frozen_string_literal: true

module Serializers
  class User < ActiveModel::Serializer
    attributes :id, :email
  end
end
