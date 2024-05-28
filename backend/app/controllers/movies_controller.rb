# frozen_string_literal: true

class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = Movie.includes([:uploader]).all

    render json: @movies, each_serializer: Serializers::Movie, root: :data, adapter: :json_api
  end

  # POST /movies
  def create
    @movie = Commands::Movie::Create.new(current_user, movie_params).exec
    render json: @movie, serializer: Serializers::Movie, root: :data, adapter: :json
  end

  private

    # Only allow a list of trusted parameters through.
    def movie_params
      params.permit(:youtube_url)
    end
end
