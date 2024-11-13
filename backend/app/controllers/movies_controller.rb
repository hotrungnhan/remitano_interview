# frozen_string_literal: true

class MoviesController < ApplicationController
  skip_before_action :authorize_access_request!, only: %i[index]
  # GET /movies
  def index
    @movies = Movie.includes([:uploader]).order('created_at desc').all

    render json: @movies, each_serializer: Serializers::Movie, root: :data
  end

  # POST /movies
  def create
    with_validated_params!(Validations::Movies::CreateParams) do
      @movie = Commands::Movie::Create.new(current_user, params).exec
      render json: @movie, serializer: Serializers::Movie, root: :data
    end
  end
end
