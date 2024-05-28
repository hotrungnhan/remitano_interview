# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[index create]

  # GET /movies
  def index
    @movies = Movie.all

    render json: @movies, each_serializer: Serializers::Movie, root: :data
  end

  # POST /movies
  def create
    @movie = Commands::Movie::Create.new(current_user, movie_params).exec
    render json: @movie, serializer: Serializers::Movie, root: :data
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.permit(:youtube_url)
    end
end
