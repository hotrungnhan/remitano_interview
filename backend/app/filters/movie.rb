# frozen_string_literal: true

module Filters
  class Movie < ApplicationFilter
    keys :privacy, :title, :upvote, :downvote, :created_at, :uploader_id
    default_query ::Movie.all

    def by_title
      process_matchable_column(query, :title, params[:title])
    end

    def by_privacy
      process_list_column(query, :privacy, params[:privacy])
    end

    def by_upvote
      process_comparation_column(query, :up_vote, params[:upvote])
    end

    def by_downvote
      process_comparation_column(query, :up_vote, params[:upvote])
    end

    def by_created_at
      process_comparation_column(query, :created_at, params[:created_at])
    end

    def by_uploader_id
      process_list_column(query, :uploader_id, params[:uploader_id])
    end
  end
end
