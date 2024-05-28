# frozen_string_literal: true

  module Api
    module Helpers
      module Localizer
        extend ActiveSupport::Concern

        included do
          around_action :switch_locale
          around_action :switch_timezone

          private

            def switch_locale(&action)
              locale = params[:locale] || I18n.default_locale
              I18n.with_locale(locale, &action)
            end

            def switch_timezone
              old_timezone = Time.zone
              Time.zone = params[:timezone] || old_timezone
              yield
            ensure
              Time.zone = old_timezone
            end
        end
      end
    end
  end
