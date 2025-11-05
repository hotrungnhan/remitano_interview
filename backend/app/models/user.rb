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
class User < ApplicationRecord
  has_secure_password
  # Add enum validation for role and privacy
  enum :role, {
    admin: 'admin',
    uploader: 'uploader',
    normal: 'normal'
  }, default: 'normal'
end
