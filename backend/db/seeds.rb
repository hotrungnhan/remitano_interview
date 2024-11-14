# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

image_key = "others/loading_fail.png"
unless ActiveStorage::Blob.exists?(key: image_key)
  ActiveStorage::Blob.create_and_upload!(
                                           key: image_key,
                                           filename: "loading_fail.png",
                                           io: File.open(Rails.root.join("db/dummy.png"), 'rb')
                                          )
end
require 'faker'
require 'factory_bot'
u= User.create_with(email:"htnhan", password: "123456").find_or_create_by(email:"htnhan")

FactoryBot.create_list(:movie, 100, uploader: u )
