# frozen_string_literal: true

module Serializers
  class UserAuthenticated < User
    field(:permissions, if: lambda { |_, _, options|
      !options[:permissions].nil?
    }) do |_user, options|
      options[:permissions]
    end
  end
end
