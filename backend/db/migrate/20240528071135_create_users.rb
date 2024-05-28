class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|

      t.string :email, index: { unique: true }
      t.string :password

      t.timestamps
    end
  end
end
