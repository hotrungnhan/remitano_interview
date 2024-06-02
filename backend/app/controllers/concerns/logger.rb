# frozen_string_literal: true

module Concerns
  module Logger
    extend ActiveSupport::Concern
    included do
      def logger
        ActionController::Base.logger
      end
    end
  end
end
