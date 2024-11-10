# frozen_string_literal: true

class SetupUlid < ActiveRecord::Migration[7.2]
  def change
    enable_extension :ulid
  end
end
