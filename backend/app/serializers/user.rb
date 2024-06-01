# frozen_string_literal: true

module Serializers
  class User < Blueprinter::Base
    fields :id, :email
  end
end
