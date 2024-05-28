# frozen_string_literal: true

class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notification_global'
  end

  def unsubscribed
    stop_all_streams
  end
end
