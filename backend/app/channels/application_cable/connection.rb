# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user ||= User.find_by(id: cookies.encrypted[:user_id])
      reject_unauthorized_connection if self.current_user.present?
    end
  end
end
