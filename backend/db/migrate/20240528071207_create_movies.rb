# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies, id: :ulid do |t|

      t.string :youtube_id
      t.integer :up_vote
      t.integer :down_vote
      t.string :title
      t.string :description

      t.belongs_to :uploader, type: :ulid, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
