# frozen_string_literal: true

module Serializers
  class Auth < Blueprinter::Base
    field :access_token do |auth, _options|
      auth[:access]
    end
  end
end
