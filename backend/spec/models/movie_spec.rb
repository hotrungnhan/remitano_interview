# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :ulid             not null, primary key
#  description :string
#  down_vote   :integer
#  privacy     :string
#  title       :string
#  up_vote     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uploader_id :ulid
#  youtube_id  :string
#
# Indexes
#
#  index_movies_on_uploader_id  (uploader_id)
#
# Foreign Keys
#
#  fk_rails_...  (uploader_id => users.id)
#
require 'rails_helper'

RSpec.describe Movie do
  let(:user) { create(:user) }
  let(:movie) { create(:movie, uploader: user) }

  it { expect(movie).to be_valid }
end
