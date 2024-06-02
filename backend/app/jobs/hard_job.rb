# frozen_string_literal: true

class HardJob < ApplicationJob
  def perform(*args)
    # Do something
    sleep(10)
  end
end
