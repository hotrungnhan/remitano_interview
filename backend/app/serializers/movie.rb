# frozen_string_literal: true

module Serializers
  class Movie < ActiveModel::Serializer
    attributes :id, :youtube_id, :title, :description

    attributes :metadata, :uploader, :embedded_url

    def metadata
      {
        upvote: object.up_vote,
        downvote: object.down_vote
      }
    end

    def embedded_url
      "https://www.youtube.com/embed/#{object[:youtube_id]}"
    end

    def uploader
      nil if object.uploader.nil?
      User.new(object.uploader).as_json
    end
  end
end
