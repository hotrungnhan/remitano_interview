# frozen_string_literal: true

module Serializers
  class Users < ActiveModel::Serializer
    attributes :email
  end
end
