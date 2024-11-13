# frozen_string_literal: true

module Serializers
  class ApplicationSerializer < Blueprinter::Base
    fields :id, :created_at, :updated_at
  end
end
