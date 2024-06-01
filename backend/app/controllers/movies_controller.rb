# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :authorize_access_request!, only: %i[index]
  # GET /movies
  def index
    @movies = Movie.includes([:uploader]).order('created_at desc').all

    render json: @movies, each_serializer: Serializers::Movie
  end

  # POST /movies
  def create
    @movie = Commands::Movie::Create.new(current_user, movie_params).exec
    render json: @movie, serializer: Serializers::Movie
  end

  private

    # Only allow a list of trusted parameters through.
    def movie_params
      params.permit(:youtube_url)
    end
end
