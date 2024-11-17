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
class Movie < ApplicationRecord
  belongs_to :uploader, class_name: 'User'

  enum :privacy,
       { public: 'public', private: 'private' },
       prefix: :privacy,
       default: 'public'
end
