class AddRoleToUserAndPrivacyToMovie < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :string
    add_column :movies, :privacy, :string
  end
end
