# frozen_string_literal: true

module Serializers
  class ApplicationSerializer < Blueprinter::Base
    identifier :id
    fields :created_at, :updated_at
  end
end
