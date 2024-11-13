# frozen_string_literal: true

module Serializers
  class Movie < ApplicationSerializer
    fields :youtube_id, :title, :description

    association :uploader, blueprint: User

    field :metadata do |movie, _options|
      {
        upvote: movie.up_vote,
        downvote: movie.down_vote
      }
    end

    field :embedded_url do |movie, _options|
      "https://www.youtube.com/embed/#{movie[:youtube_id]}"
    end
  end
end
