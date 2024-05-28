# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :uuid             not null, primary key
#  description :string
#  down_vote   :integer
#  title       :string
#  up_vote     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uploader_id :uuid
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
  it { is_expected.to be_valid }
end
