# frozen_string_literal: true

class SetupUlid < ActiveRecord::Migration
  def change
    enable_extension :ulid
  end
end
