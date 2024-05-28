# frozen_string_literal: true

module Serializers
  class Movie < ActiveModel::Serializer
    attributes :id, :youtube_id, :title, :description

    attributes :metadata, :uploader

    def metadata
      {
        upvote: object.up_vote,
        downvote: object.down_vote
      }
    end

    def uploader
      nil if object.uploader.nil?
      User.new(object.uploader).as_json
    end
  end
end
