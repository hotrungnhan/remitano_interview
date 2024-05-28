# frozen_string_literal: true

class AuthSerializer < ActiveModel::Serializer
  attributes :access_token

  def access_token
    object[:access]
  end
end
