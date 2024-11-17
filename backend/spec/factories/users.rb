# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :ulid             not null, primary key
#  email           :string
#  password_digest :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_at_id   :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.base64(urlsafe: true) }
  end
end
