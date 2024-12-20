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
require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  it { expect(user).to be_valid }
end
