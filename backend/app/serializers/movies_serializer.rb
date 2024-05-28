# frozen_string_literal: true

class MoviesSerializer < ActiveModel::Serializer
  attributes :id, :youtube_id, :title, :description

  attributes :metadata, :uploaders

  def metadata
    {
      upvote: object.up_vote,
      downvote: object.down_vote
    }
  end

  def uploaders
    nil if object.uploader.nil?
    UsersSerializer.new(object.uploader).as_json
  end
end
