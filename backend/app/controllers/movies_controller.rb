# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[index create]

  # GET /movies
  def index
    @movies = Movie.all

    render json: @movies, each_serializer: MovieSerializer, root: :data
  end

  # POST /movies
  def create
    @movie = Commands::Movie::Create(current_user, movie_params)
    render json: @movie, serializer: MovieSerializer, root: :data
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
